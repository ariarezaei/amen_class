cls = 1;
K = 10;
% x = (1:size(lasso_stat{cls},1))/size(lasso_stat{cls},1);
x = 1:K;
% d = [cell2mat(amen_stat{cls}(x,2)) cell2mat(lasso_stat{cls}(x,2))];
plot(x, cell2mat(amen_stat{cls}(x,2)));
hold on;
plot(x, cell2mat(lasso_stat{cls}(x,2)));
% hold on;
% 
% % x = (1:size(amen_stat{cls},1))/size(amen_stat{cls},1);
% scatter(x, , 'filled');
