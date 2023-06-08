function [rc1] = ProcessPre_RC4(x,n,m,l,num,ref) % 输入ref表示rms的阈值;n/m分别是x的长度和预测的长度；l为窗口长度
                               
    nn=n+m;
    [y1,lamuda]=SSA_function(x,nn,l);
    sum2 = zeros(1,m);
    for i = 1:num
        sum1(1,:) = sum2(1,:) + y1(i,n+1:nn);
        x(n+1:nn,1) = sum1(1,:);
        uprms = 0.0; 
        while 1
            [y2,lamuda]=SSA_function(x,nn,l);
            array3 = zeros(1,m);
            for k =1:i
                array3(1,:) = array3(1,:) + y2(k,n+1:nn);
            end
            currentrms = rms(array3(1,:));
            if currentrms-uprms < ref
                break
            else
                uprms = currentrms;
                x(n+1:nn,1) = array3(1,:);
            end
        end
        sum2(1,:) = x(n+1:nn,1);
    end
    rc1 = x;
end



