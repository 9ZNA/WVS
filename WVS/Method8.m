function [O,u,b,Tindex] = Method8(RawData,K,alpha)
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
end

