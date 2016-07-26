function [chosen, class] = saveForCpp( A, F, featid, featname, outpath )
fprintf('This is featid: %s\n', sprintf('%d ',featid));

n = size(A,1);
% Finding related nodes
allBut = zeros(n,numel(featid));
pure = zeros(n, numel(featid));
F = F(:,featid);
k_feats = size(F,2);

for i=1:k_feats
    for j=1:k_feats
        if (j == i)
            continue;
        end
        allBut(:,i) = allBut(:,i) | (F(:,j) > 0);
    end
end

chosen = zeros(n,1);
for i=1:k_feats
    pure(:,i) = F(:,i) & (~allBut(:,i));
    fprintf('%d/%d of class "%s" are pure.\n', full(sum(pure(:,i))), full(sum(F(:,i))), featname{i});
    chosen = chosen | pure(:,i);
end
chosen = find(chosen);
class = zeros(numel(chosen),1);
for i=1:numel(class)
    for j=1:numel(featid)
        if (F(chosen(i),j) > 0)
            class(i) = j;
        end
    end
end
% DONE with finding related nodes as seed

[r,c] = find(triu(A));
edges = [r,c];

dlmwrite([outpath '.seed'], chosen, 'precision', '%.0f');
dlmwrite([outpath '.edge'], edges, 'Delimiter', '\t','precision', '%.0f');

end

