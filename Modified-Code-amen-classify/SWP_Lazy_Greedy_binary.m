function [feats, totalScore] = SWP_Lazy_Greedy_binary( Xs, K )

    n_class = numel(Xs);
    k_feats = size(Xs{1},2);
    
    feats = cell(n_class,1);
    
    % value(i,j) = the value of feature j for class i
    value = zeros(n_class,k_feats);
    for cls=1:n_class
        value(cls,:) = sum(abs(Xs{cls}),1);
    end
    
    % candids are the top k retrieved features.
    % They will be distributed among two classes
    candids = cell(n_class,1);
    
    while ((numel(feats{1}) < K) || (numel(feats{2}) < K))
        fprintf('(%d/%d)\t(%d/%d)\n', numel(feats{1}), K, numel(feats{2}), K);
        % 1. Find candidates
        usedFeats = [feats{1} feats{2}];
        remFeats = k_feats - numel(usedFeats);
        for cls=1:n_class
            [candids{cls},~,~] = SWP_topK_Lazy_Greedy(Xs{cls}...
                ,min(K,remFeats), feats{cls}, usedFeats);
        end
        
        % The selected features are put into this cell array
        selected = cell(n_class,1);
        
        % 2. Add them to the features
        if (numel(feats{1}) >= K)
        % 2.1. If A has completed getting features
            selected{1} = [];
            selected{2} = candids{2};
        elseif (numel(feats{2}) >= K)
        % 2.2. If B has completed getting features
            selected{1} = candids{1};
            selected{2} = [];
        else
            % 2.3. If both need getting features
            % 2.3.1. Separate the candidates
            pure = cell(n_class,1);
            [pure{1},pure{2},common] = Utility_separate(candids{1},candids{2});
            
            % 2.3.2 Give the commons to the class with most value
            for i=1:numel(common)
                [~,ind] = max(value(:,common(i)));
                pure{ind} = [pure{ind} common(i)];
            end
            
            % 2.3.3 Fill in the selected
            selected = pure;
        end
        
        % 3. Fill in selected features with new values
        for cls=1:n_class
            feats{cls} = addTrim(feats{cls}, selected{cls}, K);
        end
    end
    
    totalScore = amen_class_score(Xs, feats);
end