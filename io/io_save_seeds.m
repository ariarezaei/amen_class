function io_save_seeds( member, outpath )

dlmwrite(outpath, member, 'precision' ,'%.0f');

end

