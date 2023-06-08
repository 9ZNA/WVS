function [data,allmode,k,imf] = Method1(RawData)
%METHOD1 此处显示有关此函数的摘要
%   此处显示详细说明
[allmode its]=ceemdan(RawData,0.2,500,5000);
%t=1:length(RawData);
allmode=allmode';
 [col row] = size(allmode);
       for mmm = 1:row-1
           imf{mmm} = allmode(:,mmm+1);
       end

       for i = 1:length(imf)
           Pk(i) = relative(imf{i},RawData);
       end
       [pks,locs] = findpeaks(-Pk);
        if isempty(locs)
            k = inf;
            data = RawData;
            return
        end
       k = locs(1);
       data = zeros(size(RawData));
       
       for i = k+1:length(imf)
           data = data+imf{i};
       end
     
       
      
%figure;
%subplot(a+1,1,1);
%plot(t,RawData);% the ECG signal is in the first row of the subplot
%ylabel('ECG')
%set(gca,'xtick',[])
%axis tight;

%for i=2:a
    %subplot(a+1,1,i);
    %plot(t,modes(i-1,:));
    %ylabel (['IMF ' num2str(i-1)]);
    %set(gca,'xtick',[])
   % xlim([1 length(RawData)])
%end;

%subplot(a+1,1,a+1)
%plot(t,modes(a,:))
%ylabel(['IMF ' num2str(a)])
%xlim([1 length(RawData)])

%figure;
%boxplot(its);
end

