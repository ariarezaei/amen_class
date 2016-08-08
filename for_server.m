load server.mat;
load dataset/dblp.mat;

index = true(numel(F_label), 1);
for i=1:2
    x = util_findFeature(F_label, feats{i});
    index(x) = false;
end

F = F(:,index);
F_label = F_label(index);

F(F > 0) = 1;
F(F ~= 1) = 0;

[Xs, comScores, amenHubs, new_label, ~] = main_getAmenWeights(A, F, F_label, feats, coms, comHubs);

save('AMEN_dblp.mat', 'Xs', 'comScores', 'amenHubs', 'new_label');

% Finding partitioning
[part, ~, ~, amen_obj] = main_partition(Xs, feats, new_label);

% Filtering by utility
[util, util_label, ~] = main_filterUtility(Xs, part, new_label, feats, .25);
for cls=1:numel(feats)
    part{cls} = util{cls}(:,1);
end

% Filtering by confidence/stability
exp_num = 1;
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
