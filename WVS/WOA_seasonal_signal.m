close all
clear
clc
set(0,'defaultfigurecolor','w')
%% 时变信号

[seasonal_signal,MJD_Time] = Simulated_SeasonalSignals;
N=730;
[noise,amp_wn] = Noise_WN(N);
figure
plot(MJD_Time,seasonal_signal)
%%  FN+WN
amp_fn = 0.2;alpha_fn = 1;
[noise_wnfn,~,~]= generate_synth(N,amp_wn,amp_fn,-alpha_fn,1./365.2);%FN+WN

% WN+PL
amp_pl = 0.2;alpha_pl = 2;
[noise_wnpl,~,~]= generate_synth(N,amp_wn,amp_pl,-alpha_pl,1./365.2);%PL+WN

% WN+FN+RW
amp_rw = 0.2;alpha_rw = 3;
[resi1,~,~]= generate_synth(N,amp_wn,amp_fn,-alpha_fn,1./365.2); % WN + COLOR
[resi2,~,~]= generate_synth(N,0,amp_rw,-alpha_rw,1./365.2);% COLOR
noise_wnrfnrw = resi1 + resi2;

% WN+GGM噪声
amp_ggm = 0.2;alpha_ggm = 4;
[noise_wnggm,~,~]= generate_synth(N,amp_wn,amp_ggm,-alpha_ggm,1./365.2);%GGM+WN



%% 构造信号
simulated_signal(:,1) = seasonal_signal + noise;
simulated_signal(:,2) = seasonal_signal+ noise_wnfn;
simulated_signal(:,3) = seasonal_signal + noise_wnpl;
simulated_signal(:,4) = seasonal_signal + noise_wnrfnrw;
simulated_signal(:,5) = seasonal_signal + noise_wnggm;

for i=5:5
%%
SearchAgents_no=30; % Number of search agents
Function_name='F1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
Max_iteration=10;
 % Maximum numbef of iterations
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
% Load details of the selected benchmark function


[Best_score,Best_pos(i,:),WOABAT_cg_curve]=WOABAT(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,simulated_signal(:,i)');

display(['The best solution obtained by WOABAT is : ', num2str(Best_pos(i,:))]);
 
[Signal_vmd_ssa(:,i),u,T(:,i),tidex] = Method4(simulated_signal(:,i),Best_pos(i,1),Best_pos(i,2));

 [Signal_eemd(:,i),k1,IMF1] = Method5(simulated_signal(:,i));
 [Signal_emd(:,i),Value,loc] = Method7(simulated_signal(:,i));


  
   Pk(1,i) = relative(simulated_signal(:,i),Signal_vmd_ssa(:,i));
Pk(2,i) = relative(simulated_signal(:,i),Signal_eemd(:,i));
Pk(3,i) = relative(simulated_signal(:,i),Signal_emd(:,i));

 rmse(1,i) = RMSE(simulated_signal(:,i),Signal_vmd_ssa(:,i));
rmse(2,i) = RMSE(simulated_signal(:,i),Signal_eemd(:,i));
rmse(3,i) = RMSE(simulated_signal(:,i),Signal_emd(:,i));

snr(1,i) = SNR(simulated_signal(:,i),Signal_vmd_ssa(:,i));
snr(2,i) = SNR(simulated_signal(:,i),Signal_eemd(:,i));
snr(3,i) = SNR(simulated_signal(:,i),Signal_emd(:,i) );


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
plot(t,simulated_signal(:,i));%原始信号
ylabel('原始信号','fontsize',10,'fontname','宋体');
for n1=1:n
    subplot(n+1,1,n1+1);
    plot(t,imfn(n1,:));%IMF分量
    ylabel(['IMF' int2str(n1)]);
end
 xlabel('时间t/s','fontsize',10,'fontname','宋体');







 %%
 %fft_data = DrawFFT(u, fs);
N=length(u);%采样点个数

Y = fft(simulated_signal(:,i),N); %用fft得出离散傅里叶变换
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
ylabel("幅度")
for b=2:n+1
subplot(n+1,1,b);
plot(f,x(b-1,:));%画双侧频谱幅度图
ylabel("幅度")
hold on
end
xlabel("频率/Hz")


%%
figure
 semilogy(WOABAT_cg_curve,'Color','r')
 
 xlabel('Iteration');
 ylabel('Weaken or disappear');
 
 axis tight
 grid on
 box on
 legend('WOABAT')
end



figure
    for n=1:5
        figure
   % subplot(5,1,n)
    plot(MJD_Time,simulated_signal(:,n),'k');
    hold on
    plot(MJD_Time,Signal_vmd_ssa(:,n),'r','linewidth',1);
    plot(MJD_Time,Signal_eemd(:,n),'g','linewidth',1);
    plot(MJD_Time,Signal_emd(:,n),'b','linewidth',1);
  
    title('时变信号')
    
    ylabel('振幅/mm')
   % end
    
   legend('模拟数据','WOA-VMD-SSA','EEMD','EMD')
    end 
Pk=Pk';rmse=rmse';snr=snr';
figure
subplot(3,1,1);

bar(Pk)
title('相关性')
legend('WOA-VMD-SSA','EEMD','EMD')
hold on
subplot(3,1,2);

bar(rmse)
title('均方根误差')
legend('WOA-VMD-SSA','EEMD','EMD')
subplot(3,1,3);

bar(snr)
title('信噪比')
legend('WOA-VMD-SSA','EEMD','EMD')
%save('seasonal_signal.mat')