function [Xs, row] = main_filterNegativeScore(Xs, score)

row = {};
for cls = 1:numel(Xs)
    fprintf('%d/%d communities have negative score.\n', sum(score{cls} <= 0), size(Xs{cls},1));
    row{cls} = score{cls} > 0;
    Xs{cls} = Xs{cls}(row{cls},:);
end

end