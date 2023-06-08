function Tindex =calT(f,u)
for i=1:size(u,1)
rmse(i,1) = sqrt(mean((f-u(i,:)).^2));
end
df = diff(f,1,2);
dpf = diff(u,1,2);
for i=1:size(u,1)
R(i,1) = sum(dpf(i,:).^2,2)/sum(df.^2);
end

% for i=1:size(u,1)
%    Eimf(i,1) = sum(u(i,:).^2,2);
% end
% % disp(['所有个IMF分量的能量'])
% % disp(Eimf(1:N-1))
% % 能量熵
% EZ=sum(f.^2,2);
% for j = 1:size(u,1)
%     p1(j,1) = Eimf(j,1)/EZ;
% end
% E = sum(Eimf);
% for j = 1:size(u,1)
%     p(j,1) = Eimf(j,1)/E;
%     HE(j,1)=-sum(p(j,1).*log(p(j,1)));
% end


%   m=2;
% %SampEnVal=cell(1,size(u,1));
%  for i=1:size(u,1)
%      r=0.15*std(u(i,:));
%      SampEnVal(i,1) = SampEn(u(i,:), m, r);
%  end
%  
%  wind_size = size(u,2);
%  for i=1:size(u,1)
%      %wind_size = size(u,2);
%    mi(i,1) = calc_mi(u(i,:)', f', wind_size);
%      
%  end
  Prmse = mapminmax(rmse',0,1);
 CVPrm=std(Prmse)/mean(Prmse);
 Pr = mapminmax(R',0,1);
 CVPr=std(Pr)/mean(Pr);
 WPrm=CVPrm/(CVPrm+CVPr);
 WPr=CVPr/(CVPrm+CVPr);
 Tindex=WPrm* Prmse+WPr*Pr;
%end