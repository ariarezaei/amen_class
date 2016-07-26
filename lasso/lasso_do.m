function model = lasso_do(D, y, w, c)

options = lasso_options(w,c, 'model');
model = train(y, sparse(D), options);
end