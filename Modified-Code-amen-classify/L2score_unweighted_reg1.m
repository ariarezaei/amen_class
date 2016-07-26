
function [yp yn]=L2score_unweighted_reg1(x,n1,lambda)

% lambda \in [0,1]
% reg1: -	? (|W1| + |W2|)

% x is (n x d), n: # of +/- examples, d: number of features
[n d] = size(x);
n2 = n-n1;


xp = x(1:n1,:);
xn = x(n1+1:end,:);

cvx_begin
    variable yp(d)
    variable yn(d)
    maximize( sum(sum(xp.*repmat(yp,1,n1)'))/n1 + sum(sum(xn.*repmat(yn,1,n2)'))/n2 - lambda*norm(yp+yn,1) )
    subject to
        0 <= yp <= 1
        0 <= yn <= 1
        0 <= yp+yn <= 1 %comment-out to find common ones :sum of yn+yp entry is 2
cvx_end

% compute utility

z = ones(d,1);
sum(xp.*repmat(z,1,n1)',1)/n1
sum(xn.*repmat(z,1,n2)',1)/n2
u = sum(xp.*repmat(z,1,n1)',1)/n1 - sum(xn.*repmat(z,1,n2)',1)/n2

sp = sum(xp.*repmat(yp,1,n1)',1)/n1 
sn = sum(xn.*repmat(yn,1,n2)',1)/n2 %- gamma*norm(yp+yn,1)/d

yn+yp
end