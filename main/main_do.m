% function [amen_res, lasso_res, freq_res, amen_obj] = main_do(A, F, F_label, dataset_name, classes, feats)

m_classes = numel(feats);

% Finding features to do the initial classification
[C, F, F_label] = util_class(F, F_label, classes);
main_F = [F C];
main_label = [F_label; feats];

if (strfind(dataset_name, 'house') > 0)
    
    
    load dataset\policy.mat;
    X = F;
    X_label = F_label;
    F = util_selectFeatures(X,X_label, policy);
    F_label = policy;
    
    if(size(F_label,1) == 1)
        F_label = F_label';
    end
    
    main_F = [F C];
    main_label = [F_label; feats];
    
    A = util_sparsify(A, .95);
end

% Finding communities around the features
if ((strfind(dataset_name, 'house') > 0))
    [coms, comHubs] = main_getEgos(A, C, feats, feats);
else
    [coms, comHubs, ~] = main_getComs(A, C, feats, feats, dataset_name);
end
[F,F_label] = util_filterComFeatures(coms, F, F_label);

% Finding AMEN weights
[Xs, ~, ~, new_label] = main_getAmenWeights(A, F, F_label, ...
    feats, coms, comHubs);

% Finding partitioning
[part, ~, ~, amen_obj] = main_partition(Xs, feats, new_label);

% Filtering by utility
[util, util_label, ~] = main_filterUtility(Xs, part, new_label, feats, .25);
for cls=1:numel(feats)
    part{cls} = util{cls}(:,1);
end

% Filtering by confidence/stability
exp_num = 100;
[ave_rank, var_rank] = stat_stabilityAll(Xs, part, feats, new_label, exp_num);

amen_res = cell(m_classes, 1);
for cls = 1:m_classes
    amen_res{cls} = cell(numel(util_label{cls}),3);
    for i=1:numel(util_label{cls})
        amen_res{cls}{i,1} = util_label{cls}{i};
        amen_res{cls}{i,2} = util{cls}(i,2);
        amen_res{cls}{i,3} = ave_rank{cls}(i);
        amen_res{cls}{i,4} = var_rank{cls}(i);
    end
    amen_res{cls} = sortrows(amen_res{cls}, 3);
end

% -------------------- LOGISTIC REGRESSION --------------------------
cRange = 2 .^ (-10:10);
F = main_F;
F_label =  main_label;
nodes = {};
for cls = 1:numel(feats)
    fid = util_findFeature(F_label, feats{cls});
    nodes{cls} = find(F(:,fid));
end
[F,F_label] = util_removeFeatures(F,F_label,feats);

K = 10;

[~, ave_fw,~] = lasso_repeat(F, nodes, cRange, K);
lasso_res = lasso_feature(ave_fw, F_label);

% ------------------------- FREQUENCY --------------------------------

if (strfind(dataset_name, 'house') > 0)
    F = [F C];
    F_label = [F_label; feats];
else
    F = main_F;
    F_label = main_label;
end
freq_res = main_featureFrequency(F, F_label, feats);

% end