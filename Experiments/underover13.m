
load dataset\amazon-Video.mat

feats = {'Under 13', 'Over 13'};
[amen_res, lasso_res, freq_res, amen_obj] = main_do(A, F, F_label, ...
    dataset_name, feats, feats);

io_stability(amen_res, 'output/uo13_amen.txt', 20);
io_freqFeatures(freq_res, 'output/uo13_freq.txt', 20);
io_lassoFeatures(lasso_res, 'output/uo13_lass.txt', 20);

f = figure();
barh(cell2mat(amen_obj(:,2)));
set(gca, 'YTickLabel', amen_obj(:,1));
set(f, 'Units', 'inches');
set(f, 'Position', [0 0 5 2]);
title('Under 13 v. Over 13 Objective Functions');

save('Experiments/results/under_over_13.mat', ...
    'amen_res', 'lasso_res', 'freq_res', 'amen_obj');