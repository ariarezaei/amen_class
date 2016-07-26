
load dataset\amazon-Video.mat
[~,idx] = util_findByFeatureName(F_label, '13');
[F, F_label] = util_removeFeatureById(F, F_label, idx);

feats = {'Animation'; 'Classics'};
classes = feats;
graph_name = dataset_name;
% [amen_res, lasso_res, freq_res, amen_obj] = main_do(A, F, F_label, ...
%     dataset_name, feats, feats);
main_do;

io_stability(amen_res, 'output/anim_cls_amen.txt', 20);
io_freqFeatures(freq_res, 'output/anim_cls_freq.txt', 20);
io_lassoFeatures(lasso_res, 'output/anim_cls_lass.txt', 20);

f = figure();
barh(cell2mat(amen_obj(:,2)));
set(gca, 'YTickLabel', amen_obj(:,1));
set(f, 'Units', 'inches');
set(f, 'Position', [0 0 5 2]);
title('Animation v. Classics Objective Functions');

save('Experiments/results/animation_classics.mat', ...
    'amen_res', 'lasso_res', 'freq_res', 'amen_obj');

