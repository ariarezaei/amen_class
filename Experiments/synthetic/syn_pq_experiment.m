n_coms = 100;
n_feats = 5;
m_targets = 2;
methods = {'SWP', 'Greedy' ,'Simplified', 'Top-3', 'Top-5', 'Top-10'};
k_methods = numel(methods);
experiments = 10;

% p_lows  = [0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.1 0];
p_lows = fliplr(0:0.05:0.95);
% q_highs = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
q_highs = .05:.05:1;

running_time = zeros(numel(p_lows), k_methods);
score_ratio = zeros(numel(p_lows), k_methods);

for plowIdx = 1:numel(p_lows)
    
    low_p  = p_lows(plowIdx);
    high_q = q_highs(plowIdx);
    fprintf('Testing with P = (%.2f,%.2f), Q = (%.2f,%.2f).\n', ...
        low_p, 1, 0, high_q);
    
    cur_running_time = zeros(experiments, k_methods);
    cur_score_ratio = zeros(experiments, k_methods);  
    
    for exp = 1:experiments
        count = fprintf('\t%d/%d\n', exp, experiments);
        % Initializing the experiment
        [~, A, B] = get_predefined_sets_range_P_Q(low_p, 1, 0, high_q);
        Xs  = {A, B};
        [opt_part, opt_score, opt_time] = syn_partition(Xs, 'Brute');
        
        for methodIdx = 1:k_methods
            curMethod = methods{methodIdx};
            [part, score, time] = syn_partition(Xs, curMethod);
            cur_running_time(exp, methodIdx) = time;
            cur_score_ratio(exp, methodIdx) = score / opt_score;
        end
    end
    
    running_time(plowIdx, :) = mean(cur_running_time);
    score_ratio(plowIdx, :) = mean(cur_score_ratio);
end

styles = {'-o', '-s', '-s' ,'-d', '-x', '--'};
goods = [1 3];
% figure();
% for i=1:numel(methods)
% plot(feats, score_ratio(:,i), styles{i}, 'LineWidth', 1.5);
% hold on;
% end
% legend(methods, 'Location' ,'NorthWest');

figure();
for idx=1:numel(goods)
    i = goods(idx);
plot(1:numel(p_lows), score_ratio(:,i), styles{i}, 'LineWidth', 1.5, 'MarkerSize', 7.5);
hold on;
end
axis tight;
% 
% P = 0.05:0.1:0.95;
% Pstr = {};
% for i=1:numel(P)
%     Pstr{end+1} = num2str(P(i));
% end
% Pstr = fliplr(Pstr);
% set(gca, 'XTickLabel', Pstr);
legend(methods(goods), 'Location', 'SouthWest');
legend(methods, 'Location' ,'NorthWest');