clc;clear all;close all;
load("one_together_workplace_axis.mat")
str_fea = ["FOS_no_4";"GlSZM_no";"Wavelet_haar";"GLRLM_ang0";"GLRLM_ang45";"GLRLM_ang90";"GLRLM_ang135";...
            "GLRLM_average_6";"GLCM_D1_ang0";"GLCM_D3_ang0";"GLCM_D1_ang45";"GLCM_D3_ang45";"GLCM_D1_ang90";...
            "GLCM_D3_ang90";"GLCM_D1_ang135";"GLCM_D3_ang135_6";"GLCM_average_dis_ang_727";"GLDZM_3X32";"GLDZM_5X5";...
              ];
figure(1)
subplot(1,3,1)
for i = 1:19
        hold on 
        plot(all_SVMx_store(:,i),all_SVMy_store(:,i),'LineWidth',0.05*i)                
        plot([0,1],[0,1],"--r")
        xlabel("False Postive Rate")
        ylabel("True Postive Rate")
end
 hold off 
title("SVM")
legend(str_fea)
subplot(1,3,2)
for num = 1:19
        hold on 
        plot(all_KNNx_store(:,num),all_KNNy_store(:,num),"DisplayName",str_fea(num))                 
        plot([0,1],[0,1],"--r")
        xlabel("False Postive Rate")
        ylabel("True Postive Rate")
end
legend
 hold off 
title("KNN")
%legend(str_fea)

subplot(1,3,3)
for num = 1:19
        hold on 
        plot(all_Bayex_store(:,num),all_Bayey_store(:,num))                 
        plot([0,1],[0,1],"--r")
        xlabel("False Postive Rate")
        ylabel("True Postive Rate")
end
 hold off 
title("Baye")
%legend(str_fea)
 