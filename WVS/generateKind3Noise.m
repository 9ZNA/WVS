function generateKind3Noise(N,sigma_w,alpha,sigma_cl,dn)
switch alpha(1)
    case 1
        str1 = 'FN';
    case 1.5
        str1 = 'PL';
    case 2
        str1 = 'RW';
    otherwise
        error('error input alpha/index value!')
end
switch alpha(2)
    case 1
        str2 = 'FN';
    case 1.5
        str2 = 'PL';
    case 2
        str2 = 'RW';
    otherwise
        error('error input alpha/index value!')
end
pathResi = [cd '\' str1 str2 'WN\'];
if ~exist(pathResi,'dir')==1
    mkdir(pathResi)
else
    rmdir(pathResi,'s')
    mkdir(pathResi)
end
time = 58849:1:58849+N-1;% start from 2020 / 58849
for kkk = 1:1:dn
    [resi1 stdw1 stdcl1]= generate_synth(N,sigma_w,sigma_cl(1),-alpha(1),1./365.25); % WN + COLOR
    [resi2 stdw2 stdcl2]= generate_synth(N,0,sigma_cl(2),-alpha(2),1./365.25);% COLOR
    resi = resi1+resi2;

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
    fclose(fid);
    saveLogs = [pathResi 'log.txt'];
    fid = fopen(saveLogs,'a');
    if kkk == 1
        fprintf(fid,'Number\tstd_WN\tstd_FN\tstd_RW\n');
    end
    fprintf(fid,'%d\t',kkk);
    fprintf(fid,'%d\t',sigma_w);
    fprintf(fid,'%d\t',sigma_cl(1));
    fprintf(fid,'%d\n',sigma_cl(2));
    fclose(fid);
end