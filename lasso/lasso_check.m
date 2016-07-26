function acc = lasso_check(D, y, w, c)

options = lasso_options(w,c, 'cv');
% fprintf('%s\n', options);
acc = train(y, sparse(D), options);
end