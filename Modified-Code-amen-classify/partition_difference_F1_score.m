function [ score ] = partition_difference_F1_score( best_partitions, partitions_evaluated )
    %first class is the positive label(C+), second class is the negative
    %label (C-)
    true_positive_score = numel(intersect(best_partitions{1}, partitions_evaluated{1}));
    true_negative_score = numel(intersect(best_partitions{2}, partitions_evaluated{2}));
    false_positive_score = numel(setdiff(best_partitions{1}, partitions_evaluated{1}));
    false_negative_score = numel(setdiff(best_partitions{2}, partitions_evaluated{2}));
    precision = true_positive_score / (true_positive_score + false_positive_score);
    recall = true_negative_score / (true_negative_score + false_negative_score);
        
    F1score = (2 * true_positive_score) / ((2 * true_positive_score) + false_positive_score + false_negative_score); 
    score = F1score;
end

