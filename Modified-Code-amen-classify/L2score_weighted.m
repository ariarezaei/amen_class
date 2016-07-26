
function [yp, yn]=L2score_weighted(x,n1,lambda)

% x is (n x d), n: # of +/- examples, d: number of features
[n, d] = size(x);
n2 = n-n1;


xp = x(1:n1,:);
xn = x(n1+1:end,:);

cvx_begin
    variable yp(d)
    variable yn(d)
    expression spnorm(n1);
    Sp = xp.*repmat(yp,1,n1)';
    for i=1:n1
        spnorm(i) = norm(Sp(i,:));
    end   
    expression snnorm(n2);
    Sn = xn.*repmat(yn,1,n2)';
    for j=1:n2
        snnorm(j) = norm(Sn(j,:));
    end   
    minimize( sum( spnorm ) + sum( snnorm ) ) %- lambda*norm(yp+yn,1) )
    subject to
        0 <= yp; % <= 1
        0 <= yn; % <= 1
%         0 <= yp+yn <= 1
cvx_end

% compute utility

% z = ones(d,1);
% u = sum(xp.*repmat(z,1,n)',1) - sum(xn.*repmat(z,1,n)',1)
% 
% s = sum( (xp.*repmat(yp,1,n)').^2 ,1 ) + sum( (xn.*repmat(yn,1,n)').^2 ,1 ) %- gamma*norm(yp+yn,1)/d

end