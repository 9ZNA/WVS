function generateKind2Noise(N,sigma_w,alpha,sigma_am_choice,dn)
% dn = 100;
% sigma_am_choice = 'caseA:0~0.1mm';
% clc; clear;
% close all;
% fclose all;
%--- N is number of observations
% N = 3652; % 10 years 
%--- noise parameters, just arbitrary values for this example
% alpha = 2; % 谱指数 1代表FN  ,1.5代表PL,2代表 RW
switch alpha
    case 1 % FNWN
        if ~exist('FNWN','dir')==1
             mkdir('FNWN')
        else
            rmdir('FNWN','s')
            mkdir('FNWN')
        end
        pathResi = 'FNWN\';
    case 1.5 % PLWN 
        if ~exist('PLWN','dir')==1
            mkdir('PLWN')
        else
            rmdir('PLWN','s')
            mkdir('PLWN')
        end
        pathResi = 'PLWN\';
    case 2 % RWWN
        if ~exist('RWWN','dir')==1
            mkdir('RWWN')
        else
            rmdir('RWWN','s')
            mkdir('RWWN')
        end
        pathResi = 'RWWN\';
    otherwise
        error('error input,check the alpha value!')
end
% or between 1 and 4
% 如果区间为(a,b)则可用
% (b-a)*rand(1) + a
switch sigma_am_choice
    case 'caseA:0~0.1mm'
        sigma_color = 0.1*rand(1,dn);
    case 'caseB:0.1~1mm'
        sigma_color = 0.1 + rand(1,dn)*0.9;
    case 'caseC:1~4mm'
        sigma_color = 1 + 3 .* rand(1,dn);
    otherwise
        error('error input colord noise input!')
end

%   Three part
%   0~0.1mm
%   0.1~1mm
%   1~4mm
% sigma_w  = 1.6; % Gausian 1.8, other 1.4
time = 58849:1:58849+N-1;% start from 2020/58849
for kkk = 1:1:length(sigma_color)
  %--- x contains observations which in this case is just power-law plus
  %    white noise.
  %x = zeros(N,1);
%     [noise std_wn std_color] = generate_synth(N,0,sigma_color(kkk),-1.5,1./365.25)%PL
%     [noise std_wn sstd_colortdpl] = generate_synth(N,0,sigma_color(kkk),-1,1./365.25)%FN
    [resi,stdw,stdcl]= generate_synth(N,sigma_w,sigma_color(kkk),-alpha,1./365.25);%RW+WN
%     resi = resi + noise;%RW+WN+PL/FN
    if kkk < 10
        saveResi = [pathResi 'TS000' num2str(kkk) '.mom'];
    elseif kkk<100
        saveResi = [pathResi 'TS00' num2str(kkk) '.mom'];
    elseif kkk<1000
        saveResi = [pathResi 'TS0' num2str(kkk) '.mom'];
    else
        saveResi = [pathResi 'TS' num2str(kkk) '.mom'];
    end
    
    fid = fopen(saveResi,'w+');
    fprintf(fid,'# sampling period 1.0\n');
    for j = 1:N
        fprintf(fid,'%f\t',time(j));
        fprintf(fid,'%f\n',resi(j));
    end
    %         save(saveResi,'resi','-ascii')
    fclose(fid);
    saveLogs = [pathResi 'log.txt'];
    fid = fopen(saveLogs,'a');
    if kkk == 1
        fprintf(fid,'Number\tstd_color\tstd_wn\n');
    end
    fprintf(fid,'%d\t',kkk);
    fprintf(fid,'%d\t',sigma_color(kkk));
    fprintf(fid,'%d\n',sigma_w);
    fclose(fid);
end