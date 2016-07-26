function [features, givenA, givenB ] = get_predefined_sets_different_ratios(ratio)
%first set is the positive label(C+), second class is the negative (C-)

% %features have high values in C+ or C- exclusively, the ratio of features in C+ is given as a
% %parameter
features = [10];
givenA = [];
givenB = [];
iRange = ratio * 10;
jRange = features(1) - iRange;

for i=1:iRange
    a = 0.55;
    b = 1;
    c = 0;
    d = 0.45;
             
    randVectorA = (b-a).*rand(10,1) + a;
    givenA = [givenA, randVectorA];
    randVectorB = (d-c).*rand(10,1) + c;
    givenB = [givenB, randVectorB];
end

for j=1:jRange
    c = 0.55;
    d = 1;
    a = 0;
    b = 0.45;
             
    randVectorA = (b-a).*rand(10,1) + a;
    givenA = [givenA, randVectorA];
    randVectorB = (d-c).*rand(10,1) + c;
    givenB = [givenB, randVectorB];
end


%different ratios of high/low values for both C+ and C- (either they both have high values, or neither)
% features = [10];
% givenA = [];
% givenB = [];
% iRange = ratio * 10;
% jRange = features(1) - iRange;
% 
% for i=1:iRange
%     a = 0.55;
%     b = 1;
%              
%     randVectorA = (b-a).*rand(10,1) + a;
%     givenA = [givenA, randVectorA];
%     randVectorB = (b-a).*rand(10,1) + a;
%     givenB = [givenB, randVectorB];
% end
% 
% for j=1:jRange
%     c = 0;
%     d = 0.45;
%              
%     randVectorA = (d-c).*rand(10,1) + c;
%     givenA = [givenA, randVectorA];
%     randVectorB = (d-c).*rand(10,1) + c;
%     givenB = [givenB, randVectorB];
% end

end



