
load dataset\amazon-Video.mat

[~, idx] = util_findByFeatureName(F_label, 'years');
[F, F_label] = util_removeFeatureById(F, F_label, idx);
feats = {'Under 13'; 'Over 13'};
classes = feats;
% [amen_res, lasso_res, freq_res, amen_obj] = main_do(A, F, F_label, ...
%     dataset_name, feats, feats);

main_do;

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
