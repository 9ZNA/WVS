%%贡献率
function [n,array2] = Contribution_rate(lamuda,l,ref) %输入奇异值、窗口长度、阈值(0,1)
    sum1 = sum(lamuda(:));
    for i=1:l
        sum2 = sum(lamuda(1:i));
        num = sum2/sum1;
        array2(i) = num;
        if num >= ref
            n = i;
            break
        end
    end
end



