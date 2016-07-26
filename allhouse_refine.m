for i=103:110
    load(['..\backup dataset\house_' num2str(i) '.mat']);
    gc = dlmread(['cpp\gc\house_' num2str(i) '.gc']);
    
    A = A(gc,gc);
    A_label = A_label(gc);
    F = F(gc,:);
    P = P(gc);
    
    sumf = sum(F);
    goodFeats=  sumf > 0;
    F = F(:,goodFeats);
    F_label = F_label(goodFeats);
    
    dataset_name = ['house ' num2str(i)];
    save(['dataset\house_' num2str(i) '.mat'], 'A', 'F', 'A_label', 'F_label', 'P', 'dataset_name');
    
end