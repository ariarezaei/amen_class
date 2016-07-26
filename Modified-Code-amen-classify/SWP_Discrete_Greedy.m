function [ partition,  total_score] = SWP_Discrete_Greedy( Xs )
%SWP_GREEDY Summary of this function goes here
%   Detailed explanation goes here

    k_classes = numel(Xs);
    num_features = size(Xs{1},2);

    partition = cell(1,k_classes);
    
    for feature = 1:num_features
        
        scores = zeros(k_classes,1);
        for k = 1:k_classes
            test = [partition{k} feature];
            
            % compute change in score
            scores(k) = sfo_amen_l2_score(Xs{k}, test) - sfo_amen_l2_score(Xs{k}, partition{k});
        end
        
        % our obj. is sum(class_i) + sum(class_i+1) + ...
        % so whichever class is increased the most is the best place to
        % greedily put this feature
        
        [~, best_ind] = max(scores);
        
        partition{best_ind} = [partition{best_ind} feature];    
    end
    
    total_score = amen_class_score(Xs, partition);
end

