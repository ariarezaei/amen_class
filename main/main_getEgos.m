function [coms, seeds] = main_getEgos(A, F, F_label, feats)

coms = cell(numel(feats),1);
seeds = cell(numel(feats),1);

for cls = 1:numel(feats)
    featid = util_findFeature(F_label, feats{cls});
    nodes = find(F(:,featid));
    seeds{cls} = nodes;
    for i=1:numel(nodes)
        coms{cls}{i,1} = find(A(nodes(i),:));
    end
end

end