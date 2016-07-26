function io_saveFeatFrequency(stat, outpath)

file = fopen(outpath, 'w');
for i=1:size(stat,1)
    fprintf(file, '%s\t%d\n', stat{i,3}, stat{i,1});
end
fclose(file);

end