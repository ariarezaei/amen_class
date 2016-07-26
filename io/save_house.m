for i=103:110
    load(['dataset/house_' num2str(i) '.mat']);
    outpath = ['cpp/graph/house_' num2str(i) '.edge'];
    fprintf('Output path = %s\n', outpath);
    io_save_graph_cpp(A, outpath);
end