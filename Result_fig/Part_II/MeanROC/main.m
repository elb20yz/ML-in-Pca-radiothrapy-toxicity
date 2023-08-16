clc;clear all;close all;
load("combined_together_workplace_axis.mat")
str_fea = ["GLCM-GLRLM";"GLCM-GLDZM";"GLCM-GLSZM";"GLRLM-GLDZM";"GLRLM-GLSZM";"GLSZM-GLDZM";...
            "GLCM-GLRLM-GLDZM";"GLCM-GLRLM-GLSZM";"GLCM-GLDZM-GLSZM";"GLRLM-GLDZM-GLSZM";...
            "GLCM-GLRLM-GLDZM-GLSZM"];
% FOS - 1 
% GLSZM - 2
% Wavelet - 3
% GLRLM - 4-8
% GLCM -9-17
% GLDZM - 18,19

figure("color","w")

tiledlayout(3,4,"TileSpacing","compact") 
for i =1:11
         
         nexttile
         hold on
         plot(all_SVMx_store(:,i),all_SVMy_store(:,i),"DisplayName","SVM")    
         plot(all_KNNx_store(:,i),all_KNNy_store(:,i),"DisplayName","KNN") 
         plot(all_Bayex_store(:,i),all_Bayey_store(:,i),"DisplayName","Baye")
         plot([0,1],[0,1],"--b","DisplayName","Random selection")
         xlabel("FPR")
         ylabel("TPR")
         hold off 
         title(str_fea(i))
         
     
        
        Baye_AUC = trapz(all_Bayex_store(:,i),all_Bayey_store(:,i));

        %display("SVM");
        SVM_AUC=trapz(all_SVMx_store(:,i),all_SVMy_store(:,i));
    
        %display("KNN");
        KNN_AUC = trapz(all_KNNx_store(:,i),all_KNNy_store(:,i));
        display("Current is "+str_fea(i)+" so Baye is "+num2str(Baye_AUC)+" SVM is "+num2str(SVM_AUC)+"KNN is "+ num2str(KNN_AUC))



end 
legend
