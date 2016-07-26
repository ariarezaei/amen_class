% A = normrnd(0,1,10,7)
% B = normrnd(0,1,10,7)
time_brute = [];
time_cont_greedy = [];
time_disc_greedy = [];
time_lazy_greedy = [];
time_simplified_form = [];

cont_greedy_ratio = [];
disc_greedy_ratio = [];
lazy_greedy_ratio = [];
simplified_form_ratio = [];

worst_cont_diff = [];
worst_disc_diff = [];
worst_lazy_diff = [];
worst_simplified_form_diff = [];

brute_score_vector = [];
cont_greedy_score_vector = [];
disc_greedy_score_vector = [];   
lazy_greedy_score_vector = [];
simplified_form_score_vector = []; 
all_features_score_vector = [];

cont_greedy_set_jaccard_difference = [];
disc_greedy_set_jaccard_difference = [];
lazy_greedy_set_jaccard_difference = [];   
simplified_form_set_jaccard_difference = []; 

cont_greedy_set_F1_difference = [];
disc_greedy_set_F1_difference = [];
lazy_greedy_set_F1_difference = [];
simplified_form_set_F1_difference = []; 

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

% lowRangeP = [0.99 0.9 0.75 0.55 0.25 0];
% highRangeP = [1 1 1 1 1 1];
% lowRangeQ = [0 0 0 0 0 0];
% highRangeQ = [0.01 0.1 0.25 0.45 0.75 1];
% Xaxis = highRangeQ;

lowRangeP =  [0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.1 0];
highRangeP = [1   1   1   1   1   1   1   1   1   1];
lowRangeQ =  [0   0   0   0   0   0   0   0   0   0];
highRangeQ = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
Xaxis = highRangeQ;

% lowRangeP = [0 0.25 0.75 0.9];
% highRangeP = [1 1 1 1];
% lowRangeQ = [0 0.25 0.75 0.9];
% highRangeQ = [1 1 1 1];
% Xaxis = lowRangeQ;

% lowRangeP = [0.01 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
% highRangeP = [1 1 1 1 1 1 1 1 1 1 1];
% lowRangeQ = [0.01 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
% highRangeQ = [1 1 1 1 1 1 1 1 1 1 1];
% Xaxis = lowRangeQ;

for r = 1:numel(lowRangeP)
    fprintf('Low range #%d\n',r);
    [features, givenA, givenB] = get_predefined_sets_range_P_Q(lowRangeP(r), highRangeP(r), lowRangeQ(r), highRangeQ(r));
    for f = 1:numel(features)
        cont_greedy_score_diff = [];
        disc_greedy_score_diff = [];
        lazy_greedy_score_diff = [];
        simplified_form_score_diff = [];   

        brute_score_vector_inner = [];
        cont_greedy_score_vector_inner = [];
        disc_greedy_score_vector_inner = [];   
        lazy_greedy_score_vector_inner = [];   
        simplified_form_score_vector_inner = []; 
        all_features_score_vector_inner = [];

        cont_greedy_set_jaccard_difference_inner = [];
        disc_greedy_set_jaccard_difference_inner = [];   
        lazy_greedy_set_jaccard_difference_inner = [];   
        simplified_form_set_jaccard_difference_inner = []; 

        cont_greedy_set_F1_difference_inner = [];
        disc_greedy_set_F1_difference_inner = [];   
        lazy_greedy_set_F1_difference_inner = [];   
        simplified_form_set_F1_difference_inner = []; 

        time_brute_inner = [];
        time_cont_greedy_inner = [];
        time_disc_greedy_inner = [];
        time_lazy_greedy_inner = [];      
        time_simplified_form_inner = [];
        
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
            fprintf('\tExperiment #%d\n',x);
            [features, givenA, givenB] = get_predefined_sets_range_P_Q(lowRangeP(r), highRangeP(r), lowRangeQ(r), highRangeQ(r));
            feature = features(f);
            A = givenA(:,1:feature);
            B = givenB(:,1:feature);

            Xs = {A,B};
            
            desiredK = feature / 2;

            tic
            [best_partition, best_score] = SWP_Brute(Xs);
            time_brute_inner(end+1) = toc;
            brute_first_num_inner(end+1) = numel(best_partition{1});
            brute_second_num_inner(end+1) = numel(best_partition{2});
%             celldisp(best_partition);

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
%             celldisp(simplified_form_part);
            
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
        lazy_greedy_ratio(end+1) = mean(lazy_greedy_score_diff);
        simplified_form_ratio(end+1) = mean(simplified_form_score_diff);

        worst_cont_diff(end+1) = max(cont_greedy_score_diff);
        worst_disc_diff(end+1) = max(disc_greedy_score_diff);
        worst_lazy_diff(end+1) = max(lazy_greedy_score_diff);
        worst_simplified_form_diff(end+1) = max(simplified_form_score_diff);

        brute_score_vector(end+1) = mean(brute_score_vector_inner);
        cont_greedy_score_vector(end+1) = mean(cont_greedy_score_vector_inner);
        disc_greedy_score_vector(end+1) = mean(disc_greedy_score_vector_inner);
        lazy_greedy_score_vector(end+1) = mean(lazy_greedy_score_vector_inner);
        simplified_form_score_vector(end+1) = mean(simplified_form_score_vector_inner);
        all_features_score_vector(end+1) = mean(all_features_score_vector_inner);

        cont_greedy_set_jaccard_difference(end+1) = mean(cont_greedy_set_jaccard_difference_inner);
        disc_greedy_set_jaccard_difference(end+1) = mean(disc_greedy_set_jaccard_difference_inner);
        simplified_form_set_jaccard_difference(end+1) = mean(simplified_form_set_jaccard_difference_inner);
        lazy_greedy_set_jaccard_difference(end+1) = mean(lazy_greedy_set_jaccard_difference_inner);

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
end

fprintf('Finished experiments, now the plots.\n');
% 
% time_brute;
% time_cont_greedy;
% time_disc_greedy;
% time_simplified_form;
% 
% cont_greedy_ratio;
% disc_greedy_ratio;
% simplified_form_ratio;
% 
% brute_score_vector;
% cont_greedy_score_vector;
% disc_greedy_score_vector;
% simplified_form_score_vector;
% all_features_score_vector;
% 
% cont_greedy_set_jaccard_difference;
% disc_greedy_set_jaccard_difference;
% simplified_form_set_jaccard_difference;
% 
% cont_greedy_set_F1_difference;
% disc_greedy_set_F1_difference;
% simplified_form_set_F1_difference;

fpath = 'C:\Users\ariar\Desktop\Research\reports\april 29\figs\P-Q';

figure
plot(Xaxis, cont_greedy_ratio, '-bo', Xaxis, disc_greedy_ratio, '-gs',...
    Xaxis, simplified_form_ratio, '-r+', Xaxis, lazy_greedy_ratio, '-kd')
title('Mean of methods score against brute method ratio')
xlabel('P-Q intervals(A(P,P);B(Q,Q)')
ylabel('Mean method score / brute method score')
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form','Lazy Greedy', 'Location','Best')
XTickLabel={};
for i =1:numel(lowRangeP)
    XTickLabel{i}  = sprintf('P(%.1f-%.1f)\\newlineQ(%.1f-%.1f)',lowRangeP(i),highRangeP(i),lowRangeQ(i),highRangeQ(i));
end
set(gca, 'XTickLabel', XTickLabel);
set(gca, 'XTickLabelRotation', -45);

filename = 'MeanMethodScoreVSBruteRatio';
saveas(gca, fullfile(fpath, filename), 'epsc');

figure
plot(Xaxis,worst_cont_diff, '-bo',Xaxis,worst_disc_diff, '-gs',...
    Xaxis, worst_simplified_form_diff, '-r+', Xaxis, worst_lazy_diff, '-kd')
title('Worst case for methods score against brute method')
xlabel('P-Q intervals(A(P,P);B(Q,Q)')
ylabel('Worst method score / brute method score')
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form','Lazy Greedy', 'Location','Best')
XTickLabel={};
for i =1:numel(lowRangeP)
    XTickLabel{i}  = sprintf('P(%.1f-%.1f)\\newlineQ(%.1f-%.1f)',lowRangeP(i),highRangeP(i),lowRangeQ(i),highRangeQ(i));
end
set(gca, 'XTickLabel', XTickLabel);
set(gca, 'XTickLabelRotation', -45);

filename = 'WorstCaseMethodScoreVSBruteRatio';
saveas(gca, fullfile(fpath, filename), 'epsc');


figure
semilogy(Xaxis,time_cont_greedy, '-bo',Xaxis,time_disc_greedy, '-gs',...
    Xaxis, time_simplified_form, '-r+',Xaxis,time_brute, '-mx',...
    Xaxis, time_lazy_greedy, '-kd')
title('Time needed')
xlabel('P-Q intervals(A(P,P);B(Q,Q)')
ylabel('Seconds')
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form', 'Brute Force','Lazy Greedy', 'Location','Best')
XTickLabel={};
for i =1:numel(lowRangeP)
    XTickLabel{i}  = sprintf('P(%.1f-%.1f)\\newlineQ(%.1f-%.1f)',lowRangeP(i),highRangeP(i),lowRangeQ(i),highRangeQ(i));
end
set(gca, 'XTickLabel', XTickLabel);
set(gca, 'XTickLabelRotation', -45);

filename = 'TimeUsed';
saveas(gca, fullfile(fpath, filename), 'epsc');

figure
% plot(Xaxis, brute_score_vector, '-mx', Xaxis,cont_greedy_score_vector, '-bo',Xaxis,disc_greedy_score_vector, '-gs', Xaxis, simplified_form_score_vector, '-rx')
plot(Xaxis, brute_score_vector, '-mx', Xaxis,cont_greedy_score_vector, '-bo',...
    Xaxis,disc_greedy_score_vector, '-gs', Xaxis, simplified_form_score_vector, '-rx',...
    Xaxis,lazy_greedy_score_vector, '-kd')
title('Method mean score values')
xlabel('P-Q intervals(A(P,P);B(Q,Q)')
ylabel('Method mean scores')
legend('Brute Force', 'Continous Greedy', 'Discrete Greedy', 'Simplified Form','Lazy Greedy', 'Location','Best')
XTickLabel={};
for i =1:numel(lowRangeP)
    XTickLabel{i}  = sprintf('P(%.1f-%.1f)\\newlineQ(%.1f-%.1f)',lowRangeP(i),highRangeP(i),lowRangeQ(i),highRangeQ(i));
end
set(gca, 'XTickLabel', XTickLabel);
set(gca, 'XTickLabelRotation', -45);

filename = 'MeanMethodObjectiveFunctionScores';
saveas(gca, fullfile(fpath, filename), 'epsc');

figure
plot(Xaxis, cont_greedy_set_jaccard_difference, '-bo', Xaxis, disc_greedy_set_jaccard_difference, '-gs',...
    Xaxis, simplified_form_set_jaccard_difference, '-rx', Xaxis, lazy_greedy_set_jaccard_difference, '-kd')
title('Jaccard set difference scores')
xlabel('P-Q intervals(A(P,P);B(Q,Q)')
ylabel('Jaccard set difference scores')
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form','Lazy Greedy', 'Location','Best')
XTickLabel={};
for i =1:numel(lowRangeP)
    XTickLabel{i}  = sprintf('P(%.1f-%.1f)\\newlineQ(%.1f-%.1f)',lowRangeP(i),highRangeP(i),lowRangeQ(i),highRangeQ(i));
end
set(gca, 'XTickLabel', XTickLabel);
set(gca, 'XTickLabelRotation', -45);
filename = 'JaccardSetDifferenceScores';
saveas(gca, fullfile(fpath, filename), 'epsc');

figure
plot(Xaxis, cont_greedy_set_F1_difference, '-bo', Xaxis, disc_greedy_set_F1_difference, '-gs',...
    Xaxis, simplified_form_set_F1_difference, '-rx', Xaxis, lazy_greedy_set_F1_difference, '-kd')
title('F1 measure set difference scores')
xlabel('P-Q intervals(A(P,P);B(Q,Q)')
ylabel('F1 set difference scores')
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form','Lazy Greedy', 'Location','Best')
XTickLabel={};
for i =1:numel(lowRangeP)
    XTickLabel{i}  = sprintf('P(%.1f-%.1f)\\newlineQ(%.1f-%.1f)',lowRangeP(i),highRangeP(i),lowRangeQ(i),highRangeQ(i));
end
set(gca, 'XTickLabel', XTickLabel);
set(gca, 'XTickLabelRotation', -45);
filename = 'F1MeasureSetDifferenceScores';
saveas(gca, fullfile(fpath, filename), 'epsc');


figure
plot(Xaxis, cont_greedy_first_num, '-bo', Xaxis, disc_greedy_first_num, '-gs',...
    Xaxis, simplified_form_first_num, '-r+', Xaxis, lazy_greedy_first_num, '-kd',...
    Xaxis, brute_first_num, '-mx');
title('# of Elements Selected for First Class');
xlabel('P-Q intervals(A(P,P);B(Q,Q)');
ylabel('# of Elements');
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form', 'Lazy Greedy', 'Brute Force', 'Location','Best')
set(gca, 'XTickLabel', XTickLabel);
set(gca, 'XTickLabelRotation', -45);
filename = 'NumberOfFirstElements';
saveas(gca, fullfile(fpath, filename), 'epsc');


figure
plot(Xaxis, cont_greedy_second_num, '-bo', Xaxis, disc_greedy_second_num, '-gs',...
    Xaxis, simplified_form_second_num, '-r+', Xaxis, lazy_greedy_second_num, '-kd',...
    Xaxis, brute_second_num, '-mx');
title('# of Elements Selected for Second Class');
xlabel('P-Q intervals(A(P,P);B(Q,Q)');
ylabel('# of Elements');
legend('Continous Greedy', 'Discrete Greedy', 'Simplified Form', 'Lazy Greedy', 'Brute Force', 'Location','Best')
XTickLabel={};
for i =1:numel(lowRangeP)
    XTickLabel{i}  = sprintf('P(%.1f-%.1f)\\newlineQ(%.1f-%.1f)',lowRangeP(i),highRangeP(i),lowRangeQ(i),highRangeQ(i));
end
set(gca, 'XTickLabel', XTickLabel);
set(gca, 'XTickLabelRotation', -45);
filename = 'NumberOfSecondElements';
saveas(gca, fullfile(fpath, filename), 'epsc');
