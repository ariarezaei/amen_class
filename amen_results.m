function [ AMEN ] = amen_results( A, F )
[~, ~, AMEN] = amen_rank(...
    A, F, 'norm', 'L2', 'min_degree', 0, 'max_degree', inf);
end

