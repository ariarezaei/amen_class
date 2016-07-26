function [ res, resScore, res_label, Xs, coms, comInfo, totSeen, F_label ] = AMEN_topK( A, F, F_label, feats, graphname)

k_feats = size(F,2);
n_nodes = size(A,1);
m_targets = numel(feats);

featid = zeros(numel(feats),1);

fprintf('Finding feature IDs\n');
for i=1:numel(feats)
    featid(i) = util_findFeature(F_label, feats(i));
end


% 
% fprintf('Saving for Local Clustering file\n');
% [seeds, class] = saveForCpp(A, F, featid, feats, ['cpp/graph/' graphname]);



totSeen = zeros(numel(feats),1);
coms = cell(numel(feats),1);
comInfo = cell(numel(feats),1);
% comInfo{i}(j,1) = Class (i) Community (j)'s hub node
% comInfo{i}(j,2) = Class (i) Community (j)'s total nodes
for curCls = 1:numel(feats)
    % Saving SEEDS and FILE Structure for the local clustering code
    seeds = io_save_cpp(A, F, F_label, feats{curCls},...
        ['cpp\graph\' graphname]);

    cd cpp\
    % Running the local clustering code
    system(['LocalClustering.exe graph\' graphname '.edge graph\' ...
        graphname '.seed clusters\' graphname]);
    cd clusters\

    % Retrieving the results of local clustering code
    nonExisting = 0;
    emptyFile = 0;
    for i=1:numel(seeds)
        filename = [graphname '_' num2str(seeds(i)) '.cluster'];
        if (exist(filename, 'file'))
            s = dir(filename);
            if (s.bytes == 0)   % If the community file is empty
                emptyFile = emptyFile + 1;
                continue;
            end
            com = dlmread(filename)';

            % Updating total number of coms for class (i)
            totSeen(curCls) = totSeen(curCls) + 1;

            % Adding current com to the set of coms for class (i)
            coms{curCls}{totSeen(curCls),1} = com;

            % Adding the seed ID and community size
            comInfo{curCls}(totSeen(curCls),1) = seeds(i);
            comInfo{curCls}(totSeen(curCls),2) = numel(com);
        else
            nonExisting = nonExisting + 1;
        end
    end

    system('rm *');
    cd ..\..\
end

% allComs = coms{1};
% for i=2:numel(feats)
%     for j=1:totSeen(i)
%         allComs{end+1} = coms{i}{j};
%     end
% end


[F, F_label] = util_removeFeatures(F, F_label, feats);
Xs = {};
for curCls=1:numel(feats)
    % Finding AMEN weights for each of the features
    [~, ~, Xs{curCls}] = amen_circle_rank(A, F, coms{curCls}, 'norm', 'L2');
    Xs{curCls}(Xs{curCls}<0) = 0;
end

% Finding features that have zero AMEN weight in all categories
zeroFeat = zeros(1,k_feats);
for i=1:m_targets
    sumX = sum(Xs{i});
    zeroFeat = zeroFeat | (sumX == 0);
end

% Removing zero features

F_label = F_label(~zeroFeat);
allCatsHaveFeat = 1;
for i=1:m_targets
    Xs{i} = Xs{i}(:,~zeroFeat);
    if (size(Xs{i},2) == 0)
        allCatsHaveFeat = 0;
    end
end

if (allCatsHaveFeat == 1)
    [res,resScore] = SWP_Amen(Xs);
else
    res = [];
end

res_label = cell(m_targets,1);
for target=1:m_targets
    res_label{target} = F_label(res{target});
end
fprintf('There are %d/%d 0 features\n', sum(zeroFeat), k_feats);
for i=1:m_targets
    sumx = sum(Xs{i});
    fprintf('There are %d/%d features 0 for class %d\n', sum(sumx==0), ...
        size(Xs{i},2), i);
end

% system('rm cpp/clusters/*');
% cd cpp\
% stat = system(['LocalClustering.exe graph\' graphname '.edge graph\' graphname...
%     '.seed clusters\' graphname]);
% cd clusters\
% 
% % Removing label features
% k_feat = size(F,2);
% F = F(:,setdiff(1:k_feat,featid));
% F_label = F_label(setdiff(1:k_feat,featid));
% % -----------------------
% 
% fprintf('Reading the new clusters\n');
% for i=1:numel(seeds)
%     filename = [graphname '_' num2str(seeds(i)) '.cluster'];
%     if (exist(filename, 'file'))
%         s = dir(filename);
%         if (s.bytes == 0)
%             continue;
%         end
% %         fprintf('%s\n', filename);
%         totSeen(class(i)) = totSeen(class(i)) + 1;
%         totSum = sum(totSeen);
%         curCom = dlmread(filename)';
%         coms{totSum,1} = curCom;
%         comInfo(totSum,1) = class(i);
%         comInfo(totSum,2) = seeds(i);
%     else
%     end
% end

% Filtering feature classes only to the ones that have an actual community
% comCls = comInfo(:,1);
% allCls = unique(comCls);
% fprintf('Remaining classes are %s\n', sprintf('%d ', allCls));
% feats = feats(allCls);
% featid = featid(allCls);
% 
% cd ..\..\
% 
% [~,~, AMEN] = amen_circle_rank(A, F, coms, 'norm', 'L2');
% AMEN(AMEN < 0) = 0;
% Xs = cell(numel(allCls),1);
% 
% % NO SUPPORT FOR WHEN THERE IS NO COMMUNITY FOR A CLASS
% for i=1:numel(allCls)
%     Xs{i} = AMEN(comCls == allCls(i),:);
% end
% 
% [res, ~] = SWP_Lazy_Greedy( Xs, k);
% 
% for i=1:numel(allCls)
%     res{i} = F_label(res{i});
% end


end

