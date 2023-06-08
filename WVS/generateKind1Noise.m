function generateKind1Noise(N,NoiseModel,amp,dn)
fclose all
switch NoiseModel
    case 'WN' % WN
        if ~exist('WN','dir')==1
             mkdir('WN')
        else
            rmdir('WN','s')
            mkdir('WN')
        end
        alpha = 0;
        pathResi = 'WN\';
    case 'FN' % FN 
        if ~exist('FN','dir')==1
            mkdir('FN')
        else
            rmdir('FN','s')
            mkdir('FN')
        end
        pathResi = 'FN\';
        alpha = 1;
    case 'PL' % PL
        if ~exist('PL','dir')==1
            mkdir('PL')
        else
            rmdir('PL','s')
            mkdir('PL')
        end
        pathResi = 'PL\';
        alpha = 1.5;
    case 'RW' % RW
        if ~exist('RW','dir')==1
            mkdir('RW')
        else
            rmdir('RW','s')
            mkdir('RW')
        end
        pathResi = 'RW\';
        alpha = 2;
    otherwise
        error('error input,check the noise model!')
end
% or between 1 and 4
% 如果区间为(a,b)则可用
% (b-a)*rand(1) + a
switch amp
    case 'caseA:0~0.1mm'
        sigma = 0.1*rand(1,dn);
    case 'caseB:0.1~1mm'
        sigma = 0.1 + rand(1,dn)*0.9;
    case 'caseC:1~4mm'
        sigma = 1 + 3 .* rand(1,dn);
    otherwise
        error('error input colord noise input!')
end

time = 58849:1:58849+N-1;% time start from 2020 / 58849

for kkk = 1:1:dn
  %--- x contains observations which in this case is just power-law plus
  %    white noise.
  %x = zeros(N,1);
%     [noise std_wn std_color] = generate_synth(N,0,sigma_color(kkk),-1.5,1./365.25)%PL
%     [noise std_wn sstd_colortdpl] = generate_synth(N,0,sigma_color(kkk),-1,1./365.25)%FN
    if NoiseModel == 'WN'
        [resi stdw stdcl]= generate_synth(N,sigma(kkk),0,-alpha,1./365.25);%WN + Colored noise
    else
        [resi stdw stdcl]= generate_synth(N,0,sigma(kkk),-alpha,1./365.25);%WN + Colored noise
    end
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
        fprintf(fid,'Number \t std \n');
    end
    fprintf(fid,'%d\t',kkk);
    fprintf(fid,'%d\n',sigma(kkk));
    fclose(fid);
end

% addpath(genpath(''))
