function [signal,u,b,Tindex] = Method4(RawData,K,alpha)
[a,b]=size(RawData);
tol=1e-7;
       
tau = 0;            
DC = 0;            
init = 1;          

   [u, u_hat, omega] = VMD(RawData, alpha, tau, K, DC, init, tol);
 
Signal=u';

[col,row]=size(Signal);


o=zeros(size(Signal,1),1);

for i=1:row
    o=o+Signal(:,i);
    U(:,i)=o;
end
Tindex=calT(RawData',U');
[~,b]=min(Tindex);

O=zeros(size(Signal,1),1);

for m=1:b
O=O+Signal(:,m);
end
if b<row
X=zeros(size(Signal,1),1);
[x,y]=size(U);
for n=b+1:row
Y=X+Signal(:,n);
end
[Signal_SSA]=Method2(Y);

signal=Signal_SSA+O;
else 
    signal=O;
end
end

%%
%[m,n]=size(U);
%for i=1:n
 %  EU(i) = sum(sum(U(:,i).^2,2));    %求取各个IMF分量的能量
%end
%disp(['所有U分量的能量'])
%disp(U(1:n))

%E = sum(EU);                      %所有IMF分量的能量和
%for j = 1:n
   % p(j) = EU(j)/E;               %各个IMF分量能量占总能量的占比
    %HE(j)=-sum(p(j).*log(p(j)));
%end
%disp('U分量的能量熵');
%disp(HE(1:n));

%[pks,locs] = min(HE);
     % k=locs;
    
%y=U-x;
 % [data,k,allmode] = Method1(U)
%[m,n]=size(U);
%O=zeros(size(U,1),1);

%for i=1:n
   % O=O+U(:,i);  
%end

%for i=1:n

%end

