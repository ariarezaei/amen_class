function [ partition,  total_score] = AssingAllFeatures( Xs )
%SWP_GREEDY Summary of this function goes here
%   Detailed explanation goes here

    k_classes = numel(Xs);
    num_features = size(Xs{1},2);

    partition = cell(1,k_classes);
   
    for feature = 1:num_features
        for k = 1:k_classes
            partition{k} = [partition{k} feature];      
        end
    end
    
    total_score = amen_class_score(Xs, partition);
end

