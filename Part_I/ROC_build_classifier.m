function classifier_built = ROC_build_classifier(feature_matrix,label,main_type,parameter_type)
    %rng("default")
    struct_para = param_check_return(main_type,parameter_type);
    if struct_para.type == "SVM"
     
        if find(convertCharsToStrings(struct_para.PolynomialO)=="[]")
            polyord = [];
        else 
            polyord =str2num(struct_para.PolynomialO);     
        end 

        if convertCharsToStrings(struct_para.KernelSc) == "auto"
            KenS = struct_para.KernelSc;
        else 
            KenS = str2num(struct_para.KernelSc);
        end 
        
        classifier_built = fitcsvm(feature_matrix, label, ...
                                'KernelFunction', struct_para.KernelFunc, ...
                                'PolynomialOrder', polyord, ...
                                'KernelScale', KenS, ...
                                'BoxConstraint', 1, ...
                                'Standardize', false, ... % 原本是true
                                'ClassNames', [0; 1] ...
                                 ...
                                ); 
     
          
    end

    if struct_para.type == "KNN"
        if find(convertCharsToStrings(struct_para.Expon)=="[]")            
            Expone =  [];
        else 
            Expone = str2num(struct_para.Expon);
        end  
       
        classifier_built = fitcknn(feature_matrix, ...
                                     label, ...
                                    'Distance', struct_para.Dis, ...
                                    'Exponent', Expone, ...
                                    'NumNeighbors', struct_para.NumNeigh, ...
                                    'DistanceWeight', struct_para.Weig, ...
                                    'Standardize', false, ... % 原本是true. 
                                    'ClassNames', [0; 1]);
     
    end 
    
    if struct_para.type == "Baye"
        len_fea = size(feature_matrix,2);
        str_jud = struct_para.bayetype; 
        if str_jud == "Kernel"
            distributionNames =  repmat({'Kernel'}, 1, len_fea);
        else
            distributionNames =  repmat({'Normal'}, 1, len_fea);
        end 

    if any(strcmp(distributionNames,'Kernel'))
        classifier_built = fitcnb(...
                                        feature_matrix, ...
                                        label, ...
                                        'Kernel', 'Normal', ...
                                        'Support', 'Unbounded', ...
                                        'DistributionNames', distributionNames, ...
                                        'ClassNames', [0; 1]);
    else
        classifier_built = fitcnb(...
                      feature_matrix, ...
                      label, ...
                     'DistributionNames', distributionNames, ...
                     'ClassNames', [0; 1]);
    end
    end
end

function structure_param = param_check_return(main_type,parameter_type)
    
    
    % SVM parameters 
    SVMType = ["Linear";"Quadratic";"Cubic";"Fine Gaussian";"Medium Gaussian";"Coarse Gaussian"];
    KernelFunction = ["linear";"polynomial";"polynomial";"gaussian";"gaussian";"gaussian"];
    PolynomialOrder = ["[]";2;3;"[]";"[]";"[]"];
    KernelScale = ["auto";"auto";"auto";2.7;11;20];
    SVM_table = table(SVMType,KernelFunction,PolynomialOrder,KernelScale);
    

    % KNN parameters 
    KNNType = ["Fine";"Medium";"Coarse";"Cosine";"Cubic";"Weighted"];
    Distance = ["Euclidean";"Euclidean";"Euclidean";"Cosine";"Minkowski";"Euclidean"];
    Exponent = ["[]";"[]";"[]";"[]";3;"[]"];
    NumNeighbors = [50;10;1000;150;100;40];% original 10.
    DistanceWeight = ["SquaredInverse";"SquaredInverse";"SquaredInverse";"SquaredInverse";"SquaredInverse";"SquaredInverse"];
    KNN_table = table(KNNType,Distance,Exponent,NumNeighbors,DistanceWeight);
    
    

    if ~isempty(strfind(main_type,'SVM'))
        idx = find(parameter_type==SVM_table.SVMType);
        structure_param.KernelFunc = SVM_table.KernelFunction{idx};
        structure_param.PolynomialO = SVM_table.PolynomialOrder{idx};
        structure_param.KernelSc = SVM_table.KernelScale{idx};
        structure_param.type = "SVM";
    else 
        if ~isempty(strfind(main_type,'KNN'))
            idx = find(parameter_type==KNN_table.KNNType);
            structure_param.Dis = KNN_table.Distance{idx};
            structure_param.Expon = KNN_table.Exponent{idx};
            structure_param.NumNeigh = KNN_table.NumNeighbors(idx);
            structure_param.Weig = KNN_table.DistanceWeight{idx};
            structure_param.type = "KNN";
        else 
            structure_param.type = "Baye";
            structure_param.bayetype = parameter_type;
        end
    end 

end 