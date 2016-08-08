function [acc, vip_acc] = cv_amen(A, F, F_label, dataset_name, feats)
% (A, F, coms, comHubs, Xs, amenHubs, new_col, feats)
is_binary = (numel(unique(F(:))) == 2);
continous_features = ~is_binary;

degrees = sum(A,2);
M = nnz(A)/2;
p_norm = 'L2';
m_classes = numel(feats);

% Finding features to do the initial classification
[C, F, F_label] = util_class(F, F_label, feats);


[coms, comHubs, ~] = main_getComs(A, C, feats, feats, dataset_name);
[Xs, ~, amenHubs, new_label, new_col] = main_getAmenWeights(A, F, F_label, ...
    feats, coms, comHubs);


newF = F(:,new_col);
F_transpose = newF';

pred = [];
vip_pred = [];

count = 0;
for cls = 1:m_classes
    fprintf('Class %d in %s vs. %s\n', cls, feats{1}, feats{2});
    for i=1:numel(comHubs{cls})
        fprintf(repmat('\b', 1, count));
        count = fprintf('%d/%d', i, numel(comHubs{cls}));
        com_idx = comHubs{cls}(i);
        amen_idx = amenHubs{cls} ~= com_idx;
        newXs{cls} = Xs{cls}(amen_idx,:);
        newXs{3 - cls} = Xs{3 - cls};
        [newPart, ~, ~, ~] = main_partition(newXs, feats, new_label);
        
        this_F = F_transpose(newPart{cls},:);
        [~, this_score, ~] = amen_learn_weights( A, [], coms{cls}{i}, degrees, ...
            M, p_norm, @amen_objective, this_F, continous_features );   
        
        other_F = F_transpose(newPart{3-cls},:);
        [~, other_score, ~] = amen_learn_weights( A, [], coms{cls}{i}, degrees, ...
            M, p_norm, @amen_objective, other_F, continous_features );   
        
        if (this_score > other_score)
            pred(end+1) = true;
        else
            pred(end+1) = false;
        end
        
        if (sum(amen_idx) < numel(amen_idx))
            vip_pred(end+1) = pred(end);
        end
        
    end
    count = 0;
    fprintf('\n');
end

acc = sum(pred == true) / numel(pred);
vip_acc = sum(vip_pred == true) / numel(vip_pred);

end