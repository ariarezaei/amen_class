function [ best_partition, best_score] = SWP_Brute( Xs )
%SWP_BRUTE Summary of this function goes here
%   Input:  k (m example x n item) matrices for each of the k classes

    k_classes = numel(Xs);
    num_features = size(Xs{1},2);

    partitions = SetPartition(1:num_features, k_classes);
    
    % Add partitions where one set takes all
    full_set = 1:num_features;
    for i=1:k_classes
        iPartition = {1,k_classes};
        for j=1:k_classes
            if(j == i)
                iPartition{j} = full_set;
            else iPartition{j} = [];
            end
        end
        partitions = [partitions ; {iPartition}];
    end
    
    %TODO: Cover the case when we have more than 2 classes and a partition
    %like [1,2], [3], []
    
    % Iterate through permuations of partitions to classes (ughh)
   
    assignments = perms(1:k_classes);
    scores = [];
    assigns = [];%zeros(size(partitions,1)*size(assignments,1),1);
    parts = [];
    for j=1:size(assignments,1)
        for i=1:numel(partitions)
            partition = partitions{i};
            
            assignment = partition(assignments(j,:));
            scores(end+1) = amen_class_score(Xs, assignment);
            parts(end+1) = i;
            assigns(end+1) = j;
        end
    end
    
    [best_score, best_ind] = max(scores);
    
    best_partition = partitions{parts(best_ind)};
    best_assignment = assignments(assigns(best_ind),:);
    best_partition = best_partition(best_assignment);
end

