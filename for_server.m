load server.mat;

[Xs, comScores, amenHubs, new_label, ~] = main_getAmenWeights(A, F, F_label, ...
    feats, coms, comHubs);

save('AMEN_dblp.mat', 'Xs', 'comScores', 'amenHubs', 'new_label');

% Finding partitioning
[part, ~, ~, amen_obj] = main_partition(Xs, feats, new_label);

% Filtering by utility
[util, util_label, ~] = main_filterUtility(Xs, part, new_label, feats, .25);
for cls=1:numel(feats)
    part{cls} = util{cls}(:,1);
end

% Filtering by confidence/stability
exp_num = 100;
[ave_rank, var_rank, ave_util, var_util] = stat_stabilityAll(Xs, part, feats, new_label, exp_num);

amen_res = cell(m_classes, 1);
for cls = 1:m_classes
    amen_res{cls} = cell(numel(util_label{cls}),5);
    for i=1:numel(util_label{cls})
        amen_res{cls}{i,1} = util_label{cls}{i};
        amen_res{cls}{i,2} = ave_util{cls}(i);
        amen_res{cls}{i,3} = var_util{cls}(i);
        amen_res{cls}{i,4} = ave_rank{cls}(i);
        amen_res{cls}{i,5} = var_rank{cls}(i);
    end
    amen_res{cls} = sortrows(amen_res{cls}, [-2 -4]);
end

% -------------------- LOGISTIC REGRESSION --------------------------
cRange = 2 .^ (-10:10);
F = main_F;
F_label =  main_label;
nodes = util_findMembers(F, F_label, feats);

[F,F_label] = util_removeFeatures(F,F_label,feats);

K = 10;

[~, ave_fw,var_fw] = lasso_repeat(F, nodes, cRange, K);
lasso_res = lasso_feature(ave_fw, var_fw, F_label);