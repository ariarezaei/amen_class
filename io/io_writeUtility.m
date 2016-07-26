function io_writeUtility(util, util_label, cls, outpath)

file = fopen(outpath, 'w');

for i=1:numel(util_label{cls})
    fprintf(file, '%s\t%.5f\n', util_label{cls}{i}, util{cls}(i,2));
end

fclose(file);


end