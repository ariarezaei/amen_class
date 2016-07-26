
function [yp yn]=L2score(x,gamma)

% x is 2n x d, n: # of +/- examples, d: number of features
[n2 d] = size(x);

n = n2/2;
xp = x(1:n,:);
xn = x(n+1:end,:);

cvx_begin
    variable yp(d)
    variable yn(d)
    maximize( sum( sqrt(sum( (xp.*repmat(yp,1,n)').^2, 2 )) ) +sum( sqrt(sum( (xn.*repmat(yn,1,n)').^2, 2 )) ) ) % - gamma*norm(yp+yn,1) )
    subject to
        0 <= yp <= 1
        0 <= yn <= 1
       % 0 <= yp+yn <= 1
cvx_end

% compute utility

z = ones(d,1);
u = sum(xp.*repmat(z,1,n)',1) - sum(xn.*repmat(z,1,n)',1)

s = sum( (xp.*repmat(yp,1,n)').^2 ,1 ) + sum( (xn.*repmat(yn,1,n)').^2 ,1 ) %- gamma*norm(yp+yn,1)/d

end