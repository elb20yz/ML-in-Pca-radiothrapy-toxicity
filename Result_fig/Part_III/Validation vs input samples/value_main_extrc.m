clc;clear all;close all;
value_name = "ValidationAUC";
type = ["SVM";"KNN";"Baye"];
store_value_three = [];
store_value_four = [];
x_axis = 0.7:0.7:7;

for i = 1:3 
    [three_va_AUC,four_va_AUC]=value_extract(value_name,type(i));
    store_value_four = [store_value_four,four_va_AUC];
    store_value_three = [store_value_three,three_va_AUC];
end

figure("color","w")
figure(1)

tiledlayout(2,1)
ax1 = nexttile;
hold on
for q = 1:3 
    type(q)
    x_axis,store_value_three(:,q)
    plot(x_axis,store_value_three(:,q),"-*","DisplayName",type(q));
    %store_value_three(:,q)
end
hold off

title("(a) GLCM-GLRLM-GLSZM")
xlabel("The number of the input samples (k)")
ylabel("Validation AUC")
legend


ax2 = nexttile;
%figure(2)
hold on
for q = 1:3 
    plot(x_axis,store_value_four(:,q),"-*","DisplayName",type(q));
end
hold off

title("(b) GLCM-GLRLM-GLSZM-GLDZM")
xlabel("The number of the input samples (k)")
ylabel("Validation AUC")
legend
linkaxes([ax1,ax2],"xy")
%sgtitle("Validation AUC verse scale", 'FontSize', 16,'FontWeight','bold')