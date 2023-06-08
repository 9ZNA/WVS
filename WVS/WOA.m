close all
clear
clc
tic
Precise = [];
filepath = 'D:\微信文件\WeChat Files\wxid_9844138440311\FileStorage\File\2023-03\40-data\';
A = dir(filepath);
[noise,amp_wn] = Noise_WN;
%Pk=zeros(3,length(A)-2);
%rmse=zeros(3,length(A)-2);
%snr=zeros(3,length(A)-2);
for ss =3:4
%% 导入真实信号
   fid = fopen( [filepath '\' A(ss).name],'r');
    da = textscan(fid,'%f %s%f%s%f%s%f%s','headerlines',1);
    signal = da{3}';
    MJD = da{1};
    signal=signal+noise';
   save(['白GGMWN\' A(ss).name(1:8)  '.mat'] ,'signal') 
%% WOA
% save(['白GGMWN\' A(ss).name(1:8)  '.mat']
SearchAgents_no=30; % Number of search agents
Function_name='F1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
Max_iteration=10;
 % Maximum numbef of iterations
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
% Load details of the selected benchmark function
[Best_score,Best_pos,WOABAT_cg_curve]=WOABAT(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,signal');
%display(['The best solution obtained by WOABAT is : ', num2str(Best_pos)]);
 display(['The best optimal value of the objective funciton found by WOA is : ', num2str(Best_score)]);


[Signal_vmd_ssa,u,T(ss-2),tidex] = Method4(signal',Best_pos(1,1),Best_pos(1,2));
 save(['GGMWN\' A(ss).name(1:8)  '.mat'],'Signal_vmd_ssa') 
[Signal_eemd,k1(ss-2),IMF1] = Method5(signal');
[Signal_emd,loc(ss-2),Value] = Method7(signal');
[Signal_ceemdan,ceemdanIMF,k(ss-2),IMF] = Method1(signal');
%a='example'
 %save1(Signal_vmd_ssa,ss)
  save(['最优GGMWN\' A(ss).name(1:8)  '.mat'] ,'Best_pos') 

fileout = ['SSAGGMWN\' A(ss).name(1:10) '.txt'];
   fid=fopen(fileout,'wt');
  fprintf(fid,'%s\t\t%s\t\t\n','time','data1');
   MJD=MJD';
     for i=1:length(Signal_vmd_ssa)  
         %fprintf(fid,'%.8f\t\n',MJD(i,:));
      fprintf(fid,'%.8f\t%.8f\t\n',MJD(i,:),Signal_vmd_ssa(i,1));
      %fprintf(fid,'%.8f\t\n',s);
      
    end

     fileout = ['CEEMDANGGMWN\\' A(ss).name(1:7) '.txt'];
   fid=fopen(fileout,'wt');
  %fprintf(fid,'%s\t\t%s\t\t\n','time','data1');
  
     for i=1:length(Signal_ceemdan)  
         %fprintf(fid,'%.8f\t\n',MJD(i,:));
      fprintf(fid,'%.8f\t%.8f\t\n',MJD(i,:),Signal_ceemdan(i,:));
      %fprintf(fid,'%.8f\t\n',s);
     end

     fileout = ['EEMDGGMWN\\' A(ss).name(1:7) '.txt'];
   fid=fopen(fileout,'wt');
  %fprintf(fid,'%s\t\t%s\t\t\n','time','data1');
   
     for i=1:length(Signal_eemd)  
         %fprintf(fid,'%.8f\t\n',MJD(i,:));
      fprintf(fid,'%.8f\t%.8f\t\n',MJD(i,:),Signal_eemd(i,:));
      %fprintf(fid,'%.8f\t\n',s);
     end

     fileout = ['EMDGGMWN\\' A(ss).name(1:7) '.txt'];
   fid=fopen(fileout,'wt');
  %fprintf(fid,'%s\t\t%s\t\t\n','time','data1');

  
     for i=1:length(Signal_emd)  
         %fprintf(fid,'%.8f\t\n',MJD(i,:));
      fprintf(fid,'%.8f\t%.8f\t\n',MJD(i,:),Signal_emd(i,:));
      %fprintf(fid,'%.8f\t\n',s);
      
     end

%save(['GGMWN\' A(ss).name(1:8)  '.mat'],'Signal_vmd_ssa') 
%save(['最优txt\' A(ss).name(1:8)  '.mat'],'Best_pos')
signal=signal';
Pk(1,:) = relative(signal,Signal_vmd_ssa);
    Pk(2,:) = relative(signal,Signal_ceemdan);
Pk(3,:) = relative(signal,Signal_eemd);
Pk(4,:) = relative(signal,Signal_emd);

 rmse(1,:) = RMSE(signal,Signal_vmd_ssa);
 rmse(2,:) = RMSE(signal,Signal_ceemdan);
rmse(3,:) = RMSE(signal,Signal_eemd);
rmse(4,:) = RMSE(signal,Signal_emd);

snr(1,:) = SNR(signal,Signal_vmd_ssa);
snr(2,:) = SNR(signal,Signal_ceemdan);
snr(3,:) = SNR(signal,Signal_eemd);
snr(4,:) = SNR(signal,Signal_emd);
save(['指标GGMWN\pk\' A(ss).name(1:8)  '.mat'],'Pk') 
save(['指标GGMWN\rmse\' A(ss).name(1:8)  '.mat'],'rmse') 
save(['指标GGMWN\snr\' A(ss).name(1:8)  '.mat'],'snr') 






end



MJD=MJD';

       figure
   
   % subplot(3,1,ss-2)
    plot(MJD2Day(MJD),signal,'k');
    hold on
    plot(MJD2Day(MJD),Signal_vmd_ssa,'r','linewidth',1);
    plot(MJD2Day(MJD),Signal_ceemdan,'r','linewidth',1);
    plot(MJD2Day(MJD),Signal_eemd,'g','linewidth',1);
    plot(MJD2Day(MJD),Signal_emd,'b','linewidth',1);
     
    %title(A(ss).name(1:7))
    xlabel('Time')
    ylabel('Amplitude/mm')
    xlim([2000 2030])
    
  legend('Original signal','WOA-VMD-SSA','CEEMDAN','EEMD','EMD')
 display( num2str(Best_score));
 %%
fs=2560;%采样频率
Ts=1/fs;%采样周期
L=length(u);%采样点数
t=(0:L-1)*Ts;%时间序列
allmode=u';
%STA=1;
figure;
imfn=allmode';
n=size(imfn,1);
subplot(n+1,1,1);
plot(t,signal);%原始信号
ylabel('Original signal','fontsize',6,'fontname','Times new roman');
for n1=1:n
    subplot(n+1,1,n1+1);
    plot(t,imfn(n1,:));%IMF分量
    ylabel(['IMF' int2str(n1)],'fontsize',6,'fontname','Times new roman');
end
 xlabel('Time t/s','fontsize',10,'fontname','宋体');







 %%
 %fft_data = DrawFFT(u, fs);
N=length(u);%采样点个数

Y = fft(signal,N); %用fft得出离散傅里叶变换
f=linspace(-fs/2,fs/2-1,N);%频域横坐标，注意奈奎斯特采样定理，最大原信号最大频率不超过采样频率的一半
y=abs(Y);
for m=1:n
 X(m,:) = fft(u(m,:),N); %用fft得出离散傅里叶变换
f=linspace(-fs/2,fs/2-1,N);%频域横坐标，注意奈奎斯特采样定理，最大原信号最大频率不超过采样频率的一半
x(m,:)=abs(X(m,:));
end
figure
subplot(n+1,1,1);
plot(f,y')
ylabel("Amplitude",'fontsize',6,'fontname','Times new roman')
for b=2:n+1
subplot(n+1,1,b);
plot(f,x(b-1,:));%画双侧频谱幅度图
ylabel("Amplitude",'fontsize',6,'fontname','Times new roman')
hold on
end
xlabel("Frequency/Hz")



end


