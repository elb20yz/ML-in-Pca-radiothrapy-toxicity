function [train_store,test_store]=k_folder_complete(label,fea_matrix,num)
     
    
    indices = crossvalind('Kfold',label,num);    
    train_store = zeros(size(fea_matrix,1),num);
    test_store = zeros(size(fea_matrix,1),num);
    
    for i = 1:num


        test = (indices==i);
        train = ~test;
        
        train_store(:,i) = train;
        test_store(:,i) = test;
   
    end
end