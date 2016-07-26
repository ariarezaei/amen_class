function io_save_cpp(A, seeds, outpath)

io_save_seeds(seeds, [outpath '.seed']);
io_save_graph_cpp(A, [outpath '.edge']);

end

