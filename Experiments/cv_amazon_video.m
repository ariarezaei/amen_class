load dataset/amazon-Video.mat

K = 10;
MIN_NODE = 50;
[F, F_label] = util_removeByFeatureName(F, F_label, '13');

feat_ass = stat_rank_assort(A, F, F_label);
good_feats = feat_ass(1:K, 3);

main_F = F;
main_label = F_label;

k_feats = numel(good_feats);
n_nodes = size(A,1);
% 
% coms = cell(k_feats, 1);
% Xs = cell(k_feats, 1);
% comHubs = cell(k_feats, 1);
% amenHubs = cell(k_feats, 1);
% sel_cols = cell(k_feats, 1);
% 
% for i=1:k_feats
%     
%     [C, F, F_label] = util_class(F, F_label, good_feats(i));
%     
%     [coms{i}, comHubs{i}, ~] = main_getComs(A, C, feats, feats, dataset_name);
%     tmp = false(n_nodes,1);
%     tmp(comHubs{i}) = true;
%     comHubs{i} = tmp;
%     
%     
% end

res = {};

for i=1:numel(good_feats)
    for j=(i+1):numel(good_feats)
        feats = {good_feats{i}; good_feats{j}};
        
        
        
        nodes = util_findMembers(F, F_label, feats);
        if (numel(nodes{1}) < MIN_NODE || numel(nodes{2}) < MIN_NODE)
            continue;
        end
        
        [amen, amen_vip] = cv_amen(A, F, F_label, dataset_name, feats);
        lasso = cv_lasso(F, F_label, feats);
        
        res{end+1,1} = [feats{1} ' vs. ' feats{2}];
        res{end, 2} = amen;
        res{end, 3} = amen_vip;
        res{end, 4} = lasso;
        
    end
end

amen_tot = cell2mat(res(:,2));
vip_tot = cell2mat(res(:,3));
lasso_tot = cell2mat(res(:,4));

amen_acc = mean(amen_tot);
vip_acc = mean(vip_tot);
lasso_acc = mean(lasso_tot);
