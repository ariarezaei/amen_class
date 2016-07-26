function io_lassoFeatures(res, outpath, K)

file = fopen(outpath, 'w');

for cls=1:numel(res)
    
    fprintf(file, 'Class %d\n', cls);
    for i=1:min(K, size(res{cls},1))
        fprintf(file, '%s\t%.4f\t%.4f\n', res{cls}{i,1}, res{cls}{i,2}, res{cls}{i,3});
    end
    
    fprintf(file, '\n\n');
    
end

end