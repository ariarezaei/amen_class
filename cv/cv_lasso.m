function [acc] = cv_lasso(F, F_label, feats)
cRange = 2 .^ (-5:2:5);
nodes = util_findMembers(F, F_label, feats);
[F,~] = util_removeFeatures(F,F_label,feats);
[D,y] = lasso_imbalanced_data(F, nodes);

acc = -1;
for c = cRange
    fprintf('C = %f\n', c);
    options = sprintf('-s 6 -c %.5f -v %d -q', c, numel(nodes{1}) + numel(nodes{2}));
    cur_acc = train(y, D, options);
    acc = max(cur_acc, acc);
end

end