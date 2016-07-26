function io_save_graph_cpp( A, outpath )

[r,c] = find(A);
edges = [r,c];
dlmwrite(outpath, edges, 'Delimiter', '\t', 'precision' ,'%.0f');

end

