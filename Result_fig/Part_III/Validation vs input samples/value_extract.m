function [three_va_AUC,four_va_AUC]=value_extract(value_name,type)
    load table_store.mat;
    if value_name == "ValidationAUC"
        col_idx = 3;
    end
    if value_name == "ValidationACC"
        col_idx = 4;
    end
    if value_name == "TestAUC"
        col_idx = 5;
    end 
    if value_name == "TestAUC"
        col_idx = 6;
    end
    used_metric = table2array(table_used(:,col_idx));
    SVM_index = find(table2array(table_used(:,2))==type);
    three_idx = SVM_index(1:2:19);
    four_idx = SVM_index(2:2:20);
    three_va_AUC = used_metric(three_idx);
    four_va_AUC = used_metric(four_idx);
end