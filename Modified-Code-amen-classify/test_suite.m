C_plus = [1 0]
C_minus = [0 1]

[brute_partition, brute_score] = SWP_Brute({C_plus, C_minus})
[cont_greedy_part, cont_greedy_score] = SWP_Amen({C_plus, C_minus})
[disc_greedy_part, disc_greedy_score] = SWP_Discrete_Greedy({C_plus, C_minus})
[simplified_form_part, simplified_form_score] = Not_SWP({C_plus, C_minus})

assert(brute_score == 2)

C_plus = [1 0;
          1 0]
C_minus = [0 1]

[brute_partition, brute_score] = SWP_Brute({C_plus, C_minus})
[cont_greedy_part, cont_greedy_score] = SWP_Amen({C_plus, C_minus})
[disc_greedy_part, disc_greedy_score] = SWP_Discrete_Greedy({C_plus, C_minus})
[simplified_form_part, simplified_form_score] = Not_SWP({C_plus, C_minus})

assert(brute_score == 2)

C_plus = [1 1 0;
          0.5 0 0]
C_minus = [0 0 1] 

[brute_partition, brute_score] = SWP_Brute({C_plus, C_minus})
[cont_greedy_part, cont_greedy_score] = SWP_Amen({C_plus, C_minus})
[disc_greedy_part, disc_greedy_score] = SWP_Discrete_Greedy({C_plus, C_minus})
[simplified_form_part, simplified_form_score] = Not_SWP({C_plus, C_minus})

assert(abs(brute_score - 1.9571) < 0.001)

C_plus = [1 0 0; 
          1 1 0
          0 1 0]
C_minus = [0 1 1]

[brute_partition, brute_score] = SWP_Brute({C_plus, C_minus})
[cont_greedy_part, cont_greedy_score] = SWP_Amen({C_plus, C_minus})
[disc_greedy_part, disc_greedy_score] = SWP_Discrete_Greedy({C_plus, C_minus})
[simplified_form_part, simplified_form_score] = Not_SWP({C_plus, C_minus})

C_plus =  [0.33,0.34,0.20,0.69,0.77,0.49;
           0.32,0.24,0.50,0.74,0.28,0.49;
           0.36,0.59,0.79,0.92,0.26,0.49;
           0.37,0.58,0.10,0.55,0.46,0.49;
           0.49,0.28,0.25,0.99,0.37,0.49;
           0.37,0.55,0.64,0.70,0.47,0.49];
      
C_minus = [0.63,0.64,0.68,0.39,0.50,0.51;
           0.72,0.74,0.99,0.24,0.50,0.51;
           0.56,0.69,0.79,0.29,0.20,0.51;
           0.43,0.58,0.67,0.45,0.46,0.51;
           0.79,0.88,0.69,0.52,0.30,0.51;
           0.57,0.95,0.99,0.50,0.50,0.51];
       
[brute_partition, brute_score] = SWP_Brute({C_plus, C_minus})
[cont_greedy_part, cont_greedy_score] = SWP_Amen({C_plus, C_minus})
[disc_greedy_part, disc_greedy_score] = SWP_Discrete_Greedy({C_plus, C_minus})
[simplified_form_part, simplified_form_score] = Not_SWP({C_plus, C_minus})
