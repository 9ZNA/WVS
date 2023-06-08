function [Signal,f1,f2,f3,Data_Length] = Simulated_PerFun
    prompt = {'Amplitude1','F1','F2','Amplitude2','F3','Amplitude3','F4','DataLength'};
    title = 'Period_sigal';
    dims = [1 50];
    definput = {'8','1000','300','4','500','2','100','3652'};
    options.Resize='on';
    answer = inputdlg(prompt,title,dims,definput,options);
    amplitude1 = str2num(answer{1}); 
    F1 = str2num(answer{2});
    F2 = str2num(answer{3});
    amplitude2 = str2num(answer{4}); 
    F3 = str2num(answer{5}); 
    amplitude3 = str2num(answer{6}); 
    F4 = str2num(answer{7});
    Data_Length = str2num(answer{8}); 
    t=1:1:Data_Length ;
    f1 = amplitude1*sin(2*pi.*t/F1).*sin(2*pi.*t/F2);
    f2 = amplitude2*sin(2*pi.*t/F3);
    f3 = amplitude3*sin(2*pi.*t/F4);
    Simulated_Data = f1 + f2 + f3;
    Signal = Simulated_Data';
    Simulated_Index = 1;
    Simulated_Choice = 'PerFun';
end