function options = lasso_options(w, c, type)

if (strcmpi(type, 'cv') == 1)
    options = sprintf('-s 6 -c %f -w-1 %f -w1 %f -v 5 -q', c, w(1), w(2));
else
    options = sprintf('-s 6 -c %f -w-1 %f -w1 %f -q', c, w(1), w(2));
end

end