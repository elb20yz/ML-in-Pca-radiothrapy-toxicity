function [axis,AUC]=drawROC(model,test_label,scores)
    X = [];
    Y = [];
    used_scr = scores(:,1);
 
    [A,I]=sort(used_scr);
    label = test_label(I);
    new_label=A;
    if max(used_scr)>1 || min(used_scr)<0
        display(used_scr)
    end
    for i = -1.5:0.001:1.5 
        T = i;
        pre = zeros(size(scores,1),1);
        idx = find(new_label>=T);
        pre(idx) = 1;

        res = test_fur_analy(pre,label);
        X = [X,res.Tp_rate];
        Y = [Y,res.Fp_rate];

    end
    X(isnan(X))=0;
    Y(isnan(Y))=0;
    AUC = trapz(X,Y);
    
    axis = [X',Y'];
    %plot(X,Y,"r-")
end