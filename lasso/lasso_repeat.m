function [ave_acc, ave_fw, var_fw] = lasso_repeat(F, hubs, cRange, K)

k_feats = size(F,2);

sumFw = [];
ave_acc = 0;
Ws = zeros(K,k_feats);

for test=1:K
    [D,w,y] = lasso_data(F, hubs);
    [~, bestAcc, curFw, ~] = lasso_gridSearch(D,y,w, cRange);
    
    ave_acc = ave_acc + bestAcc;
%     if (test == 1)
%         sumFw = curFw;
%     else
%         sumFw = sumFw + curFw;
%     end
    if (size(curFw,1) == 1)
        curFw = curFw';
    end
    Ws(test,:) = curFw;
end

ave_acc = ave_acc / K;
ave_fw = mean(Ws);
var_fw = var(Ws);

end