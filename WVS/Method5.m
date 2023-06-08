function [data,k,allmode] = Method5(RawData)
% EEMD
% input the EEMD parameter
%     prompt = {'Nstd:','NE'};
%     title = 'EEMD parameter';
%     dims = [1 35];
%     answer = inputdlg(prompt,title,dims);
%     Nstd = str2double(answer{1});
%     NE = str2double(answer{2});
        Nstd = 0.1;
        NE = 100;
%     if Choose_Index == 1
        allmode = eemd(RawData,Nstd,NE);
        [col row] = size(allmode);
       for mmm = 1:row-1
           imf{mmm} = allmode(:,mmm+1)';
       end

       for i = 1:length(imf)
           Pk(i) = relative(imf{i},RawData);
       end
       [pks,locs] = findpeaks(-Pk);
       k = locs(1);
       data = zeros(size(RawData));
       for i = k+1:length(imf)
           data = data+imf{i}';
       end
%     end
    %%
%     if Choose_Index == 3
%         data = zeros(size(RawData));
%         for col=1:3
%            allmode = eemd( RawData(:,col),Nstd,NE);
%            [coll row] = size(allmode);
%            for mmm = 1:row-1
%                imf{mmm} = allmode(:,mmm+1)';
%            end
%            PlotIMF(imf,5)
%            leng = length(imf);
%            for i = 1:length(imf)
%                Pk(col,i) = relative( imf{i},RawData(:,col) );
%            end
%            lowpeak = findpeaks(-Pk(col,:));
%            k(col) = lowpeak(1);
%            for i = k(col)+1:length(imf)
%                data(:,col) = data(:,col)+imf{i}';
%            end
%         end
%     end
   %% save data
   % k
   % RawData and data 
   % Pk
%     for i = 1:Choose_Index
%         dname = [cd '\NoiseReduction\Method5'];
%         if Simulated_Index == 1
%             newfn{i} = 'Simulated.mom';
%         end 
%         fn = newfn{i};
%         fid = fopen([dname '\' fn],'w');
%         fprintf(fid,'# sampling period 1.0\n');
%         for j = 1:length(MJD_Time)
%              fprintf(fid,'%f\t',MJD_Time(j,i));
%              fprintf(fid,'%f\n',data(j,i));
%         end 
%         fclose(fid);
%     end
%     dname = [cd '\NoiseReduction\Method5'];
%     fn = '\k.txt';
%     save ([dname fn],'k','-ascii')
% 
%     dname = cd;
%     dname = [dname '\NoiseReduction\Method5'];
%     fn = '\Pk.txt';
%     save ([dname fn],'Pk','-ascii')

end