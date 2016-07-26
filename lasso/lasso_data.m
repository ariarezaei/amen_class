function [D, w, y] = lasso_data(F, hubs)

maxNum = -1;
for cls=1:numel(hubs)
    if (numel(hubs{cls}) > maxNum)
        maxNum = numel(hubs{cls});
    end
end
% maxNum

for cls=1:numel(hubs)
    if (numel(hubs{cls}) < maxNum)
        hubs{cls} = randsample(hubs{cls}, maxNum, true);
    end
end

% hubs

w = ones(numel(hubs),1);
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