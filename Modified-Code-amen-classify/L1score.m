
function [yp yn]=L1score(x,gamma)

% x is 2n x d, n: # of +/- examples, d: number of features
[n2 d] = size(x);

n = n2/2;
xp = x(1:n,:);
xn = x(n+1:end,:);

cvx_begin
    variable yp(d)
    variable yn(d)
    maximize( sum(sum(xp.*repmat(yp,1,n)')) + sum(sum(xn.*repmat(yn,1,n)')) - gamma*norm(yp+yn,1) )
    subject to
        0 <= yp <= 1
        0 <= yn <= 1
        %0 <= yp+yn <= 1 %comment-out to find common ones :sum of yn+yp entry is 2
cvx_end

% compute utility

z = ones(d,1);
u = sum(xp.*repmat(z,1,n)',1) - sum(xn.*repmat(z,1,n)',1)

sp = sum(xp.*repmat(yp,1,n)',1) 
sn = sum(xn.*repmat(yn,1,n)',1) %- gamma*norm(yp+yn,1)/d

yn+yp
end