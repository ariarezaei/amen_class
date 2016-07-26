function [Xs, comScores, hubs, F_label] = main_getAmenWeights(A, F, F_label, feats, coms, hubs)

m_targets = numel(feats);

[F, F_label] = util_removeFeatures(F, F_label, feats);
Xs = {};
comScores = {};
for cls=1:numel(feats)
    % Finding AMEN weights for each of the features
    [~, comScores{cls}, Xs{cls}] = amen_circle_rank(A, F, coms{cls}, 'norm', 'L2');
    Xs{cls}(Xs{cls}<0) = 0;
end

[Xs, row] = main_filterNegativeScore(Xs, comScores);
for cls=1:m_targets
    hubs{cls} = hubs{cls}(row{cls});
    fprintf('%d rows had non-negative score for class %d.\n', ...
        sum(row{cls} == 1), cls);
end

[Xs, col] = main_filterZeroRowCol(Xs);
F_label = F_label(col);

end