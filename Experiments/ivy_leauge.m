load dataset/gplus.mat

schools = {
    'university:columbia'
    'university:columbia university'
    'university:columbia law school'
    'university:columbia business school'
    'university:harvard law school'
    'university:harvard medical school'
    'university:harvard business school'
    'university:harvard kennedy school'
    'university:harvard'
    'university:yale university'
    'university:yale school of music'
    'university:yale'
    'university:cornell college'
    'university:cornell university'
    'university:cornell law school'
    'university:cornell'
    'university:university of pennsylvania law school'
    'university:university of pennsylvania'
    'university:brown'
    'university:brown university'
    'university:dartmouth college'
    'university:princeton'
    'university:princeton university'
};

[C, ~, ~] = util_class_exact(U, U_label, schools);
C = sum(C,2) > 0;
C = [C ~C];

feats = {'Ivy Leauge'; 'Non Ivy League'};

[F, F_label] = util_addFeature(NU, NU_label, C, feats);
classes = feats;
graph_name = dataset_name;

main_do;