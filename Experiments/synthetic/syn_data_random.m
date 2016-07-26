function Xs = syn_data_random(n_coms, k_feats, m_targets)

Xs = cell(m_targets, 1);

for cls = 1:m_targets
    Xs{cls} = [];
    mu = normrnd(0, 1, k_feats, 1);
    sigma = rand(k_feats, 1);
    
    for f = 1:k_feats
        Xs{cls}(:,f) = normrnd(mu(f), abs(sigma(f)), n_coms, 1);
    end
    
    Xs{cls}(Xs{cls}<0) = 0;
end

end