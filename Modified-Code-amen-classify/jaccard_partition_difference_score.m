function [ score ] = jaccard_partition_difference_score( best_partitions, partitions_evaluated )
    partitionsNumber = numel(best_partitions);
    score = 0;
    for i=1:partitionsNumber
        part_intersection = intersect(best_partitions{i}, partitions_evaluated{i});
        part_union = union(best_partitions{i}, partitions_evaluated{i});
        inter_size = numel(part_intersection);
        union_size = numel(part_union);
        %score = score + pdist([best_partitions{i}; partitions_evaluated{i}], 'jaccard');
        score = score + ((union_size - inter_size) / union_size); 
    end
    score = score / partitionsNumber;
end

