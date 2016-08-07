
% ave_prcntl = zeros(2, numel(policy));
cong_pol = cell(2,1);

for party=1:2
%     if (party == 1)
%         continue;
%     end
    for i=1:numel(policy)
        if (numel(findstr('armed', policy{i})) > 0)
            [p, ave_p] = stat_policyNormRank(all_amen, policy(i), party);
            cong_pol{party}{i,1} = policy{i};
            cong_pol{party}{i,2} = ave_p;
            if (party == 1)
                figure((party-1)*numel(policy) + i);
            end
            stat_congressPlot(p, policy{i}, party);
            hold on;
        end
    end
    
%     cong_pol{party} = sortrows(cong_pol{party}, 2);
end
