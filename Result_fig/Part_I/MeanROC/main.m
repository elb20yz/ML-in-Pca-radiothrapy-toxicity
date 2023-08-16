clc;clear all;close all;
load("one_together_workplace_axis.mat")
str_fea = ["FOS";"GLSZM";"Wavelet";"GLRLM ang0^{\circ}";"GLRLM ang45^{\circ}";"GLRLM ang90^{\circ}";"GLRLM ang135^{\circ}";...
            "Average GLRLM ";"GLCM ang0^{\circ} and D1";"GLCM ang0^{\circ} and D3 ";"GLCM ang45^{\circ} and D1 ";"GLCM ang45^{\circ} and D3";"GLCM ang90^{\circ} and D1";...
            "GLCM ang90^{\circ} and D3 ";"GLCM ang135^{\circ} and D1";"GLCM ang135^{\circ} and D3 ";"Average GLCM";"GLDZM 3X3";"GLDZM 5X5";...
              ];

% FOS - 1 
% GLSZM - 2
% Wavelet - 3
% GLRLM - 4-8
% GLCM -9-17
% GLDZM - 18,19

figure("color","w")
tiledlayout(4,5,"TileSpacing","compact") 
for i = [9:17,4:8,18,19,2,1,3]
         %subplot(4,4,i,"pos",)
         %subplot(4,4,i)
         nexttile
         hold on
         plot(all_SVMx_store(:,i),all_SVMy_store(:,i),"DisplayName","SVM")    
         plot(all_KNNx_store(:,i),all_KNNy_store(:,i),"DisplayName","KNN") 
         plot(all_Bayex_store(:,i),all_Bayey_store(:,i),"DisplayName","Baye")
         plot([0,1],[0,1],"--b","DisplayName","Random selection")
         xlabel("FPR")
         ylabel("TPR")
         hold off 
         title(str_fea(i),"FontWeight","bold")
         
  
        Baye_AUC = trapz(all_Bayex_store(:,i),all_Bayey_store(:,i));

        %display("SVM");
        SVM_AUC=trapz(all_SVMx_store(:,i),all_SVMy_store(:,i));
    
        %display("KNN");
        KNN_AUC = trapz(all_KNNx_store(:,i),all_KNNy_store(:,i));
        display("Current is "+str_fea(i)+" so Baye is "+num2str(Baye_AUC)+" SVM is "+num2str(SVM_AUC)+" KNN is "+ num2str(KNN_AUC))
end 
legend
