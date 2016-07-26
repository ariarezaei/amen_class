function [part, score, part_label, obj] = main_partition(Xs, feats, F_label)

m_targets = numel(feats);

part = [];
part_label = [];
score = 0;

for cls=1:m_targets
    sumx = sum(Xs{cls});
    if (max(sumx) == 0)
        return;
    end
end

obj = cell(3,2);
obj{1,1} = 'SWP';
obj{2,1} = 'Simplified';
obj{3,1} = 'Top-20';

if (numel(F_label) <= 1000)
    [part, score] = SWP_Amen(Xs);
else
    part = [];
    score = -1;
end
obj{1,2} = score;
% fprintf('Score for SWP algorithm = %.5f\n', score);
[sPart, sScore] = Not_SWP(Xs);
obj{2,2} = sScore;
% fprintf('Score for simplified algorithm = %.5f\n', sScore);
if (sScore > score)
    part = sPart;
    score = sScore;
end

[~, tScore] = SWP_Lazy_Greedy(Xs, 20);
obj{3,2} = tScore;


part_label = cell(m_targets,1);
for target=1:m_targets
    part_label{target} = F_label(part{target});
end

end