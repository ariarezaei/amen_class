function [ pureA, pureB, common ] = Utility_separate( a, b )
% Input:
%   - A: a vector of integers
%   - B: a vector of integers
% Output:
%   - pureA: elements in A - B
%   - pureB: elements in B - A
%   - common: common elements in A and B

% if (size(a,1) == 1)
%     % In order to sort A, it needs to be a column vector
%     a = a';
% end
% 
% if (size(b,1) == 1)
%     % In order to sort B, it needs to be a column vector
%     b = b';
% end
% fprintf('Separation------------------\n');
% fprintf('A: %s\nB: %s\n',sprintf('%d ',a),sprintf('%d ',b));

% Sorting vectors
a = sortrows(a')';
b = sortrows(b')';

% fprintf('Sorted A: %s\nSorted B: %s\n',sprintf('%d ',a),sprintf('%d ',b));

% Initialization
aPtr = 1;
bPtr = 1;
pureA = [];
pureB = [];
common = [];

while ((aPtr <= numel(a)) && (bPtr <= numel(b)))
    if (a(aPtr) == b(bPtr))
        % Putting the common element in [common]
        % Moving on in both A and B
        common = [common a(aPtr)];
        aPtr = aPtr + 1;
        bPtr = bPtr + 1;
    elseif (a(aPtr) < b(bPtr))
        % Putting current element in A into pure A
        % Moving on in A
        pureA = [pureA a(aPtr)];
        aPtr = aPtr + 1;
    else % a(aPtr) > b(bPtr)
        % Putting current element in B into pure B
        % Moving on in B
        pureB = [pureB b(bPtr)];
        bPtr = bPtr + 1;
    end
end

% Putting the remainder of elements in A into pure A
if (aPtr <= numel(a))
    pureA = [pureA a(aPtr:end)];
end

% Putting the remainder of elements in B into pure B
if (bPtr <= numel(b))
    pureB = [pureB b(bPtr:end)];
end

% fprintf('Pure A: %s\nPure B: %s\nCommon Elements: %s\n',sprintf('%d ',pureA),...
%     sprintf('%d ',pureB),...
%     sprintf('%d ',common));


end

