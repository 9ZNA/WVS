close all
clear
clc
tic
Precise = [];
filepath1 = 'D:\微信文件\WeChat Files\wxid_9844138440311\FileStorage\File\2023-02\1001\';
filepath2 = 'D:\一种改进WVSSA\WOA-VMD-SSA\txt\';
A = dir(filepath1);
A1=dir(filepath2);
for ss =3:length(A) 
%% 导入真实信号
   fid = fopen( [filepath1 '\' A(ss).name],'r');
    da = textscan(fid,'%f%f','headerlines',1);
    signal = da{2}';
    fid1 = fopen( [filepath2 '\' A1(ss).name],'r');
    da1 = textscan(fid1,'%f%f','headerlines',0);
    Signal_vmd_ssa = da1{2};
    MJD = da{1};
    [Signal_eemd,k1(ss-2),IMF1] = Method5(signal');
[Signal_emd,loc(ss-2),Value] = Method7(signal');
[Signal_ceemdan,ceemdanIMF,k(ss-2)] = Method1(signal');
%a='example'
 %save1(Signal_vmd_ssa,ss)
 %save1('最优参数\','Best_pos')
 fileout = ['CEEMDANGGMtxt\\' A(ss).name(1:7) '.txt'];
   fid=fopen(fileout,'wt');
  %fprintf(fid,'%s\t\t%s\t\t\n','time','data1');
  
     for i=1:length(Signal_ceemdan)  
         %fprintf(fid,'%.8f\t\n',MJD(i,:));
      fprintf(fid,'%.8f\t%.8f\t\n',MJD(i,:),Signal_ceemdan(i,:));
      %fprintf(fid,'%.8f\t\n',s);
     end

     fileout = ['EEMDGGMWNtxt\\' A(ss).name(1:7) '.txt'];
   fid=fopen(fileout,'wt');
  %fprintf(fid,'%s\t\t%s\t\t\n','time','data1');
   
     for i=1:length(Signal_eemd)  
         %fprintf(fid,'%.8f\t\n',MJD(i,:));
      fprintf(fid,'%.8f\t%.8f\t\n',MJD(i,:),Signal_eemd(i,:));
      %fprintf(fid,'%.8f\t\n',s);
     end

     fileout = ['EMDGGMWNtxt\\' A(ss).name(1:7) '.txt'];
   fid=fopen(fileout,'wt');
  %fprintf(fid,'%s\t\t%s\t\t\n','time','data1');
  
     for i=1:length(Signal_emd)  
         %fprintf(fid,'%.8f\t\n',MJD(i,:));
      fprintf(fid,'%.8f\t%.8f\t\n',MJD(i,:),Signal_emd(i,:));
      %fprintf(fid,'%.8f\t\n',s);
      
     end

%save(['GGMWN\txt\' A(ss).name(1:8)  '.mat'],'Signal_vmd_ssa') 
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
save(['指标txt\pk\' A(ss).name(1:8)  '.mat'],'Pk') 
save(['指标txt\rmse\' A(ss).name(1:8)  '.mat'],'rmse') 
save(['指标txt\snr\' A(ss).name(1:8)  '.mat'],'snr') 
end