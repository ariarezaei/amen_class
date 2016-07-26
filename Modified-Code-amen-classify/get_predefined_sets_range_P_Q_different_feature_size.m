function [givenA, givenB ] = get_predefined_sets_range_P_Q_different_feature_size(features, lowRangeP, highRangeP, lowRangeQ, highRangeQ)
givenA = [];
givenB = [];

for i=1:features/2
    a = lowRangeP;
    b = highRangeP;
    c = lowRangeQ;
    d = highRangeQ;
             
    randVectorA = (b-a).*rand(10,1) + a;
    givenA = [givenA, randVectorA];
    randVectorB = (d-c).*rand(10,1) + c;
    givenB = [givenB, randVectorB];
end

for j=1:features/2
    c= lowRangeP;
    d = highRangeP;
    c = lowRangeQ;
    d = highRangeQ;
             
    randVectorA = (b-a).*rand(10,1) + a;
    givenA = [givenA, randVectorA];
    randVectorB = (d-c).*rand(10,1) + c;
    givenB = [givenB, randVectorB];
end
end



