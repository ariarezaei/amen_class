function [bestC, bestAcc, fw, info] = lasso_gridSearch(D, y, w, cRange)

bestC = -1;
bestAcc = -1;
bestFeatNum = -1;

info = [];
for c=cRange
    acc = lasso_check(D,y,w,c);
    info(end+1,1) = c;
    info(end,2) = acc;
    model = lasso_do(D,y,w,c);
    info(end,3) = sum(model.w ~= 0);
    
    if ((acc > bestAcc) && (info(end,3) > 2))
        bestAcc = acc;
        bestC = c;
        bestFeatNum = info(end,3);
%     elseif (acc == bestAcc && (info(end,3) > bestFeatNum))
%         bestAcc = acc;
%         bestC = c;
%         bestFeatNum = info(end,3);
    end
end
% 
% fprintf('\n\n');
% fprintf('Finding the model with best C\n');
model = lasso_do(D,y,w,bestC);
fw = model.w;

end