n_coms = 100;
m_targets = 2;
methods = {'SWP', 'Greedy' ,'Simplified', 'Top-3', 'Top-5', 'Top-10'};
k_methods = numel(methods);
experiments = 10;

feats = 3:20;


running_time = zeros(numel(feats), k_methods);
score_ratio = zeros(numel(feats), k_methods);


for featIdx = 1:numel(feats)
    feat = feats(featIdx);
    fprintf('Testing with %d features.\n', feat);
    cur_running_time = zeros(experiments, k_methods);
    cur_score_ratio = zeros(experiments, k_methods);  
    
    for exp = 1:experiments
        count = fprintf('\t%d/%d\n', exp, experiments);
        % Initializing the experiment
        Xs = syn_data_random(n_coms, feat, m_targets);
        [opt_part, opt_score, opt_time] = syn_partition(Xs, 'Brute');
        
        for methodIdx = 1:k_methods
            curMethod = methods{methodIdx};
            [part, score, time] = syn_partition(Xs, curMethod);
            cur_running_time(exp, methodIdx) = time;
            cur_score_ratio(exp, methodIdx) = score / opt_score;
        end
    end
    
    running_time(featIdx, :) = mean(cur_running_time);
    score_ratio(featIdx, :) = mean(cur_score_ratio);
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