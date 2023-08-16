function [main_type,sub_type] = select_classifer(idx)   

    main_type_lib = ["SVM";"SVM";"SVM";"SVM";"SVM";"SVM";"KNN";"KNN";"KNN";"KNN";"KNN";"KNN";"Baye";"Baye"];
    sub_type_lib = ["Linear";"Quadratic";"Cubic";"Fine Gaussian";"Medium Gaussian";"Coarse Gaussian";...
                "Fine";"Medium";"Coarse";"Cosine";"Cubic";"Weighted";...
                "Kernel";"Normal"];
    content = [main_type_lib,sub_type_lib];

    main_type = content(idx,1);
    sub_type = content(idx,2);

end 