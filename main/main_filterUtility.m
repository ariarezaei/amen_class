function [util, util_label, final_part] = main_filterUtility(Xs, part, F_label, feats, alpha)

m_classes = numel(feats);
k_feats = numel(F_label);
% fprintf('There are %d features\n', k_feats);
% fprintf('The size of F_label is %d\n', numel(F_label));
% fprintf('Max for %s is %d\n', feats{1}, max(part{1}));
% fprintf('Max for %s is %d\n', feats{2}, max(part{2}));

% fprintf('Sorted by relative utility:\n');
util = cell(m_classes,1);
util_label = cell(m_classes,1);
for cls=1:m_classes
%     fprintf('\n\n');
%     fprintf('\t%s:\n', feats{cls});
%     fprintf('\tIt has %d features\n', numel(part{cls}));
    
    n_select = numel(part{cls});
    util{cls} = zeros(n_select, 3);
    n_coms = size(Xs{cls},1);
    n_other = size(Xs{3-cls},1);
    for f=1:n_select
        cur_feat = part{cls}(f);
        util{cls}(f,1) = cur_feat;
        util{cls}(f,2) = sum(Xs{cls}(:,cur_feat))/n_coms - ...
            sum(Xs{3-cls}(:, cur_feat))/n_other;
% %         util{cls}(f,2) = stat_featRelUtil(Xs, cls, part, cur_feat);
%         util{cls}(f,3) = stat_featAbsUtil(Xs{cls}, part{cls}, cur_feat);
    end
    
    util{cls} = sortrows(util{cls}, [-2]);
    util_label{cls} = F_label(util{cls}(:,1));
    
%     fprintf('Feature Name\tRelative Utility\tAbsolute Utility\n');
%     for f=1:numel(util_label{cls})
%         fprintf('%s\t%.5f\t%.5f\n', util_label{cls}{f}, ...
%             util{cls}(f,2), util{cls}(f,3));
%     end
    
    max_util = max(util{cls}(:,2));
    final_part{cls} = util_label{cls}(util{cls}(:,2) > alpha * max_util);
end

% fprintf('Max of 1 is %.3f, Max of 2 is %.3f\n', max(util{1}(:,2)), max(util{2}(:,2)));
% 
max_util = max(max(util{1}(:,2)), max(util{2}(:,2)));
min_util = min(min(util{1}(:,2)), min(util{2}(:,2)));

for cls = 1:m_classes
    
    for i=1:numel(part{cls})
        util{cls}(i,2) = (util{cls}(i,2) - min_util) / (max_util - min_util);
    end
    
    util{cls} = sortrows(util{cls}, -2);
    util_label{cls} = F_label(util{cls}(:,1));
    
end

end