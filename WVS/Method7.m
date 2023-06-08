function [data,k,Pk] = Method1(RawData)
%   traditioal EMD method
       allmode = eemd( RawData,0,1);
       [coll row] = size(allmode);
       for mmm = 1:row-1
           imf{mmm} = allmode(:,mmm+1)';
       end
%        PlotIMF(imf,1)
%        leng = length(imf);
       for i = 1:length(imf)
           Pk(i) = relative(imf{i},RawData);
       end
       [pks,locs] = findpeaks(-Pk); % find minimum point and location
%        lowpeak = findpeaks(-Pk);
        if isempty(locs)
            k = inf;
            data = RawData;
            return
        end
       k = locs(1);
       data = zeros(size(RawData));
       for i = k+1:length(imf)
           data = data+imf{i}';
       end
%        figure
%        plot(Pk)
%        xlabel('IMF序号')
%        ylabel('相关系数')
   %% save data
   % k
   % RawData and data 
   % Pk
% for i = 1:Choose_Index
%     file  = [MJD_Time(:,i) data(:,i)];
%     dname = cd;
%     dname = [dname '\NoiseReduction\Method1'];
%     if Simulated_Index == 1
%         newfn{i} = 'Simulated.mom';
%     end 
%     fn = newfn{i};
%     fid = fopen([dname '\' fn],'w+');
%     fprintf(fid,'# sampling period 1.0\n');
%     for j = 1:length(MJD_Time)
%          fprintf(fid,'%f\t',MJD_Time(j,i));
%          fprintf(fid,'%f\n',data(j,i));
%     end
%     fclose(fid);
% end
%     dname = [cd '\NoiseReduction\Method1'];
%     fn = '\k.txt';
%     save ([dname fn],'k','-ascii')
% 
%     dname = cd;
%     dname = [dname '\NoiseReduction\Method1'];
%     fn = '\Pk.txt';
%     save ([dname fn],'Pk','-ascii')
end
   
   
   
