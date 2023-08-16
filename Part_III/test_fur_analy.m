function value_analys=test_fur_analy(pre_label,label)
  
%     zeros_num = find(label == 0); % 0 的总数
%     ones_num = find(label == 1);  %  1的总数
%     corret_idx = find(label == pre_label); % 正确分类
%     correct_label = label(corret_idx);
%     
%     zeros_label_corect = numel(find(correct_label == 0)); % True Postive 
%     ones_label_corect = numel(find(correct_label == 1)); % True Negative. 
%     Tp = zeros_label_corect;
%     Tn = ones_label_corect;
% 
%     Fp = numel(zeros_num) - zeros_label_corect;
%     Fn = numel(ones_num) - ones_label_corect;


    cm = confusionmat(label,pre_label);  
    Tp = cm(1,1);
    Tn = cm(2,2);
    Fp = cm(2,1);
    Fn = cm(1,2);
    
    P = Tp+Fn;
    N = Fp+Tn;
    SPE = Tn/(Tn+Fp);
    SEN = Tp/(Tp+Fn);
    value_analys.TP = Tp;
    value_analys.TN = Tn;
    value_analys.FN = Fn;
    value_analys.FP = Fp;
    value_analys.Tp_rate = Tp/(Tp+Fn);
    value_analys.Fp_rate = Fp/(Fp+Tn);
    value_analys.Specificity = SPE;
    value_analys.Sensitivituy = SEN;
    value_analys.ACC = (Tp+Tn)/(Fp+Fn+Tp+Tn);

    value_analys.ACCvalid = ACC_calculator(pre_label,label);
end 

function ACC = ACC_calculator(predict_label,test_label)
    ACC = numel(find(predict_label==test_label))/size(test_label,1);
end

