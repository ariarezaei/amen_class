function featStat = stat_comFeatStat(coms, F, F_label)

allNodes = [];
for i=1:numel(coms)
    allNodes = union(allNodes, coms{i});
end

F = F(allNodes,:);
sumF = full(sum(F));
posFeat = find(sumF > 0);

featStat = cell(numel(posFeat), 3);

for i=1:numel(posFeat)
    featStat{i,1} = sumF(posFeat(i));
    featStat{i,2} = posFeat(i);
    featStat{i,3} = F_label{posFeat(i)};
end

featStat = sortrows(featStat,[-1 2]);

end