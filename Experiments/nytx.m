load dataset/gplus.mat

classes = {{'bronx', 'queens, ny', 'queens, new york', 'manhattan', ', ny', 'new york,', 'nyc'}, {'texas', ', texas', 'tx'}};
[C, ~, ~] = util_class(P, P_label, classes);
feats = {'New Yorker'; 'Texan'};


[F, F_label] = util_addFeature(NP, NP_label, C, feats);
classes = feats;
graph_name = dataset_name;

main_do;



