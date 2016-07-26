file = fopen('datasets.txt','r');
data_names = textscan(file, '%s' ,'Delimiter', '\n');
data_names = data_names{1};
n_datas = numel(data_names);

for i=1:n_datas
    cur_data = data_names{i};
    fprintf('\n');
    fprintf('Loading %s ...', cur_data);
    load(['dataset\' cur_data '.mat']);
    fprintf('[DONE]\n');
    
    fprintf('Saving .edge file for it ...');
    io_save_graph_cpp(A, ['cpp\graph\' cur_data '.edge']);
    fprintf('[DONE]\n');
    
    fprintf('Finding the biggest component ...');
    system(['cpp\gc.exe cpp\graph\' cur_data '.edge cpp\gc\' cur_data '.gc 1>NUL 2>NUL']);
    fprintf('[DONE]\n');
    
    fprintf('BEFORE: nodes: %d\tfeatures: %d\n', size(A,1), size(F,2));
    gcnodes = dlmread(['cpp\gc\' cur_data '.gc']);
    
    % Filtering nodes
    A = A(gcnodes,gcnodes);
    A_label = A_label(gcnodes);
    F = F(gcnodes,:);
    
    % Filtering empty features out
    sumf = sum(F);
    goodFeats = (sumf > 0);
    F = F(:,goodFeats);
    F_label = F_label(goodFeats);
    fprintf('AFTER: nodes: %d\tfeatures: %d\n', size(A,1), size(F,2));
    
    dataset_name = cur_data;
    fprintf('Saving the new dataset ...');
    save(['dataset\' cur_data '.mat'], 'A', 'F', 'A_label', 'F_label', 'dataset_name');
    fprintf('[DONE]\n');
    fprintf('---------------------------------\n');
end