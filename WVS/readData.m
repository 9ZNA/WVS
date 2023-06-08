function [out]=readData(path)

%从指定行开始读取数据

%实际上主要是textscan的使用，查阅matlab对应的帮助文档就清楚了
clear all;
fid=fopen(path,'r');
if fid<0
    warndlg('打开文件失败!');
    return;
else
   FormatString=repmat('%f ',1,18);
   out =cell2mat(textscan(fid,FormatString,7373,'HeaderLines',174)); %从174行开始读取7373*18的矩阵数据
end
msgbox('文件读取成功！');
if fclose(fid)==0
    msgbox('文件关闭成功！');
else 
    warndlg('关闭文件失败!');
end
end

