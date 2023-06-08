function [y,lamuda]=SSA_function(x,n,l)
    % Step1 : 建立时滞矩阵
    k1=n-l+1;
    X2=zeros(l,k1);
    for i=1:k1
        X2(1:l,i)=x(i:l+i-1);
    end
    % Step 2: 奇异值分解
    x3=X2*X2';
    [U,S,V] = svd(x3);
    for i=1:l
        V1(:,i) = X2'*U(:,i)/sqrt(S(i,i)); 
    end
    %初等矩阵重构得到l个时间序列；
    y = zeros(l,n);
    Lp=min(l,k1);
    Kp=max(l,k1);
    for i=1:l
        xi = sqrt(S(i,i)) * U(:,i) * V1(:,i)';
        y1=zeros(n,1);
        for k=0:Lp-2
            for m=1:k+1
                y1(k+1)=y1(k+1)+(1/(k+1))*xi(m,k-m+2);
            end
        end
        %重构 Lp~Kp
        for k=Lp-1:Kp-1
            for m=1:Lp
                y1(k+1)=y1(k+1)+(1/(Lp))*xi(m,k-m+2);
            end
        end
        %重构 Kp+1~N
        for k=Kp:n-1
            for m=k-Kp+2:n-Kp+1
                y1(k+1)=y1(k+1)+(1/(n-k))*xi(m,k-m+2);
            end
        end 
        y(i,:) = y1(:,1);
    end
    %将特征值输出一列
    %lamuda = zeros(l,1)
    for i = 1:l 
        lamuda(i,1) = S(i,i);
    end
end
