function [D, y] = lasso_imbalanced_data(F, hubs)

% w = zeros(numel(hubs),1);
% for i=1:numel(hubs)
%     w(i) = 1/numel(hubs{i});
% end
% w = w / min(w);

all = [];
y = [];
for i=1:numel(hubs)
    sz = numel(hubs{i});
    y = [y; ones(sz,1) * (-1) ^ i];
    all = [all; hubs{i}];
end

D = zscore(F(all,:));
% D = D(:,sum(D) ~= 0);

end