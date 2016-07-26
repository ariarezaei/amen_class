function addedA = addTrim(a, b, totSize)
    
    addedA = [a b];
    addedA = addedA(1:min(numel(addedA),totSize));
end