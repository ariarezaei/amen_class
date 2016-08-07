function [ ranking, scores, data_scores ] = amen_circle_rank( A, X_Total, circles, varargin )
%AMEN_RANK Rank egonets by their amen circle normality score
%   Detailed explanation goes here

    % parameters
    parser = inputParser;
    addOptional(parser,'norm', 'L1'); 

    varargin{:};
    parse(parser, varargin{:});    

    p_norm = parser.Results.norm
    degrees = sum(A,2);
    M = nnz(A)/2;    
    X_Total_Transpose = X_Total.';
    
    ego_scores = zeros(1,numel(circles));       
    data_scores = zeros(numel(circles), size(X_Total,2));
    
    count = 0;
    is_binary = (numel(unique(X_Total(:))) == 2);
    if (is_binary == 1)
        fprintf('Features are binary.\n');
    else
        fprintf('Features are scalar.\n');
    end
    
    parfor i=1:numel(circles)          
        community = circles{i};
%         fprintf(repmat('\b', 1, count));
        count = fprintf('\tCom #%d/%d\tsize: %d\n', i, numel(circles),numel(circles{i}));
                       
        [~, weighted_score, cur_data_score] = amen_learn_weights( A, [], community, degrees,  M, p_norm, @amen_objective, X_Total_Transpose, ~is_binary );       
        
        ego_scores(i) = weighted_score;         
        data_scores(i,:) = cur_data_score;
    end
    fprintf('\n');
    
    % sort all circles by score
    [scores, ind] = sort(ego_scores);
    scores = scores';
    ranking = ind.';
    data_scores = data_scores(ind,:);
end

