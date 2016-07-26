function [Xs, col] = main_filterZeroRowCol(Xs)

k_feats = size(Xs{1},2);
m_targets = numel(Xs);

zeroFeat = zeros(1,k_feats);
for cls=1:m_targets
    sumX = sum(Xs{cls});
    fprintf('There are %d non-zero features for %d\n', sum(sumX > 0), cls);
    if (cls == 1)
        zeroFeat = sumX == 0;
    else
        zeroFeat = zeroFeat & (sumX == 0);
    end
end
col = ~zeroFeat;
fprintf('There are %d/%d non-zero features\n', sum(col), k_feats);

% Removing zero features
for cls=1:m_targets
    Xs{cls} = Xs{cls}(:,col);
end
% 
% % Removing zero communities
% for cls=1:m_targets
%     sumCom = sum(Xs{cls},2);
%     row{cls} = sumCom > 0;
%     Xs{cls} = Xs{cls}(row{cls},:);
% end

end