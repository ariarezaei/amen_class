% A = normrnd(0,1,10,7)
% B = normrnd(0,1,10,7)

features = [2 4 6 8 10 14];

time_brute = [];
time_cont_greedy = [];
time_disc_greedy = [];
time_simplified_form = [];
time_lazy_greedy = [];

cont_greedy_ratio = [];
disc_greedy_ratio = [];
simplified_form_ratio = [];
lazy_greedy_ratio = [];

worst_cont_diff = [];
worst_disc_diff = [];
worst_simplified_form_diff = [];
worst_lazy_diff = [];

brute_score_vector = [];
cont_greedy_score_vector = [];
disc_greedy_score_vector = [];   
simplified_form_score_vector = []; 
all_features_score_vector = [];
lazy_greedy_score_vector = [];

cont_greedy_set_jaccard_difference = [];
disc_greedy_set_jaccard_difference = [];   
simplified_form_set_jaccard_difference = []; 
lazy_greedy_set_jaccard_difference = [];

cont_greedy_set_F1_difference = [];
disc_greedy_set_F1_difference = [];   
simplified_form_set_F1_difference = [];
lazy_greedy_set_F1_difference = [];

brute_first_num = [];
cont_greedy_first_num = [];
disc_greedy_first_num = [];
simplified_form_first_num = [];
lazy_greedy_first_num = [];

brute_second_num = [];
cont_greedy_second_num = [];
disc_greedy_second_num = [];
simplified_form_second_num = [];
lazy_greedy_second_num = [];


for f = 1:numel(features)
    fprintf('Feature #%d/%d\n',features(f),max(features));
    cont_greedy_score_diff = [];
    disc_greedy_score_diff = [];   
    simplified_form_score_diff = [];   
    lazy_greedy_score_diff = [];

    brute_score_vector_inner = [];
    cont_greedy_score_vector_inner = [];
    disc_greedy_score_vector_inner = [];   
    simplified_form_score_vector_inner = []; 
    all_features_score_vector_inner = [];
    lazy_greedy_score_vector_inner = [];

    cont_greedy_set_jaccard_difference_inner = [];
    disc_greedy_set_jaccard_difference_inner = [];   
    simplified_form_set_jaccard_difference_inner = []; 
    lazy_greedy_set_jaccard_difference_inner = [];

    cont_greedy_set_F1_difference_inner = [];
    disc_greedy_set_F1_difference_inner = [];   
    simplified_form_set_F1_difference_inner = []; 
    lazy_greedy_set_F1_difference_inner = [];

    time_brute_inner = [];
    time_cont_greedy_inner = [];
    time_disc_greedy_inner = [];   
    time_simplified_form_inner = [];
    time_lazy_greedy_inner = [];

    brute_first_num_inner = [];
    cont_greedy_first_num_inner = [];
    disc_greedy_first_num_inner = [];
    simplified_form_first_num_inner = [];
    lazy_greedy_first_num_inner = [];

    brute_second_num_inner = [];
    cont_greedy_second_num_inner = [];
    disc_greedy_second_num_inner = [];
    simplified_form_second_num_inner = [];
    lazy_greedy_second_num_inner = [];
    
    for x = 1:10    
        feature = features(f);

        A = rand(10, feature);
        B = rand(10, feature);

        Xs = {A,B};
        
        desiredK = feature / 2;

        tic
        [best_partition, best_score] = SWP_Brute(Xs);
        time_brute_inner(end+1) = toc;
        brute_first_num_inner(end+1) = numel(best_partition{1});
        brute_second_num_inner(end+1) = numel(best_partition{2});
        
        brute_score_vector_inner(end+1) = best_score;
        
        [all_features_part, all_features_score] = ScoreForAllFeatures(Xs);
        all_features_score_vector_inner(end+1) = all_features_score;
        
        tic
        [cont_greedy_part, cont_greedy_score] = SWP_Amen(Xs);
        time_cont_greedy_inner(end+1) = toc;
        cont_greedy_first_num_inner(end+1) = numel(cont_greedy_part{1});
        cont_greedy_second_num_inner(end+1) = numel(cont_greedy_part{2});

        cont_greedy_score_diff(end+1) = (best_score - cont_greedy_score)/best_score;
        cont_greedy_score_vector_inner(end+1) = cont_greedy_score;
        cont_greedy_set_jaccard_difference_inner(end+1) = jaccard_partition_difference_score(best_partition, cont_greedy_part);
        cont_greedy_set_F1_difference_inner(end+1) = partition_difference_F1_score(best_partition, cont_greedy_part);

        tic;
        [lazy_greedy_part, lazy_greedy_score] = SWP_Lazy_Greedy(Xs, desiredK);
        time_lazy_greedy_inner(end+1) = toc;
        lazy_greedy_first_num_inner(end+1) = numel(lazy_greedy_part{1});
        lazy_greedy_second_num_inner(end+1) = numel(lazy_greedy_part{2});

        lazy_greedy_score_diff(end+1) = (best_score - lazy_greedy_score) / best_score;
        lazy_greedy_score_vector_inner(end+1) = lazy_greedy_score;
        lazy_greedy_set_jaccard_difference_inner(end+1) = jaccard_partition_difference_score(best_partition, lazy_greedy_part);
        lazy_greedy_set_F1_difference_inner(end+1) = partition_difference_F1_score(best_partition, lazy_greedy_part);

        
        tic
        [disc_greedy_part, disc_greedy_score] = SWP_Discrete_Greedy(Xs);        
        time_disc_greedy_inner(end+1) = toc;
        disc_greedy_first_num_inner(end+1) = numel(disc_greedy_part{1});
        disc_greedy_second_num_inner(end+1) = numel(disc_greedy_part{2});

        disc_greedy_score_diff(end+1) = (best_score - disc_greedy_score)/best_score; 
        disc_greedy_score_vector_inner(end+1) = disc_greedy_score;
        disc_greedy_set_jaccard_difference_inner(end+1) = jaccard_partition_difference_score(best_partition, disc_greedy_part);
        disc_greedy_set_F1_difference_inner(end+1) = partition_difference_F1_score(best_partition, disc_greedy_part);
        
        tic 
        [simplified_form_part, simplified_form_score] = Not_SWP(Xs);
        time_simplified_form_inner(end+1) = toc;
        simplified_form_first_num_inner(end+1) = numel(simplified_form_part{1});
        simplified_form_second_num_inner(end+1) = numel(simplified_form_part{2});
        
        simplified_form_score_diff(end+1) = (best_score - simplified_form_score)/best_score;
        simplified_form_score_vector_inner(end+1) = simplified_form_score;
        simplified_form_set_jaccard_difference_inner(end+1) = jaccard_partition_difference_score(best_partition, simplified_form_part);
        simplified_form_set_F1_difference_inner(end+1) = partition_difference_F1_score(best_partition, simplified_form_part);
    end
    
    time_brute(end+1) = mean(time_brute_inner);
    time_cont_greedy(end+1) = mean(time_cont_greedy_inner);
    time_disc_greedy(end+1) = mean(time_disc_greedy_inner);
    time_simplified_form(end+1) = mean(time_simplified_form_inner);
    time_lazy_greedy(end+1) = mean(time_lazy_greedy_inner);
    
    cont_greedy_ratio(end+1) = mean(cont_greedy_score_diff);
    disc_greedy_ratio(end+1) = mean(disc_greedy_score_diff);
    simplified_form_ratio(end+1) = mean(simplified_form_score_diff);
    lazy_greedy_ratio(end+1) = mean(lazy_greedy_score_diff);
    
    worst_cont_diff(end+1) = max(cont_greedy_score_diff);
    worst_disc_diff(end+1) = max(disc_greedy_score_diff);
    worst_simplified_form_diff(end+1) = max(simplified_form_score_diff);
    worst_lazy_diff(end+1) = max(lazy_greedy_score_diff);
    
    brute_score_vector(end+1) = mean(brute_score_vector_inner);
    cont_greedy_score_vector(end+1) = mean(cont_greedy_score_vector_inner);
    disc_greedy_score_vector(end+1) = mean(disc_greedy_score_vector_inner);
    simplified_form_score_vector(end+1) = mean(simplified_form_score_vector_inner);
    all_features_score_vector(end+1) = mean(all_features_score_vector_inner);
    lazy_greedy_score_vector(end+1) = mean(lazy_greedy_score_vector_inner);
    
    cont_greedy_set_jaccard_difference(end+1) = mean(cont_greedy_set_jaccard_difference_inner);
    disc_greedy_set_jaccard_difference(end+1) = mean(disc_greedy_set_jaccard_difference_inner);
    lazy_greedy_set_jaccard_difference(end+1) = mean(lazy_greedy_set_jaccard_difference_inner);
    simplified_form_set_jaccard_difference(end+1) = mean(simplified_form_set_jaccard_difference_inner);
    
    cont_greedy_set_F1_difference(end+1) = mean(cont_greedy_set_F1_difference_inner);
    disc_greedy_set_F1_difference(end+1) = mean(disc_greedy_set_F1_difference_inner);
    lazy_greedy_set_F1_difference(end+1) = mean(lazy_greedy_set_F1_difference_inner);
    simplified_form_set_F1_difference(end+1) = mean(simplified_form_set_F1_difference_inner);

    cont_greedy_first_num(end+1) = mean(cont_greedy_first_num_inner);
    lazy_greedy_first_num(end+1) = mean(lazy_greedy_first_num_inner);
    disc_greedy_first_num(end+1) = mean(disc_greedy_first_num_inner);
    simplified_form_first_num(end+1) = mean(simplified_form_first_num_inner);
    brute_first_num(end+1) = mean(brute_first_num_inner);

    cont_greedy_second_num(end+1) = mean(cont_greedy_second_num_inner);
    lazy_greedy_second_num(end+1) = mean(lazy_greedy_second_num_inner);
    disc_greedy_second_num(end+1) = mean(disc_greedy_second_num_inner);
    simplified_form_second_num(end+1) = mean(simplified_form_second_num_inner);
    brute_second_num(end+1) = mean(brute_second_num_inner);
end

% time_brute
% time_cont_greedy
% time_disc_greedy
% time_simplified_form
% 
% cont_greedy_ratio
% disc_greedy_ratio
% simplified_form_ratio
% 
% brute_score_vector
% cont_greedy_score_vector
% disc_greedy_score_vector
% simplified_form_score_vector
% all_features_score_vector
% 
% cont_greedy_set_jaccard_difference
% disc_greedy_set_jaccard_difference
% simplified_form_set_jaccard_difference
% 
% cont_greedy_set_F1_difference
% disc_greedy_set_F1_difference
% simplified_form_set_F1_difference


fpath = 'C:\Users\ariar\Desktop\Research\reports\april 29\figs\random';

disp(size(cont_greedy_ratio));
disp(size(disc_greedy_ratio));
disp(size(lazy_greedy_ratio));
disp(size(simplified_form_ratio));

figure
plot(features, cont_greedy_ratio, '-bo', features, disc_greedy_ratio, '-gs',...
    features, simplified_form_ratio, '-r+', features, lazy_greedy_ratio, '-yd');
title('Mean of methods score against brute method ratio')
xlabel('Features')
ylabel('Mean method score / brute method score')
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form','Lazy Greedy','Location','Best')
filename = 'MeanMethodScoreVSBruteRatio';
saveas(gca, fullfile(fpath, filename), 'epsc');

figure
plot(features,worst_cont_diff, '-bo',features,worst_disc_diff, '-gs',...
    features, worst_simplified_form_diff, '-r+', features, worst_lazy_diff, '-yd');
title('Worst case for methods score against brute method')
xlabel('Features')
ylabel('Worst method score / brute method score')
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form','Lazy Greedy','Location','Best')
filename = 'WorstCaseMethodScoreVSBruteRatio';
saveas(gca, fullfile(fpath, filename), 'epsc');

figure
semilogy(features,time_cont_greedy, '-bo',features,time_disc_greedy, '-gs',...
    features, time_simplified_form, '-r+',features,time_brute, '-mx',...
    features, time_lazy_greedy, '-yd')
title('Time needed')
xlabel('Features')
ylabel('Seconds')
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form', 'Brute Force', 'Lazy Greedy', 'Location','Best')
filename = 'TimeUsed';
saveas(gca, fullfile(fpath, filename), 'epsc');

figure
plot(features, brute_score_vector, '-mx', features,cont_greedy_score_vector, '-bo',...
    features,disc_greedy_score_vector, '-gs', features, simplified_form_score_vector, '-r+',...
    features, lazy_greedy_score_vector, '-yd')
title('Method mean score values')
xlabel('Features')
ylabel('Method mean scores')
legend('Brute Force', 'Continous Greedy', 'Discrete Greedy', 'Simplified Form','Lazy Greedy', 'Location','Best')
filename = 'MeanMethodObjectiveFunctionScores';
saveas(gca, fullfile(fpath, filename), 'epsc');


figure
plot(features, cont_greedy_set_jaccard_difference, '-bo', features, disc_greedy_set_jaccard_difference, '-gs',...
    features, simplified_form_set_jaccard_difference, '-r+', features, lazy_greedy_set_jaccard_difference, '-yd')
title('Jaccard set difference scores')
xlabel('Features')
ylabel('Jaccard set difference scores')
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form', 'Lazy Greedy', 'Location','Best')
filename = 'JaccardSetDifferenceScores';
saveas(gca, fullfile(fpath, filename), 'epsc');

figure
plot(features, cont_greedy_set_F1_difference, '-bo', features, disc_greedy_set_F1_difference, '-gs',...
    features, simplified_form_set_F1_difference, '-r+', features, lazy_greedy_set_F1_difference, '-yd')
title('F1 measure set difference scores')
xlabel('Features')
ylabel('F1 set difference scores')
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form','Lazy Greedy', 'Location','Best')
filename = 'F1MeasureSetDifferenceScores';
saveas(gca, fullfile(fpath, filename), 'epsc');

figure
plot(features, cont_greedy_first_num, '-bo', features, disc_greedy_first_num, '-gs',...
    features, simplified_form_first_num, '-r+', features, lazy_greedy_first_num, '-yd',...
    features, brute_first_num, '-mx');
title('# of Elements Selected for First Class');
xlabel('Features');
ylabel('# of Elements');
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form', 'Lazy Greedy', 'Brute Force', 'Location','Best')
filename = 'NumberOfFirstElements';
saveas(gca, fullfile(fpath, filename), 'epsc');


figure
plot(features, cont_greedy_second_num, '-bo', features, disc_greedy_second_num, '-gs',...
    features, simplified_form_second_num, '-r+', features, lazy_greedy_second_num, '-yd',...
    features, brute_second_num, '-mx');
title('# of Elements Selected for Second Class');
xlabel('Features');
ylabel('# of Elements');
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form', 'Lazy Greedy', 'Brute Force', 'Location','Best')
filename = 'NumberOfSecondElements';
saveas(gca, fullfile(fpath, filename), 'epsc');
