
function [lb,ub,dim,fobj] = Get_Functions_details(F)   


switch F
    case 'F1'
        fobj = @F1;
        lb = [2 1000];   % alpha范围 K范围   下限
ub = [20 10000]
%         dim=30;
        dim=2;
    

end

% F1
function o = F1( x1, x2 ,f)

alpha =x2;        % moderate bandwidth constraint
 
tau = 0;            % noise-tolerance (no strict fidelity enforcement)
 
K = x1;              % 4 modes
 
DC = 0;             % no DC part imposed
 
init = 1;           % initialize omegas uniformly
 
tol = 1e-7;

% for K=2:3
%     for alpha=1000:100:1500

 
  [u, u_hat, omega] = VMD(f, alpha, tau, K, DC, init, tol);
 
 %for i=1:size(u,1)
  % H(i,:) =  hilbert(u(i,:));
%end
% disp(['所有个IMF分量的能量'])
% disp(Eimf(1:N-1))
% 能量熵
%a=sum(H,2);

%for j = 1:size(u,1)
  %  p(j) = H(j)/a(j);
   % HE(j)=-sum(p(j).*log(p(j)));
%end

for j=1:x1
H=hilbert(u(j,:));
        HJ=abs(H);
        p=HJ./sum(HJ);
        HE(j,:)=-sum(p.*log10(p));
       end
% m=2;
% %SampEnVal=cell(1,size(u,1));
%  for i=1:size(u,1)
%      r=0.15*std(u(i,:));
%      SampEnVal(i,1) = SampEn(u(i,:), m, r);
%  end
% %mi=cell(1,size(u,1));
% wind_size = size(u,2);
 %for i=1:size(u,1)
     %wind_size = size(u,2);
   %mi(i,1) = calc_mi(u(i,:)', f', wind_size);
     
 %end
o=min(HE);
 
% o=-(b(1,1)+b(2,1));

    %end
%end
end
end

