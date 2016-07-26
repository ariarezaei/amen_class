function io_stability(res, filepath, K)

file = fopen(filepath, 'w');
% 
% m_classes = numel(amen_res);
% util_label = cell(m_classes, 1);
% util = cell(m_classes,1);
% ave_rank = cell(m_classes,1);
% for cls = 1:numel(amen_res)
%     util_label{cls} = amen_res{cls}(:,1);
%     util{cls} = cell2mat(amen_res{cls}(:,2));
%     ave_rank{cls} = cell2mat(amen_res{cls}(:,3));
%     var_rank{cls} = cell2mat(amen_res{cls}(:,4));
% end

for cls=1:numel(res)
    
    fprintf(file ,'Class = %d\n', cls); 
    k_feats = size(res{cls},1);
    
%     res = cell(numel(util_label{cls}),3);
%     for i=1:numel(util_label{cls})
%         res{i,1} = util_label{cls}{i};
%         res{i,2} = util{cls}(i,2);
%         res{i,3} = ave_rank{cls}(i);
%     end
%     
%     res = sortrows(res, 3);
    
    fprintf(file, 'Rank:\n');
    for i=1:min(k_feats,K)
        fprintf(file, '%d\t%s\t%.4f\t%.4f\t%.4f\n',...
             i, res{cls}{i,1}, res{cls}{i,2}, ...
             res{cls}{i,3}, res{cls}{i,4});
    end
    fprintf(file, '\n\n');
    
end

fclose(file);

end