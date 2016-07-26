function res = lasso_feature(w, v, F_label)

F_label = F_label(w ~= 0);
w = w(w ~= 0);
v = v(w ~= 0);

res = cell(2,1);
for i=1:numel(res)
    curW = [];
    curV = [];
    curLbl = {};
    if ( i == 1 )
        curW = w(w<0);
        curV = v(w<0);
        curLbl = F_label(w<0);
    else
        curW = w(w>0);
        curV = v(w>0);
        curLbl = F_label(w>0);
    end
    
    for j=1:numel(curW)
        res{i}{j,1} = curLbl{j};
        res{i}{j,2} = abs(curW(j));
        res{i}{j,3} = curV(j);
    end
    
    res{i} = sortrows(res{i}, -2);
end

end