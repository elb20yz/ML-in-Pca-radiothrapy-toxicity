clc;clear all;close all;

str_fea = ["GLCM_GLDZM";"GLCM_GLRLM";"GLCM_GLSZM";"GLRLM_GLSZM";"GLRLM_GLDZM";"GLRLM_GLDZM";...
            "GLCM_GLRLM_GLDZM";"GLCM_GLRLM_GLSZM";"GLCM_GLDZM_GLSZM";"GLRLM_GLDZM_GLSZM";...
            "GLCM_GLRLM_GLDZM_GLSZM"];

for idk_nam = 1:size(str_fea,1)
    qw = str_fea(idk_nam)
    
    load("set_two\"+qw+".mat")
    load("label.mat")
    rng("default");
    display(qw);

    str = qw;
    fea_test_name = qw+"_727";

    times = 20;
    mean_times = 10;
    one_classifier_result = cell(14,mean_times);


% if idk_nam ==1
    %re_matrix = PCA_res(fea_matrix); % only with PCA
    %display("onlyPCA")
    %continue
% else 
    % with Chi-square test selection and PCA. 
    sele_fea = fea_sele(feature_matrix,label);
    size(sele_fea,2)
    re_matrix = PCA_res(sele_fea);
    size(re_matrix,2)
    %continue
% end

fea_num = size(re_matrix,2)

num = 5;
all_result = cell(8,14,1);
crit_values = cell(8,14);



for diff_group = 1:8
    cvp = cvpartition(label, 'Holdout', 0.25);    
    train_fea = re_matrix(cvp.training, :);
    train_label = label(cvp.training, :); 
    test_fea = re_matrix(cvp.test, :);
    test_label = label(cvp.test, :);


for idx_clas = 1:14
    [main_type,sub_type]=select_classifer(idx_clas);    
    
    str_total = main_type+sub_type;
    
    display("Current in");
    display(idx_clas);
    display(str_total);
    
%% Recording inilization
    test_label_store = {times,num};
    test_scores = {times,num};
    pre_label_store = {times,num};
    analysis_store = {times,num};
    X_store = [];
    Y_store = [];
  
    ACC_store = [];
    SEN_store = [];
    SPE_store = [];
    AUC_store = [];
    classifier_test = ROC_build_classifier(train_fea,train_label,main_type,sub_type);
    [heldout_AUC,heldout_anlys,heldout_axis]=test_part_test(classifier_test,test_fea,test_label);
    display(heldout_AUC);
    display(heldout_anlys.ACC)
%% Vaildation starts 
    for i = 1:times
        % Test part test 
        
       
        % Train part test
        [train_idx,test_idx] = k_folder_complete(train_label,train_fea,5);
        for cla_idx = 1:5
            
            islog_train = logical(train_idx(:,cla_idx));
            islog_test = logical(test_idx(:,cla_idx));
            
            k_train_fea = train_fea(islog_train,:);
            k_train_label = train_label(islog_train);
            k_test_fea = train_fea(islog_test,:);
            k_test_label = train_label(islog_test);
            
            classifier_be = ROC_build_classifier(k_train_fea,k_train_label,main_type,sub_type);
            if main_type == "SVM"
                [classifier,~]=fitSVMPosterior(classifier_be);
            else 
                classifier = classifier_be;
            end
        
            [label_kfold,kfoldScores] = predict(classifier,k_test_fea); 
            
           
            
            rocObj = rocmetrics(k_test_label,kfoldScores(:,1),0,"AdditionalMetrics","tn");%"AdditionalMetrics","spec");%"FixedMetricValues",range_used);
            rocObj = addMetrics(rocObj,["tp","tn","fn","fp","accu","spec"]);
            [axis_own,own_AUC]=drawROC(classifier,k_test_label,kfoldScores);
            ans_out =test_fur_analy(label_kfold,k_test_label);
            pair_AUC = [own_AUC,rocObj.AUC];
            ACC_store = [ACC_store,ans_out.ACC];
            SEN_store = [SEN_store,ans_out.Sensitivituy];
            SPE_store = [SPE_store,ans_out.Specificity];
            AUC_store = [AUC_store;pair_AUC];
            
            X=axis_own(:,1);
            Y=axis_own(:,2);
           
            X_store = [X_store, X];
            Y_store = [Y_store, Y];
            test_label_store{i,cla_idx} = k_test_label;
            pre_label_store{i,cla_idx}=label_kfold;
            test_scores{i,cla_idx}=kfoldScores(:,1);
        end       
    end

    Mean_ACC = mean(ACC_store);
    Mean_SEN = mean(SEN_store);
    Mean_SPE = mean(SPE_store);
    [Mean_AUC,axis_mean]= mean_AUCROC(X_store,Y_store);
   
    MAUC = {Mean_AUC,axis_mean};
    value = resu_table(str_total,Mean_AUC,Mean_ACC,Mean_SEN,Mean_SPE);
    crit_values{diff_group,idx_clas}={str_total,MAUC,Mean_ACC,Mean_SEN,Mean_SPE,heldout_AUC,heldout_anlys.ACC};
    all_result{diff_group,idx_clas,:}={value,MAUC,heldout_AUC,heldout_anlys,AUC_store,heldout_axis,test_label,test_fea,axis_mean,train_label,train_fea};
    
    %name = ["modelname","Meanaxis","MeanAUC","MeanACC","MeanSEN","MeanSPE","holdoutAUC","holdoutAnalys","Holdaxis","Holdoutlable","Holdoutfeature"];
end
end


save("result\important\"+fea_test_name+"thirdimp.mat","crit_values","all_result")
save("result\workplace\"+fea_test_name+'third_workplace_store')
feature_matrix = [];
fea_matrix = [];
end
%plot(axis_mean(:,1),axis_mean(:,2))


%% Built-in Functions
function fea = PCA_res(feature_matrix)
    [~,red_fea,~,~,explained]=pca(normalize(feature_matrix),"Algorithm","eig");
        for i = 1:size(feature_matrix,1)
            total_var = sum(explained(1:i));
            
            if total_var >=95
                display(total_var)
                display(i)
                break;
            end
        end       
        fea = red_fea(:,1:i);
end

function [MeanAUC,axis_mean]=mean_AUCROC(X_store,Y_store)
  
     X_axismean = mean(X_store,2);
     Y_axismean = mean(Y_store,2);
     axis_mean = [X_axismean,Y_axismean];
     MeanAUC = trapz(X_axismean,Y_axismean);
end

function ACC = ACC_calculator(predict_label,test_label)
    
    ACC = numel(find(predict_label==test_label))/size(test_label,1);

end

function [result] = parameter_store(str_total,pre_label_store,test_label_store,test_scores,analysis_store,X_store,Y_store)
    result_table = cell(1,6);
    result_table{1} = pre_label_store';
    result_table{2} = test_label_store';
    result_table{3} = test_scores';
    result_table{4} = analysis_store';
    result_table{5} = X_store;
    result_table{6} = Y_store;
    result.table_store = result_table;
    result.title = str_total;
    result_table{7} = "Predict_label,test_label,scores,analysis_store,X,Y";
    
end

function [X,Y]= extract_XY(test_label,scores)
    rocObj = rocmetrics(test_label,scores(:,1),0);
    FPR = rocObj.Metrics(:,3);
    TPR = rocObj.Metrics(:,4);
    X = table2array(FPR);
    Y = table2array(TPR);
end

function isused =check_samerow(X,ref)
    if size(X,1) == size(ref,1)
        isused = true;
    else 
        isused = false;
    end 
end

function [value]=resu_table(classifier_name,Mean_AUC,Mean_ACC,Mean_SEN,Mean_SPE)
    
    value = {classifier_name,Mean_AUC,Mean_ACC,Mean_SEN,Mean_SPE};
    
end

function [AUC,result,axis]=test_part_test(classifier,test_fea,test_label)
    [pre_label,scores]=predict(classifier,test_fea);
    rocobj = rocmetrics(test_label,scores(:,1),0);
    AUC = rocobj.AUC;
    FPR = rocobj.Metrics(:,3);
    TPR = rocobj.Metrics(:,4);
    X = table2array(FPR);
    Y = table2array(TPR);
    axis = [X,Y];

    plot(axis(:,1),axis(:,2))

    result = test_fur_analy(pre_label,test_label);
end


function selected_fea = fea_sele(feature_matrix,label)
    [featureIndex,scores] = fscchi2(feature_matrix,label);
    numFeaturesToKeep = 30;
    selected_fea = feature_matrix(:,featureIndex(1:numFeaturesToKeep));
end
