% A = normrnd(0,1,10,7)
% B = normrnd(0,1,10,7)

features = [2 3 5 8 10 15];

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

for f = 1:numel(features)
    cont_greedy_score_diff = [];
    disc_greedy_score_diff = [];   
    simplified_form_score_diff = [];   
    
    time_brute_inner = [];
    time_cont_greedy_inner = [];
    time_disc_greedy_inner = [];   
    time_simplified_form_inner = [];
    
    for x = 1:10    
        feature = features(f);

        A = rand(10, feature);
        B = rand(10, feature);

        Xs = {A,B};

        tic
        [best_partition, best_score] = SWP_Brute(Xs);
        time_brute_inner(end+1) = toc;
        
        tic
        [cont_greedy_part, cont_greedy_score] = SWP_Amen(Xs);
        time_cont_greedy_inner(end+1) = toc;

        cont_greedy_score_diff(end+1) = (best_score - cont_greedy_score)/best_score;

        tic
        [disc_greedy_part, disc_greedy_score] = SWP_Discrete_Greedy(Xs);        
        time_disc_greedy_inner(end+1) = toc;

        disc_greedy_score_diff(end+1) = (best_score - disc_greedy_score)/best_score;  
        
        tic 
        [simplified_form_part, simplified_form_score] = Not_SWP(Xs);
        time_simplified_form_inner(end+1) = toc;
        
        simplified_form_score_diff(end+1) = (best_score - simplified_form_score)/best_score;
    end
    
    time_brute(end+1) = mean(time_brute_inner);
    time_cont_greedy(end+1) = mean(time_cont_greedy_inner);
    time_disc_greedy(end+1) = mean(time_disc_greedy_inner);
    time_simplified_form(end+1) = mean(time_simplified_form_inner);
    
    cont_greedy_ratio(end+1) = mean(cont_greedy_score_diff);
    disc_greedy_ratio(end+1) = mean(disc_greedy_score_diff);
    simplified_form_ratio(end+1) = mean(simplified_form_score_diff);
    
    worst_cont_diff(end+1) = max(cont_greedy_score_diff);
    worst_disc_diff(end+1) = max(disc_greedy_score_diff);
    worst_simplified_form_diff(end+1) = max(simplified_form_score_diff);
end

time_brute
time_cont_greedy
time_disc_greedy
time_simplified_form

cont_greedy_ratio
disc_greedy_ratio
simplified_form_ratio

figure
plot(features,cont_greedy_ratio,features,disc_greedy_ratio, features, simplified_form_ratio)
figure
plot(features,worst_cont_diff,features,worst_disc_diff, features, worst_simplified_form_diff)
figure
plot(features,time_cont_greedy,features,time_disc_greedy, features, time_simplified_form,features,time_brute)