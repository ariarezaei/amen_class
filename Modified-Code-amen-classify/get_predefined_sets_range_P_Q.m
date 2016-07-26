function [features, givenA, givenB ] = get_predefined_sets_range_P_Q(lowRangeP, highRangeP, lowRangeQ, highRangeQ)

features = 16;
n_coms = 100;
givenA = [];
givenB = [];

for i=1:(features/2)
    a = lowRangeP;
    b = highRangeP;
    c = lowRangeQ;
    d = highRangeQ;
             
    randVectorA = (b-a).*rand(n_coms,1) + a;
    givenA = [givenA, randVectorA];
    randVectorB = (d-c).*rand(n_coms,1) + c;
    givenB = [givenB, randVectorB];
end

for j=1:(features/2)
    c= lowRangeP;
    d = highRangeP;
    c = lowRangeQ;
    d = highRangeQ;
             
    randVectorA = (b-a).*rand(n_coms,1) + a;
    givenA = [givenA, randVectorA];
    randVectorB = (d-c).*rand(n_coms,1) + c;
    givenB = [givenB, randVectorB];
end
end

