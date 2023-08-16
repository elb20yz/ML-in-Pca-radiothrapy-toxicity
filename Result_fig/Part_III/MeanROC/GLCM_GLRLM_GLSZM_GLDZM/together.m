clc;clear all;close all;
% str_fea = ["FOS_no_4";"GlSZM_no";"Wavelet_haar";"GLRLM_ang0";"GLRLM_ang45";"GLRLM_ang90";"GLRLM_ang135";...
%             "GLRLM_average_6";"GLCM_D1_ang0";"GLCM_D3_ang0";"GLCM_D1_ang45";"GLCM_D3_ang45";"GLCM_D1_ang90";...
%             "GLCM_D3_ang90";"GLCM_D1_ang135";"GLCM_D3_ang135_6";"GLCM_average_dis_ang_727";"GLDZM_3X32";"GLDZM_5X5";...
%               ];
% 0.7k GLCM_GLRLM_GLSZM_GLDZM
str_fea = ["0.7k728","1.4k","2.1k","2.8k","3.5k","4.2k","4.9k","5.6k","6.3k","7k"];

all_SVMx_store = [];
all_SVMy_store = [];
all_KNNx_store = [];
all_KNNy_store = [];
all_Bayex_store = [];
all_Bayey_store = [];
all_xaxis_store =cell(10,1);
all_yaxis_store =cell(10,1);
all_axis_store =cell(10,1);
Mean_AUC_store = ["SVM","KNN","Baye","Feature name"];
for q =1:10
    na = str_fea(q)
    load("together\factor_"+str_fea(q)+"_axis.mat")
%     str_var = str_fea(1);
%     eval( [str_var, '= 10']);
    Mean_AUC_store = [Mean_AUC_store;trapz(SVM_axis(:,1),SVM_axis(:,2)),trapz(KNN_axis(:,1),KNN_axis(:,2)),trapz(Baye_axis(:,1),Baye_axis(:,2)),na];
%     figure(1)
%     hold on 
%     plot(SVM_axis(:,1),SVM_axis(:,2));
%     title("SVM")
%     
%     axis on 
    all_SVMx_store = [all_SVMx_store,SVM_axis(:,1)];
    all_SVMy_store= [all_SVMy_store,SVM_axis(:,2)];
    all_KNNx_store = [all_KNNx_store,KNN_axis(:,1)];
    all_KNNy_store = [all_KNNy_store,KNN_axis(:,2)];
    all_Bayex_store = [all_Bayex_store,Baye_axis(:,1)];
    all_Bayey_store = [all_Bayey_store,Baye_axis(:,2)];
end
% legend(str_fea)
all_xaxis_store ={all_SVMx_store,all_KNNx_store,all_Bayex_store};
all_axis_store = {all_SVMy_store,all_KNNy_store,all_Bayey_store};