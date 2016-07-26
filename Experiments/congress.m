% utils = {};
% util_labels = {};
% final_parts = {};
% comScores = {};
% connectivity_threshold = .95;

amen_res = {};
freq_res = {};
lasso_res = {};
amen_obj = {};

for congNum = 103:110
    idx = congNum - 103 + 1;
    
    % Get the dataset
    load(['dataset\house_' num2str(congNum) '.mat']);
%     load dataset\policy.mat;
    [F,F_label, feats] = util_addPartyToFeatures(F, F_label, P);
    
    dataset_name = ['house_' num2str(congNum)];
    [amen_res{idx}, lasso_res{idx}, freq_res{idx}, amen_obj{idx}] = ...
        main_do(A, F, F_label, dataset_name, feats, feats);
    
    
    
%     
%     X = F;
%     X_label = F_label;
%     F = util_selectFeatures(X,X_label, policy);
%     F_label = policy;
%     
%     [F,F_label,feats] = util_addPartyToFeatures(F,F_label, P);
%     A = util_sparsify(A, connectivity_threshold);
%     
%     [coms, hubs] = main_getEgos(A, F, F_label, feats);
%     [F,F_label] = util_removeFeatures(F, F_label, feats);
%     
%     [Xs, comScores{idx}, hubs, new_label] = main_getAmenWeights(A, F, F_label, feats, coms, hubs);
%     
%     [part, score, part_label] = main_partition(Xs, feats, new_label);
%     
%     [utils{idx}, util_labels{idx}, final_parts{idx}] = main_filterUtility(Xs, part, new_label, feats, .1);
%     
%     fprintf('\n');
%     
%     % ||||||||||||||||||||
%     % REMOVE AFTER TESTING
%     break;
%     % REMOVE AFTER TESTING
%     % ||||||||||||||||||||
end