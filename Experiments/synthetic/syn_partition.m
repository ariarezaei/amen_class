function [part, score, time] = syn_partition(Xs, method)

method = lower(method);

% Check if SWP
if (strfind(method, 'swp') > 0)
    tic;
    [part, score] = SWP_Amen(Xs);
    time = toc;
    return;
end

% Check if Greedy
if (strfind(method, 'greedy') > 0)
    tic;
    [part, score] = SWP_Real_Greedy(Xs);
    time = toc;
    return;
end

% Check if Brute force
if (strfind(method, 'brute') > 0)
    tic;
    [part, score] = SWP_Brute(Xs);
    time = toc;
    return;
end

% Check if simplified
if (strfind(method, 'simp') > 0)
    tic;
    [part, score] = Not_SWP(Xs);
    time = toc;
end

% Check if top K
if (strfind(method, 'top') > 0)
%     splt = strsplit(method, '-');
    splt = regexp(method, '[-.]', 'split');
    K = str2double(splt{end});
    tic;
    [part, score] = SWP_Lazy_Greedy(Xs, K);
    time = toc;
    return;
end

end