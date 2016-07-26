n_coms = 100;
m_targets = 2;
methods = {'SWP', 'Greedy' ,'Simplified', 'Top-5', 'Top-25', 'Top-50'};
k_methods = numel(methods);
experiments = 3;

feats = 50:50:500;
feats = [feats 600:100:1000];

running_time = zeros(numel(feats), k_methods);
objective_score = zeros(numel(feats), k_methods);


for featIdx = 1:numel(feats)
    feat = feats(featIdx);
    fprintf('Testing with %d features.\n', feat);
    cur_running_time = zeros(experiments, k_methods);
    cur_objective_score = zeros(experiments, k_methods);  
    
    for exp = 1:experiments
        count = fprintf('\t%d/%d\n', exp, experiments);
        % Initializing the experiment
        Xs = syn_data_random(n_coms, feat, m_targets);
        
        for methodIdx = 1:k_methods
            curMethod = methods{methodIdx};
            [part, score, time] = syn_partition(Xs, curMethod);
            cur_running_time(exp, methodIdx) = time;
            cur_objective_score(exp, methodIdx) = score;
        end
    end
    
    running_time(featIdx, :) = mean(cur_running_time);
    objective_score(featIdx, :) = mean(cur_objective_score);
    
    if (featIdx == 10)
        backup_running_time = running_time(1:10,:);
        backup_objective_score = objective_score(1:10,:);
        save('Experiments/synthetic/results/time_500.mat', 'backup_objective_score', ...
            'backup_running_time');
    end
end

% styles = {'-o', '-s', '-+' ,'-d', '-x', '--'};
% 
% figure();
% for i=1:numel(methods)
% plot(feats, objective_score(:,i), styles{i}, 'LineWidth', 1.5);
% hold on;
% end
% legend(methods, 'Location' ,'NorthWest');
% 
% figure(2);
% for i=1:numel(methods)
% plot(feats, running_time(:,i), styles{i}, 'LineWidth', 1.5, 'MarkerSize', 7.5);
% hold on;
% end
% legend(methods, 'Location' ,'NorthWest');