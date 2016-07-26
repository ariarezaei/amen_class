file = fopen('datasets.txt','r');
data_names = textscan(file, '%s' ,'Delimiter', '\n');
data_names = data_names{1};
n_datas = numel(data_names);

for i=1:n_datas
    cur_data = data_names{i};
    fprintf('\n');
    fprintf('Loading %s ...', cur_data);
    load(['dataset/' cur_data '.mat']);
    fprintf('[DONE]\n');
    
    rank_feat = stat_rank_assort(A,F,F_label);
    
    fprintf('Saving the new dataset ...');
    save(['stat/assort/' cur_data '_feat.mat'], 'rank_feat');
    fprintf('[DONE]\n');
    fprintf('---------------------------------\n');
end