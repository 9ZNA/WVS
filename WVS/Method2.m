function  [Signal_SSA]=Method2(RawData)


%M = 30;    % window length = embedding dimension
N = length(RawData); 
M = round(N/2);% length of generated time series
%T = 22;    % period length of sine function
%stdnoise = 1; % noise-to-signal ratio



RawData = RawData - mean(RawData);            % remove mean value
RawData = RawData/std(RawData,1);             % normalize to standard deviation 1

%figure(1);
%set(gcf,'name','实测数据');
%clf;
%plot(t,RawData);
%title(A(ss).name(1:4));

%% 计算协方差矩阵C（Toeplitz方法）
% Next, we calculate the covariance matrix. There are several numerical
% approaches to estimate C. Here, we calculate the covariance function with
% CORR and build C with the function TOEPLITZ.

%covX = xcorr(RawData,M-1,'unbiased');
%Ctoep=toeplitz(covX(M:end));

%figure(2);
%set(gcf,'name','协方差矩阵');
%clf;
%imagesc(Ctoep);
%axis square
%set(gca,'clim',[-1 1]);
%colorbar

%% 计算协方差矩阵（轨迹法）
% An alternative approach is to determine C directly from the scalar
% product of Y, the time-delayed embedding of X. Although this estimation
% of C does not give a Toeplitz structure, with the eigenvectors not being
% symmetric or antisymmetric, it ensures a positive semi-definite covariance
% matrix.

Y=zeros(N-M+1,M);
for m=1:M    
  Y(:,m) = RawData((1:N-M+1)+m-1);
end;
Cemb=Y'*Y / (N-M+1);

%figure(2);
%set(gcf,'name','协方差矩阵');
%clf;
%imagesc(Cemb);
%axis square
%set(gca,'clim',[-1 1]);
%colorbar

% C=Ctoep;
C=Cemb;

%% 计算特征值λ和特征向量ρ
% In order to determine the eigenvalues and eigenvectors of C, we use the
% function EIG. This function returns two matrices, the matrix RHO with
% eigenvectors arranged in columns, and the matrix LAMBDA with eigenvalues
% along the diagonal.

[RHO,LAMBDA] = eig(C);
LAMBDA = diag(LAMBDA);               % extract the diagonal elements
[LAMBDA,ind]=sort(LAMBDA,'descend'); % sort eigenvalues
RHO = RHO(:,ind);                    % and eigenvectors

%figure(3);
%set(gcf,'name','特征向量RHO和特征值LAMBDA')
%clf;
%subplot(3,1,1);
%plot(LAMBDA,'o-');
%subplot(3,1,2);
%plot(RHO(:,1:2), '-');
%legend('1', '2');
%subplot(3,1,3);
%plot(RHO(:,3:4), '-');
%legend('3', '4');

%% 用PC计算主成分
% The principal components are given as the scalar product between Y, the
% time-delayed embedding of X, and the eigenvectors RHO.

PC = Y*RHO;

%figure(4);
%set(gcf,'name','PCs的主成分')
%clf;
%for m=1:4
 % subplot(4,1,m);
  %plot(t(1:N-M+1),PC(:,m),'k-');
 % ylabel(sprintf('PC %d',m));
  %ylim([-10 10]);
%end;


%% 计算重构分量RC
% In order to determine the reconstructed components RC, we have to invert
% the projecting PC = Y*RHO; i.e. RC = Y*RHO*RHO'=PC*RHO'. Averaging along
% anti-diagonals gives the RCs for the original input X.

RC=zeros(N,M);
for m=1:M
  buf=PC(:,m)*RHO(:,m)'; % invert projection
  buf=buf(end:-1:1,:);
  for n=1:N % anti-diagonal averaging
    RC(n,m)=mean( diag(buf,-(N-M+1)+n) );  
  end
end;
[a,b]=size(RC);


Signal=RC;

[col,row]=size(Signal);


o=zeros(size(Signal,1),1);

for i=1:row
    o=o+Signal(:,i);
    U(:,i)=o;
end
Tindex=calT(RawData',U');
[~,b]=min(Tindex);
Signal_SSA=sum(RC(:,1:2),2);

%figure(5);
%set(gcf,'name','RCs重构分量')
%clf;
%for m=1:4
 % subplot(4,1,m);
  %plot(t,RC(:,m),'r-');
 % ylabel(sprintf('RC %d',m));
  %ylim([-1 1]);
%end;

%% 比较重建和原始时间序列
% Note that the original time series X can be completely reconstructed by
% the sum of all reconstructed components RC (upper panel). The sine
% function can be reconstructed with the first pair of RCs (lower panel).

%figure(6);
%set(gcf,'name','原始时间序列X和重构RC')
%clf;
%subplot(2,1,1)
%plot(t,RawData,t,sum(RC(:,:),2),'r-');
%legend('原始数据','重建信号');

%subplot(2,1,2)
%plot(t,RawData,'LineWidth',2);
%plot(t,RawData,t,sum(RC(:,1:15),2),'r-');
%legend('原始数据','RCs 1-2重建');

