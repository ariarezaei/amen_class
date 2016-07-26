% A = normrnd(0,1,10,7)
% B = normrnd(0,1,10,7)
time_brute = [];
time_cont_greedy = [];
time_disc_greedy = [];
time_simplified_form = [];

cont_greedy_ratio = [];
disc_greedy_ratio = [];
simplified_form_ratio = [];

worst_cont_diff = [];
worst_disc_diff = [];
worst_simplified_form_diff = [];

cont_greedy_score_vector = [];
disc_greedy_score_vector = [];   
simplified_form_score_vector = []; 
all_features_score_vector = [];

disc_greedy_set_jaccard_difference = [];   
simplified_form_set_jaccard_difference = []; 
disc_greedy_set_F1_difference = [];   
simplified_form_set_F1_difference = []; 


features = [2 4 6 8 16 32 50 64 100 128 200 256 500 750 1000];
lowRangeP = 0.6;
highRangeP = 1;
lowRangeQ =  0.0;
highRangeQ = 0.4;

for r = 1:numel(features)
        [givenA, givenB] = get_predefined_sets_range_P_Q_different_feature_size(features(r), lowRangeP, highRangeP, lowRangeQ, highRangeQ);
        disc_greedy_score_diff = [];   
        simplified_form_score_diff = [];   

        cont_greedy_score_vector_inner = [];
        disc_greedy_score_vector_inner = [];   
        simplified_form_score_vector_inner = []; 
        all_features_score_vector_inner = [];

        disc_greedy_set_jaccard_difference_inner = [];   
        simplified_form_set_jaccard_difference_inner = []; 

        disc_greedy_set_F1_difference_inner = [];   
        simplified_form_set_F1_difference_inner = []; 

        time_cont_greedy_inner = [];
        time_disc_greedy_inner = [];   
        time_simplified_form_inner = [];

        for x = 1:10
            [givenA, givenB] = get_predefined_sets_range_P_Q_different_feature_size(features(r), lowRangeP, highRangeP, lowRangeQ, highRangeQ);
            feature = features(r);
            A = givenA(:,1:feature);
            B = givenB(:,1:feature);

            Xs = {A,B};

            [all_features_part, all_features_score] = ScoreForAllFeatures(Xs);
            all_features_score_vector_inner(end+1) = all_features_score;

            tic
            [cont_greedy_part, cont_greedy_score] = SWP_Amen(Xs);
            time_cont_greedy_inner(end+1) = toc;
            cont_greedy_score_vector_inner(end+1) = cont_greedy_score;

            tic
            [disc_greedy_part, disc_greedy_score] = SWP_Discrete_Greedy(Xs);        
            time_disc_greedy_inner(end+1) = toc;

            disc_greedy_score_diff(end+1) = (cont_greedy_score - disc_greedy_score)/cont_greedy_score; 
            disc_greedy_score_vector_inner(end+1) = disc_greedy_score;
            disc_greedy_set_jaccard_difference_inner(end+1) = jaccard_partition_difference_score(cont_greedy_part, disc_greedy_part);
            disc_greedy_set_F1_difference_inner(end+1) = partition_difference_F1_score(cont_greedy_part, disc_greedy_part);

            tic 
            [simplified_form_part, simplified_form_score] = Not_SWP(Xs);
%             celldisp(simplified_form_part);
            
            time_simplified_form_inner(end+1) = toc;

            simplified_form_score_diff(end+1) = (cont_greedy_score - simplified_form_score)/cont_greedy_score;
            simplified_form_score_vector_inner(end+1) = simplified_form_score;
            simplified_form_set_jaccard_difference_inner(end+1) = jaccard_partition_difference_score(cont_greedy_part, simplified_form_part);
            simplified_form_set_F1_difference_inner(end+1) = partition_difference_F1_score(cont_greedy_part, simplified_form_part);
        end

        time_cont_greedy(end+1) = mean(time_cont_greedy_inner);
        time_disc_greedy(end+1) = mean(time_disc_greedy_inner);
        time_simplified_form(end+1) = mean(time_simplified_form_inner);

        disc_greedy_ratio(end+1) = mean(disc_greedy_score_diff);
        simplified_form_ratio(end+1) = mean(simplified_form_score_diff);

        worst_disc_diff(end+1) = max(disc_greedy_score_diff);
        worst_simplified_form_diff(end+1) = max(simplified_form_score_diff);

        cont_greedy_score_vector(end+1) = mean(cont_greedy_score_vector_inner);
        disc_greedy_score_vector(end+1) = mean(disc_greedy_score_vector_inner);
        simplified_form_score_vector(end+1) = mean(simplified_form_score_vector_inner);
        all_features_score_vector(end+1) = mean(all_features_score_vector_inner);

        disc_greedy_set_jaccard_difference(end+1) = mean(disc_greedy_set_jaccard_difference_inner);
        simplified_form_set_jaccard_difference(end+1) = mean(simplified_form_set_jaccard_difference_inner);

        disc_greedy_set_F1_difference(end+1) = mean(disc_greedy_set_F1_difference_inner);
        simplified_form_set_F1_difference(end+1) = mean(simplified_form_set_F1_difference_inner);
end

time_cont_greedy;
time_disc_greedy;
time_simplified_form;

disc_greedy_ratio;
simplified_form_ratio;

disc_greedy_score_vector;
simplified_form_score_vector;
all_features_score_vector;

disc_greedy_set_jaccard_difference;
simplified_form_set_jaccard_difference;

disc_greedy_set_F1_difference;
simplified_form_set_F1_difference;

fpath = 'H:\StonyBrook\KDD\Experiments\10-13-2015\A(P,P),B(Q,Q)(P[0.6-1]Q[0.0-0.4])-increasing_feature_size (against cont greedy) (max 1000 features)';

figure
plot(features, disc_greedy_ratio, '-gs', features, simplified_form_ratio, '-r+')
title('Mean of methods score against continuous greedy method ratio')
xlabel('Feature Size')
ylabel('Mean method score / continuous greedy method score')
legend('discrete_greedy', 'simplified_form','Location','Best')

filename = 'MeanMethodScoreVSContGreedyRatio';
saveas(gca, fullfile(fpath, filename), 'jpeg');

figure
plot(features,worst_disc_diff, '-gs', features, worst_simplified_form_diff, '-r+')
title('Worst case for methods score against continuous greedy method')
xlabel('Feature Size')
ylabel('Worst method score / continuous greedy method score')
legend('discrete_greedy', 'simplified_form','Location','Best')

filename = 'WorstCaseMethodScoreVSContGreedyRatio';
saveas(gca, fullfile(fpath, filename), 'jpeg');


figure
semilogy(features,time_cont_greedy, '-bo',features,time_disc_greedy, '-gs', features, time_simplified_form, '-r+')
title('Time needed')
xlabel('Feature Size')
ylabel('Seconds')
legend('cont_greedy(greedy_welfare)', 'discrete_greedy', 'simplified_form','Location','Best')

filename = 'TimeUsed';
saveas(gca, fullfile(fpath, filename), 'jpeg');

figure
plot(features,cont_greedy_score_vector, '-bo',features,disc_greedy_score_vector, '-gs', features, simplified_form_score_vector, '-rx')
title('Method mean score values')
xlabel('Feature Size')
ylabel('Method mean scores')
legend('cont_greedy(greedy_welfare)', 'discrete_greedy', 'simplified_form','Location','Best')

filename = 'MeanMethodObjectiveFunctionScores';
saveas(gca, fullfile(fpath, filename), 'jpeg');

figure
plot(features, disc_greedy_set_jaccard_difference, '-gs', features, simplified_form_set_jaccard_difference, '-rx')
title('Jaccard set difference scores')
xlabel('Feature Size')
ylabel('Jaccard set difference scores')
legend('discrete_greedy', 'simplified_form','Location','Best')

filename = 'JaccardSetDifferenceScores';
saveas(gca, fullfile(fpath, filename), 'jpeg');

figure
plot(features, disc_greedy_set_F1_difference, '-gs', features, simplified_form_set_F1_difference, '-rx')
title('F1 measure set difference scores')
xlabel('Feature Size')
ylabel('F1 set difference scores')
legend('discrete_greedy', 'simplified_form','Location','Best')

filename = 'F1MeasureSetDifferenceScores';
saveas(gca, fullfile(fpath, filename), 'jpeg');
