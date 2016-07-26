
function [yp yn]=L2score_unweighted_reg2(x,n1,beta)

% beta \in [0, inf]
% reg1: – ? (1 – |S1k/n1 – S2k/n2|)

% x is (n x d), n: # of +/- examples, d: number of features
[n d] = size(x);
n2 = n-n1;


xp = x(1:n1,:);
xn = x(n1+1:end,:);

cvx_begin
    variable yp(d)
    variable yn(d)
    S1k = sum(xp.*repmat(yp,1,n1)',1)/n1;            
    S2k = sum(xn.*repmat(yn,1,n2)',1)/n2;
    z = ones(d,1);
    util = abs(sum(xp.*repmat(z,1,n1)',1)/n1 - sum(xn.*repmat(z,1,n2)',1)/n2); %utility
    maximize( sum(S1k) + sum(S2k) - beta* norm((1 - util).*(yn+yp)',1) )
    subject to
        0 <= yp <= 1
        0 <= yn <= 1
        0 <= yp+yn <= 1 %comment-out to find common ones :sum of yn+yp entry is 2
cvx_end

% compute utility

z = ones(d,1);
sum(xp.*repmat(z,1,n1)',1)/n1
sum(xn.*repmat(z,1,n2)',1)/n2
penalty = 1- abs(sum(xp.*repmat(z,1,n1)',1)/n1 - sum(xn.*repmat(z,1,n2)',1)/n2)

sp = sum(xp.*repmat(yp,1,n1)',1)/n1 
sn = sum(xn.*repmat(yn,1,n2)',1)/n2 %- gamma*norm(yp+yn,1)/d

yn+yp
end