load dataset/gplus.mat;

[~, idx] = util_findByFeatureName(I_label, 'google');
C = util_superFeature(I, idx);
C = [C ~C];

feats = {'Googler'; 'non-Googler'};
classes = feats;

[F, F_label] = util_addFeature(NI, NI_label, C, feats);

classes = feats;
graph_name = dataset_name;

main_do;
