clc;clear all;close all;
load("ALL_workplace_axis.mat")
str_fea = ["0.7k","1.4k","2.1k","2.8k","3.5k","4.2k","4.9k","5.6k","6.3k","7k"];

% FOS - 1 
% GLSZM - 2
% Wavelet - 3
% GLRLM - 4-8
% GLCM -9-17
% GLDZM - 18,19

figure("color","w")


figure("color","w")
tiledlayout(2,5,"TileSpacing","compact") 
for i =1:10
         
         nexttile
         hold on
         plot(all_SVMx_store(:,i),all_SVMy_store(:,i),"b","DisplayName","SVM")
         
         plot(all_KNNx_store(:,i),all_KNNy_store(:,i),"r","DisplayName","KNN") 
         plot(all_Bayex_store(:,i),all_Bayey_store(:,i),"DisplayName","Baye")
         plot([0,1],[0,1],"--b","DisplayName","Random selection")
        

         xlabel("FPR")
         ylabel("TPR")
         hold off 
         title(str_fea(i),'FontWeight','Normal')
        
        %display(str_fea(i));
        %display("Baye");
        
        Baye_AUC = trapz(all_Bayex_store(:,i),all_Bayey_store(:,i));

        %display("SVM");
        SVM_AUC=trapz(all_SVMx_store(:,i),all_SVMy_store(:,i));
    
        %display("KNN");
        KNN_AUC = trapz(all_KNNx_store(:,i),all_KNNy_store(:,i));
        display("Current is "+str_fea(i)+" so Baye is "+num2str(Baye_AUC)+" SVM is "+num2str(SVM_AUC)+"KNN is "+ num2str(KNN_AUC))
      
end 
legend
%sgtitle("Mean ROC of GLCM-GLRLM-GLSZM-GLDZM combined features for the third part tests", 'FontSize', 16,'FontWeight','bold')
