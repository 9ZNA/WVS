function [Signal,MJD_Time,num,outset,outcome] = Simulated_SeasonalSignals
%   Seasonal signals
    prompt = {'Outset','Outcome','Constant:a','Constant:b','Constant:d','Constant:e'};
    title = 'Seasonal_signal';
    dims = [1 50];
    definput = {'2000','2022','6','7','8','9',};
    options.Resize='on';
    
    answer = inputdlg(prompt,title,dims,definput,options);
    outset = str2num(answer{1}); 
    outcome = str2num(answer{2});
    a = str2num(answer{3});
    b = str2num(answer{4}); 
    d = str2num(answer{5}); 
    e = str2num(answer{6}); 
    
    num = (outcome-outset)*365.25;
    Data_Length = round(num);
    t = linspace(outset,outcome,num);
    MJD_Time = t';

    s = a*sin(2*pi.*t)+ b*cos(2*pi.*t)+c(t).*sin(2*pi.*t)+...
        c(t).*cos(2*pi.*t)+d*sin(4*pi.*t)+e*cos(4*pi.*t);

    Signal = s';
%     Simulated_Index = 1;
%     Simulated_Choice = 'SeaSig';
    
end
function c = c(t)
    c = 2*exp( (0.3*sin(t)));
end
