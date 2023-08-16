clc;clear all;close all;
str_fea = ["FOS_no_4";"GLCM_D1_ang0";"GLCM_D1_ang45";"GLCM_D1_ang90";"GLCM_D1_ang135";"GLCM_D1_average";"GLCM_D3_ang0";"GLCM_D3_ang45";...
            "GLCM_D3_ang90";"GLCM_D3_ang135";"GLCM_D3_average_6";"GLDZM_3X32";"GLDZM_5X5";"GLRLM_ang0";"GLRLM_ang45";"GLRLM_ang90";"GLRLM_ang135";"GLRLM_average_6";...
            "GlSZM_no";"Wavelet_haar";"GLCM_average_dis_ang_727"];

for i = 1:19
    load("important\"+str_fea(i)+"thirdimp.mat");
    nam = str_fea(i);
    [tabel_resul]=table_generator(crit_values,nam);
end