fprintf('Saving %s\n', dataset_name);

A_tmp = A;
F_tmp = F;
A_label_tmp = A_label;
F_label_tmp = F_label;

load(['dataset\' dataset_name '.mat']);
save(['backup\' dataset_name '.mat'], 'A', 'F', 'A_label', 'F_label', ...
    'dataset_name');

A = A_tmp;
F = F_tmp;
A_label = A_label_tmp;
F_label = F_label_tmp;

save(['dataset\' dataset_name '.mat'], 'A', 'F', 'A_label', 'F_label', ...
    'dataset_name');
clear A_tmp F_tmp A_label_tmp F_label_tmp;