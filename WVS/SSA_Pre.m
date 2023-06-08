function [y,n1]=SSA_Pre(x,n,m) %输入old序列和预测的长度m
    n1 = n+m;
    y = zeros(n1,1);
    y(1:n,1) = x(:);
end
