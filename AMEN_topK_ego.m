function [ res, featCircles, Xs ] = AMEN_topK_ego( A, F, F_label, feats, k)

% res, coms, comInfo, totSeen

k_feats = size(F,2);
n_nodes = size(A,1);
m_targets = numel(feats);

featid = zeros(m_targets,1);
for target=1:m_targets
    featid(target) = util_findFeature(F_label, feats{target});
end

featCircles = cell(m_targets,1);
for node=1:n_nodes
    for target=1:m_targets
        if (F(node,featid(target)) == 1)
            egoNet = find(A(node,:));
            if (numel(egoNet) > 3)
                featCircles{target}{end+1,1} = egoNet;
            end
        end
    end
end

Xs = cell(m_targets,1);
for target=1:m_targets
    % Finding AMEN weights for each of the features
    [~, ~, Xs{target}] = amen_circle_rank(A, F, featCircles{target}, 'norm', 'L2');
    Xs{target}(Xs{target}<0) = 0;
end

Finding features that have zero AMEN weight in all categories
zeroFeat = zeros(1,k_feats);
for i=1:m_targets
    sumX = sum(Xs{i});
    zeroFeat = zeroFeat | (sumX == 0);
end
% 
fprintf('There are %d/%d 0 features\n', sum(zeroFeat), k_feats);

F_label = F_label(~zeroFeat);
allCatsHaveFeat = 1;
for i=1:m_targets
    Xs{i} = Xs{i}(:,~zeroFeat);
    if (size(Xs{i},2) == 0)
        allCatsHaveFeat = 0;
    end
end

res = [];

if (allCatsHaveFeat == 1)
    [res,~] = SWP_Lazy_Greedy(Xs, k);
else
    res = [];
end

res_label = cell(m_targets,1);
for target=1:m_targets
    res_label{target} = F_label(res{target});
end
end

