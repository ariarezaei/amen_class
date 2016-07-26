function [feats, totalScore] = SWP_Lazy_Greedy_multiple( Xs, K )

    n_class = numel(Xs);
    k_feats = size(Xs{1},2);
    
    feats = cell(n_class,1);
    
    % value(i,j) = the value of feature j for class i
    value = zeros(n_class,k_feats);
    for cls=1:n_class
        value(cls,:) = sum(abs(Xs{cls}),1);
    end
    
    disp(size(value));
    
    % candids are the top k retrieved features.
    % They will be distributed among two classes
    candids = cell(n_class,1);
    
    while ((numel(feats{1}) < K) || (numel(feats{2}) < K))
        for cls=1:n_class
            fprintf('(%d/%d) ', numel(feats{cls}), K);
        end
        fprintf('\n');
        % 1. Find candidates
        usedFeats = [];
        for cls=1:n_class
            usedFeats = [usedFeats feats{cls}];
        end
        remFeats = k_feats - numel(usedFeats);
        fprintf('Remaining features: %d\n', remFeats);
        fprintf('Used features: [%s]\n', sprintf('%d ', usedFeats));
        for cls=1:n_class
            [candids{cls},~,~] = SWP_topK_Lazy_Greedy(Xs{cls}...
                ,min(K - numel(feats{cls}),remFeats), feats{cls}, usedFeats);
            fprintf('It needed %d features and there were %d features\n', ...
                K-numel(feats{cls}), remFeats);
            fprintf('Candids for Class#%d are %s\n', cls, ...
                sprintf('%d ', candids{cls}));
        end
        
        
        f_index = 1:k_feats;
        fval = zeros(n_class, k_feats);
        
        for cls=1:n_class
            for i=1:numel(candids{cls})
                fval(cls, candids{cls}(i)) = value(cls, candids{cls}(i));
            end
        end
        
        nzfeat = (sum(fval) > 0);
        f_index = f_index(nzfeat);
        fval = fval(:,nzfeat);
        
        selected = cell(n_class,1);
        for i=1:numel(f_index)
            [~,targetCls] = max(fval(:,i));
            selected{targetCls}(end+1) = f_index(i);
        end
        % The selected features are put into this cell array
%         
%         % 2. Add them to the features
%         if (numel(feats{1}) >= K)
%         % 2.1. If A has completed getting features
%             selected{1} = [];
%             selected{2} = candids{2};
%         elseif (numel(feats{2}) >= K)
%         % 2.2. If B has completed getting features
%             selected{1} = candids{1};
%             selected{2} = [];
%         else
%             % 2.3. If both need getting features
%             % 2.3.1. Separate the candidates
%             pure = cell(n_class,1);
%             [pure{1},pure{2},common] = Utility_separate(candids{1},candids{2});
%             
%             % 2.3.2 Give the commons to the class with most value
%             for i=1:numel(common)
%                 [~,ind] = max(value(:,common(i)));
%                 pure{ind} = [pure{ind} common(i)];
%             end
%             
%             % 2.3.3 Fill in the selected
%             selected = pure;
%         end
        
        % 3. Fill in selected features with new values
        for cls=1:n_class
            feats{cls} = addTrim(feats{cls}, selected{cls}, K);
        end
    end
    
    totalScore = amen_class_score(Xs, feats);
end