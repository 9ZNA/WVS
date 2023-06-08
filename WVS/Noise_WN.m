function [Noise ,power1]= Noise_WN(N,power)
% 生成高斯白噪声
    %prompt = {'WN dB'};
    %title = 'WN parameters';
    %dims = [1 35];
    %definput = {'6'};
    %answer = inputdlg(prompt,title,dims,definput);
   
    %power =str2num(answer{1}); 
power1=power;
    Noise = wgn(1,N,power,'linear');
    Noise = Noise';
%     Noise_Index = 1;
end