function [ partition,  total_score] = SWP_Real_Greedy( Xs )

m_targets = numel(Xs);
k_feats = size(Xs{1},2);

total_score = 0;
partition = cell(m_targets,1);
remaining = 1:k_feats;

while (numel(remaining))
    
    marginal_score = zeros(numel(remaining), m_targets);
    for i = 1:numel(remaining)
        cur_feat = remaining(i);
        for j = 1:m_targets            
            backup = partition{j};
            partition{j} = [partition{j} cur_feat];
            
            marginal_score(i,j) = amen_class_score(Xs, partition) - ...
                total_score;
            
            partition{j} = backup;
        end
    end
    
    [max_addition,ind] = max(marginal_score(:));
    [best_feat_idx, best_cls] = ind2sub(size(marginal_score), ind);
    best_feat = remaining(best_feat_idx);
    
    partition{best_cls}(end+1) = best_feat;
    total_score = total_score + max_addition;
    remaining = setdiff(remaining, best_feat);
end

end

