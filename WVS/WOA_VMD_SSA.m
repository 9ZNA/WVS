function varargout = WOA_VMD_SSA(varargin)
% WOA_VMD_SSA MATLAB code for WOA_VMD_SSA.fig
%      WOA_VMD_SSA, by itself, creates a new WOA_VMD_SSA or raises the existing
%      singleton*.
%
%      H = WOA_VMD_SSA returns the handle to a new WOA_VMD_SSA or the handle to
%      the existing singleton*.
%
%      WOA_VMD_SSA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WOA_VMD_SSA.M with the given input arguments.
%
%      WOA_VMD_SSA('Property','Value',...) creates a new WOA_VMD_SSA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WOA_VMD_SSA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WOA_VMD_SSA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WOA_VMD_SSA

% Last Modified by GUIDE v2.5 31-May-2023 19:51:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WOA_VMD_SSA_OpeningFcn, ...
                   'gui_OutputFcn',  @WOA_VMD_SSA_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
% --- Executes just before WOA_VMD_SSA is made visible.
function WOA_VMD_SSA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WOA_VMD_SSA (see VARARGIN)

movegui(gcf,'center');
% Choose default command line output for WOA_VMD_SSA
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes WOA_VMD_SSA wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% --- Outputs from this function are returned to the command line.
function varargout = WOA_VMD_SSA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
movegui(gcf,'center');
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[period_sigal,f1,f2,f3,Data_Length] = Simulated_PerFun;

handles.f1=f1;
handles.f2=f2;
handles.f3=f3;
handles.Data_Length=Data_Length;
handles.period_sigal=period_sigal;
handles.Noise_Index=1;
     guidata(hObject,handles)
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[seasonal_signal,MJD_Time,N,a,b] = Simulated_SeasonalSignals;
N=round(N);
    if N<length(seasonal_signal)
    A=length(seasonal_signal)-N;
        N=N+A;
   else if N>length(seasonal_signal)
        A=N-length(seasonal_signal);
        N=N-A
else  if N==length(seasonal_signal)
        N=N
end
   end
    end
handles.a=a;
handles.b=b;
handles.seasonal_signal=seasonal_signal;
handles.MJD_Time=MJD_Time;
handles.Noise_Index=2;
handles.N=N;
     guidata(hObject,handles)
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   Noise_Index =handles.Noise_Index
   if Noise_Index==1
   f1=handles.f1;  
   f2=handles.f2;
   f3=handles.f3;
period_sigal=handles.period_sigal;
Data_Length=handles.Data_Length;
A=period_sigal;
%A=get(handles.period_sigal,'string');
prompt = {'WN dB'};
   title = 'WN parameter';
    dims = [1 35];
    definput = {'6'};
    answer = inputdlg(prompt,title,dims,definput);
   
    power =str2num(answer{1}); 
[noise,N]= Noise_WN(Data_Length,power);

RawData=noise+A;
figure
subplot(5,1,1)
plot(f1)
legend('f1')
xlim([0 Data_Length])
subplot(5,1,2)
plot(f2)
xlim([0 Data_Length])
legend('f2')
subplot(5,1,3)
plot(f3)
legend('f3')
xlim([0,Data_Length])
subplot(5,1,4)
plot(noise)
legend('WN')
xlim([0,Data_Length])
subplot(5,1,5)
plot(RawData)
legend('RawData')
xlim([0,Data_Length])
handles.RawData=RawData;
 handles.noise=noise;
   else if  Noise_Index==2
            a=handles.a;
           b=handles.b;
          MJD_Time=handles.MJD_Time; 
     seasonal_signal=handles.seasonal_signal;
     N=handles.N;
%A=get(handles.period_sigal,'string');
 prompt = {'WN dB'};
    title = 'WN parameter';
    dims = [1 35];
    definput = {'6'};
    answer = inputdlg(prompt,title,dims,definput);
   
    power =str2num(answer{1}); 
[noise,N]= Noise_WN(N,power);
RawData=noise+seasonal_signal;

figure
subplot(3,1,1)
plot(MJD_Time,seasonal_signal)
legend('Seasonal signal')
xlim([a b])
ylabel('Amplitude(mm)')
hold on
subplot(3,1,2)
plot(MJD_Time,noise)
legend('WN')
xlim([a b])
ylabel('Amplitude(mm)')
subplot(3,1,3)
plot(MJD_Time,RawData)
legend('RawData')
xlim([a b])
ylabel('Amplitude(mm)')
handles.RawData=RawData;   
 handles.noise=noise;  
% handles.MJD_Time=MJD_Time;
%if get(hObject.pushbutton2,'string')
   end
   end
    handles.RawData_Index=1;
    guidata(hObject,handles)
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% FN+WN
 Noise_Index =handles.Noise_Index
   if Noise_Index==1
   N=handles.Data_Length;  
   f1=handles.f1;  
   f2=handles.f2;
   f3=handles.f3;
period_sigal=handles.period_sigal;
A=period_sigal;
Data_Length=N
%A=get(handles.period_sigal,'string');

prompt = {'WN db','FN Amplitude(mm)'};
    title = 'WN parameter and FN parameter';
    dims = [1 35];
    definput = {'6','0.2'};
    answer = inputdlg(prompt,title,dims,definput);
     power =str2num(answer{2});  
     power1 =str2num(answer{1}); 
     [~,amp_wn]= Noise_WN(N,power1);
amp_fn =power;alpha_fn = 1;
[noise_wnfn,~,~]= generate_synth(N,amp_wn,amp_fn,-alpha_fn,1./365.25);%FN+WN
RawData=A+noise_wnfn;
figure
subplot(5,1,1)
plot(f1)
legend('f1')
xlim([0 Data_Length])
subplot(5,1,2)
plot(f2)
xlim([0 Data_Length])
legend('f2')
subplot(5,1,3)
plot(f3)
legend('f3')
xlim([0,Data_Length])
subplot(5,1,4)
plot(noise_wnfn)
legend('WN+FN')
xlim([0,Data_Length])
subplot(5,1,5)
plot(RawData)
legend('RawData')
xlim([0,Data_Length])
handles.noise_wnfn=noise_wnfn;
handles.RawData=RawData;
   else if  Noise_Index==2
           MJD_Time=handles.MJD_Time;
           a=handles.a;
           b=handles.b;
     seasonal_signal=handles.seasonal_signal;
     N=handles.N;
%A=get(handles.period_sigal,'string');
prompt = {'WN db','FN Amplitude(mm)'};
    title = 'WN parameter and FN parameter';
    dims = [1 35];
    definput = {'6','0.2'};
    answer = inputdlg(prompt,title,dims,definput);
     power =str2num(answer{2});  
     power1 =str2num(answer{1}); 
     [~,amp_wn]= Noise_WN(N,power1);
amp_fn =power;alpha_fn = 1;
[noise_wnfn,~,~]= generate_synth(N,amp_wn,amp_fn,-alpha_fn,1./365.25);%FN+WN
RawData=seasonal_signal+noise_wnfn;
figure
subplot(3,1,1)
plot(MJD_Time,seasonal_signal)
legend('Seasonal signal')
xlim([a b])
ylabel('Amplitude(mm)')
hold on
subplot(3,1,2)
plot(MJD_Time,noise_wnfn)
legend('WN+FN')
xlim([a b])
ylabel('Amplitude(mm)')
subplot(3,1,3)
plot(MJD_Time,RawData)
legend('RawData')
xlim([a b])
ylabel('Amplitude(mm)')
handles.noise_wnfn=noise_wnfn;
handles.RawData=RawData;     
   end
   end
   handles.RawData_Index=2;
    guidata(hObject,handles)
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% WN+PL
Noise_Index =handles.Noise_Index
   if Noise_Index==1
       N=handles.Data_Length; 
period_sigal=handles.period_sigal;
A=period_sigal;
Data_Length=N;
%A=get(handles.period_sigal,'string');
f1=handles.f1;  
   f2=handles.f2;
   f3=handles.f3;
prompt = {'WN db','PL Amplitude(mm)'};
    title = 'WN parameter and PL parameter';
    dims = [1 35];
    definput = {'6','0.2'};
    answer = inputdlg(prompt,title,dims,definput);
     power =str2num(answer{2}); 
     power1 =str2num(answer{1});
     [~,amp_wn]= Noise_WN(N,power1);
amp_pl =power;alpha_pl = 2;
[noise_wnpl,~,~]= generate_synth(N,amp_wn,amp_pl,-alpha_pl,1./365.25);%FN+WN
RawData=A+noise_wnpl;
figure
subplot(5,1,1)
plot(f1)
legend('f1')
xlim([0 Data_Length])
subplot(5,1,2)
plot(f2)
xlim([0 Data_Length])
legend('f2')
subplot(5,1,3)
plot(f3)
legend('f3')
xlim([0,Data_Length])
subplot(5,1,4)
plot(noise_wnpl)
legend('WN+PL')
xlim([0,Data_Length])
subplot(5,1,5)
plot(RawData)
legend('RawData')
xlim([0,Data_Length])
handles.RawData=RawData,;
handles.noise_wnpl=noise_wnpl; 
   else if  Noise_Index==2
            a=handles.a;
           b=handles.b;
         MJD_Time=handles.MJD_Time;  
     seasonal_signal=handles.seasonal_signal;
     N=handles.N;
prompt = {'WN db','PL Amplitude(mm)'};
   title = 'WN parameter and PL parameter';
    dims = [1 35];
    definput = {'6','0.2'};
    answer = inputdlg(prompt,title,dims,definput);
     power =str2num(answer{2}); 
     power1 =str2num(answer{1});
     [~,amp_wn]= Noise_WN(N,power1);
amp_pl =power;alpha_pl = 1;
[noise_wnpl,~,~]= generate_synth(N,amp_wn,amp_pl,-alpha_pl,1./365.25);%FN+WN
RawData=seasonal_signal+noise_wnpl;
figure
subplot(3,1,1)
plot(MJD_Time,seasonal_signal)
legend('Seasonal signal')
xlim([a b])
ylabel('Amplitude(mm)')
hold on
subplot(3,1,2)
plot(MJD_Time,noise_wnpl)
legend('WN+PL')
xlim([a b])
ylabel('Amplitude(mm)')
subplot(3,1,3)
plot(MJD_Time,RawData)
legend('RawData')
xlim([a b])
ylabel('Amplitude(mm)')
handles.noise_wnpl=noise_wnpl; 
handles.RawData=RawData;   
   end
   end
   handles.RawData_Index=3;
    guidata(hObject,handles)
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% WN+PL+RW
Noise_Index =handles.Noise_Index
   if Noise_Index==1
       N=handles.Data_Length; 
period_sigal=handles.period_sigal;
A=period_sigal;
Data_Length=N
f1=handles.f1;  
   f2=handles.f2;
   f3=handles.f3;

prompt = {'WN db','FN Amplitude(mm)','RW Amplitude(mm)'};
  title = 'WN parameter FN parameter and PL parameter';
    dims = [1 35];
    definput = {'6','0.2','0.2'};
    answer = inputdlg(prompt,title,dims,definput);
     power =str2num(answer{2}); 
%prompt = {'FN amplitude(mm)'};
   % title = 'FN parameter';
   % dims = [1 35];
    %definput = {'0.2'};
    %answer1 = inputdlg(prompt,title,dims,definput);
     power1 =str2num(answer{3}); 
     power0 =str2num(answer{1});
     [~,amp_wn]= Noise_WN(N, power0);
amp_fn=power1;
alpha_fn=1;
amp_rw = power;alpha_rw = 3;
[resi1,~,~]= generate_synth(N,amp_wn,amp_fn,-alpha_fn,1./365.25); % WN + COLOR
[resi2,~,~]= generate_synth(N,0,amp_rw,-alpha_rw,1./365.25);% COLOR
noise_wnrfnrw = resi1 + resi2;
RawData=A+noise_wnrfnrw;
figure
subplot(5,1,1)
plot(f1)
legend('f1')
xlim([0 Data_Length])
subplot(5,1,2)
plot(f2)
xlim([0 Data_Length])
legend('f2')
subplot(5,1,3)
plot(f3)
legend('f3')
xlim([0,Data_Length])
subplot(5,1,4)
plot(noise_wnrfnrw)
legend('WN+FN+RW')
xlim([0,Data_Length])
subplot(5,1,5)
plot(RawData)
legend('RawData')
xlim([0,Data_Length])
handles.RawData=RawData,;
handles.noise_wnrfnrw=noise_wnrfnrw; 
   else if  Noise_Index==2
            a=handles.a;
           b=handles.b;
           MJD_Time=handles.MJD_Time;
     seasonal_signal=handles.seasonal_signal;
     N=handles.N;
     

prompt = {'WN db','RW Amplitude(mm)','FN Amplitude(mm)'};
  title = 'WN parameter FN parameter and PL parameter';
    dims = [1 35];
    definput = {'6','0.2','0.2'};
    answer = inputdlg(prompt,title,dims,definput);
     power =str2num(answer{2}); 
%prompt = {'FN amplitude(mm)'};
   % title = 'FN parameter';
   % dims = [1 35];
    %definput = {'0.2'};
    %answer1 = inputdlg(prompt,title,dims,definput);
     power1 =str2num(answer{3}); 
     power0 =str2num(answer{1});
     [~,amp_wn]= Noise_WN(N, power0);
amp_fn=power1;
alpha_fn=1;
amp_rw = power;alpha_rw = 3;
[resi1,~,~]= generate_synth(N,amp_wn,amp_fn,-alpha_fn,1./365.25); % WN + COLOR
[resi2,~,~]= generate_synth(N,0,amp_rw,-alpha_rw,1./365.25);% COLOR
noise_wnrfnrw = resi1 + resi2;
RawData=seasonal_signal+noise_wnrfnrw;
figure
subplot(3,1,1)
plot(MJD_Time,seasonal_signal)
legend('Seasonal signal')
xlim([a b])
ylabel('Amplitude(mm)')
hold on
subplot(3,1,2)
plot(MJD_Time,noise_wnrfnrw)
legend('WN+FN+RW')
xlim([a b])
ylabel('Amplitude(mm)')
subplot(3,1,3)
plot(MJD_Time,RawData)
legend('RawData')
xlim([a b])
ylabel('Amplitude(mm)')
handles.RawData=RawData;   
 handles.noise_wnrfnrw=noise_wnrfnrw; 
   end
   end
   handles.RawData_Index=4;
    guidata(hObject,handles)
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% WN+GGM
Noise_Index =handles.Noise_Index
   if Noise_Index==1
       f1=handles.f1;  
   f2=handles.f2;
   f3=handles.f3;
period_sigal=handles.period_sigal;

N=handles.Data_Length; 
A=period_sigal;
Data_Length=N
prompt = {'WN db','GGM Amplitude(mm)'};
   title = 'WN parameter and GGM parameter';
    dims = [1 35];
    definput = {'6','0.2'};
    answer = inputdlg(prompt,title,dims,definput);
     power =str2num(answer{2}); 
power1=str2num(answer{1});
     [~,amp_wn]= Noise_WN(N,power1);
amp_ggm = power;alpha_ggm = 4;
[noise_wnggm,~,~]= generate_synth(N,amp_wn,amp_ggm,-alpha_ggm,1./365.25);%GGM+WN
RawData=A+noise_wnggm;
figure
subplot(5,1,1)
plot(f1)
legend('f1')
xlim([0 Data_Length])
subplot(5,1,2)
plot(f2)
xlim([0 Data_Length])
legend('f2')
subplot(5,1,3)
plot(f3)
legend('f3')
xlim([0,Data_Length])
subplot(5,1,4)
plot(noise_wnggm)
legend('WN+GGM')
xlim([0,Data_Length])
subplot(5,1,5)
plot(RawData)
legend('RawData')
xlim([0,Data_Length])
handles.RawData=RawData,;
handles.noise_wnggm=noise_wnggm;
 
   else if  Noise_Index==2
            a=handles.a;
           b=handles.b;
           N=handles.N;
           MJD_Time=handles.MJD_Time;
     seasonal_signal=handles.seasonal_signal;
prompt = {'WN db','GGM Amplitude(mm)'};
   title = 'WN parameter and GGM parameter';
    dims = [1 35];
    definput = {'6','0.2'};
    answer = inputdlg(prompt,title,dims,definput);
     power =str2num(answer{2}); 
power1=str2num(answer{1});
     [~,amp_wn]= Noise_WN(N,power1);

amp_ggm = power;alpha_ggm = 4;
[noise_wnggm,~,~]= generate_synth(N,amp_wn,amp_ggm,-alpha_ggm,1./365.2);%GGM+WN

RawData=seasonal_signal+noise_wnggm;

figure
subplot(3,1,1)
plot(MJD_Time,seasonal_signal)
legend('Seasonal signal')
xlim([a b])
ylabel('Amplitude(mm)')
hold on
subplot(3,1,2)
plot(MJD_Time,noise_wnggm)
legend('WN+GGM')
xlim([a b])
ylabel('Amplitude(mm)')
subplot(3,1,3)
plot(MJD_Time,RawData)
legend('RawData')
xlim([a b])
ylabel('Amplitude(mm)')
handles.noise_wnggm=noise_wnggm; 
handles.RawData=RawData;   
   end
   end
   handles.RawData_Index=5;
    guidata(hObject,handles)

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     cd ( [cd '\example']);
    [fn, path, filterindex] = uigetfile('*.mom', 'Select an obervation file','*.mom');
    if fn~=0
        newfn{1} = fn;
        filename = strcat(path,fn);
        fid1 = fopen(filename);
        data = textscan(fid1,' %f %f','HeaderLines',1);
%         data = textscan(fid1,' %f %f');
        MJD_Time = data{1};
        RawData = data{2};
        fclose(fid1);
    
end
    a = cd;
    a(end-7:end) = [];
    cd (a);
    handles.fn=fn;
handles.RawData=RawData;
handles.RawData_Index=6;
handles.MJD_Time=MJD_Time;
guidata(hObject,handles)

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Noise_Index=handles.Noise_Index;
RawData=handles.RawData;
if Noise_Index==1
number = get(gcf,'Number');
    for i = 1:number+1
         close(figure(i));
    end
clear RawData;
clc;
else if Noise_Index==2
number = get(gcf,'Number');
    for i = 1:number+1
         close(figure(i));
    end
clear RawData;
clc;
else if Noise_Index~=2 && Noise_Index~=1
    number = get(gcf,'Number');
    for i = 1:number+1
         close(figure(i));
    end
clear RawData;
clc;
end
end
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

button=questdlg('Whether to save？','Done','Yes','No','No');
if strcmp(button,'Yes')
RawData_Index=handles.RawData_Index;
a_Index=handles.a_Index
rmse=handles.rmse;
PK=handles.PK;
snr=handles.snr;

 if RawData_Index==6
   Signal_vmd_ssa=handles.Signal_vmd_ssa;
   Signal_ceemdan=handles.Signal_ceemdan;
   Signal_eemd=handles.Signal_eemd;
   Signal_emd=handles.Signal_emd;
 fn=handles.fn;
 save(['reduce noise\WVS\' fn  '.mat'],'Signal_vmd_ssa') 
 save(['reduce noise\CEEMDAN\' fn  '.mat'],'Signal_ceemdan') 
 save(['reduce noise\EEMD\' fn  '.mat'],'Signal_eemd') 
 save(['reduce noise\EMD\' fn  '.mat'],'Signal_emd') 
 save(['index\rmse\' fn  '.mat'],'rmse') 
 save(['index\pk\' fn  '.mat'],'PK') 

 save(['index\snr\' fn  '.mat'],'snr') 
 else 
     Signal_vmd_ssa=handles.Signal_vmd_ssa;
   Signal_ceemdan=handles.Signal_ceemdan;
   Signal_eemd=handles.Signal_eemd;
   Signal_emd=handles.Signal_emd;
 fn=handles.fn;
 save(['reduce noise\WVS\' fn  '.mat'],'Signal_vmd_ssa') 
 save(['reduce noise\CEEMDAN\' fn  '.mat'],'Signal_ceemdan') 
 save(['reduce noise\EEMD\' fn  '.mat'],'Signal_eemd') 
 save(['reduce noise\EMD\' fn  '.mat'],'Signal_emd') 
 save(['index\rmse\' fn  '.mat'],'rmse') 
 save(['index\pk\' fn  '.mat'],'PK') 

 save(['index\snr\' fn  '.mat'],'snr') 

 end


else if strcmp(button,'No')
       
end
end

% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    RawData=handles.RawData;
Signal_vmd_ssa=handles.Signal_vmd_ssa; 
rmse(1,:) = RMSE(RawData,Signal_vmd_ssa);





Signal_ceemdan=handles.Signal_ceemdan; 
rmse(2,:) = RMSE(RawData,Signal_ceemdan);
Signal_eemd=handles.Signal_eemd; 
rmse(3,:) = RMSE(RawData,Signal_eemd);
Signal_emd=handles.Signal_emd; 
rmse(4,:) = RMSE(RawData,Signal_emd);
%h=msgbox(num2str(rmse),'RMSE :');

figure

%plot(rmse,'o')
%legend('WVS','CEEMDAN','EEMD','EMD')
c = categorical({'WVS','CEEMDAN','EEMD','EMD'});
bar(c,rmse,0.5,'r')
title(['Rmse' ...
    ''])
hold on

handles.rmse=rmse;
handles.a_Index=1;
guidata(hObject,handles)
% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    RawData=handles.RawData;
Signal_vmd_ssa=handles.Signal_vmd_ssa; 
PK(1,:) = relative(RawData,Signal_vmd_ssa);



Signal_ceemdan=handles.Signal_ceemdan; 
PK(2,:) =  relative(RawData,Signal_ceemdan);

Signal_eemd=handles.Signal_eemd; 
PK(3,:) =  relative(RawData,Signal_eemd);
Signal_emd=handles.Signal_emd; 
PK(4,:) =  relative(RawData,Signal_emd);
%h=msgbox(num2str(PK),'CC :');
figure
%plot(PK,'bo-')


c = categorical({'WVS','CEEMDAN','EEMD','EMD'});
bar(c,PK,0.5,'r')
title('CC')
ylim([0,1.2])
handles.PK=PK;
handles.a_Index=2;
guidata(hObject,handles)
% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rmse=handles.rmse;
PK=handles.PK;
    RawData=handles.RawData;
Signal_vmd_ssa=handles.Signal_vmd_ssa; 
snr(1,:) = SNR(RawData,Signal_vmd_ssa);




Signal_ceemdan=handles.Signal_ceemdan; 
snr(2,:) = SNR(RawData,Signal_ceemdan);
Signal_eemd=handles.Signal_eemd; 
snr(3,:) =  SNR(RawData,Signal_eemd);
Signal_emd=handles.Signal_emd; 
snr(4,:) =  SNR(RawData,Signal_emd);
%h=msgbox(num2str(snr),'SNR :');
figure

%plot(snr,'bo-')
c = categorical({'WVS','CEEMDAN','EEMD','EMD'});
bar(c,snr,0.5,'r')
title('Snr')

handles.snr=snr;
handles.a_Index=3;
guidata(hObject,handles)

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

button=questdlg('Run or not？','Done','YES','NO','NO');%内容，标题，选项（2个），默认选项
if strcmp(button,'YES')
RawData_Index=handles.RawData_Index;
if RawData_Index==1

    RawData=handles.RawData;

SearchAgents_no=30; % Number of search agents
Function_name='F1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
Max_iteration=10;
 % Maximum numbef of iterations
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
% Load details of the selected benchmark function
[Best_score,Best_pos,WOABAT_cg_curve]=WOABAT(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,RawData);
display(['The best solution obtained by WOABAT is : ', num2str(Best_pos)]);

[Signal_vmd_ssa,allmode,T,tidex] = Method4(RawData,Best_pos(:,1),Best_pos(:,2));

Noise_Index=handles.Noise_Index;
if Noise_Index==1
figure
 plot(RawData,'k');
    hold on
    plot(Signal_vmd_ssa,'r','linewidth',1);
     xlabel('time/s')
    ylabel('Amplitude/mm')
   legend('Original signal','WVS')
handles.Signal_vmd_ssa=Signal_vmd_ssa; 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure
 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_vmd_ssa,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','WVS')
end
end
else if RawData_Index==2
    RawData=handles.RawData;
SearchAgents_no=30; % Number of search agents
Function_name='F1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
Max_iteration=10;
 % Maximum numbef of iterations
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
% Load details of the selected benchmark function
[Best_score,Best_pos,WOABAT_cg_curve]=WOABAT(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,RawData);
display(['The best solution obtained by WOABAT is : ', num2str(Best_pos)]);

[Signal_vmd_ssa,allmode,T,tidex] = Method4(RawData,Best_pos(:,1),Best_pos(:,2));

Noise_Index=handles.Noise_Index;
if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_vmd_ssa,'r','linewidth',1);
     xlabel('time/s')
    ylabel('Amplitude/mm')
   legend('Original signal','WVS')
handles.Signal_vmd_ssa=Signal_vmd_ssa; 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_vmd_ssa,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','WVS')
end
end
else if RawData_Index==3

    RawData=handles.RawData;

SearchAgents_no=30; % Number of search agents
Function_name='F1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
Max_iteration=10;
 % Maximum numbef of iterations
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
% Load details of the selected benchmark function
[Best_score,Best_pos,WOABAT_cg_curve]=WOABAT(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,RawData);
display(['The best solution obtained by WOABAT is : ', num2str(Best_pos)]);

[Signal_vmd_ssa,allmode,T,tidex] = Method4(RawData,Best_pos(:,1),Best_pos(:,2));
Noise_Index=handles.Noise_Index;
if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_vmd_ssa,'r','linewidth',1);
     xlabel('time/s')
    ylabel('Amplitude/mm')
   legend('Original signal','WVS')
handles.Signal_vmd_ssa=Signal_vmd_ssa; 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_vmd_ssa,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','WVS')
end
end 
else if RawData_Index==4

    RawData=handles.RawData;

SearchAgents_no=30; % Number of search agents
Function_name='F1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
Max_iteration=10;
 % Maximum numbef of iterations
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
% Load details of the selected benchmark function
[Best_score,Best_pos,WOABAT_cg_curve]=WOABAT(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,RawData);
display(['The best solution obtained by WOABAT is : ', num2str(Best_pos)]);

[Signal_vmd_ssa,allmode,T,tidex] = Method4(RawData,Best_pos(:,1),Best_pos(:,2));

Noise_Index=handles.Noise_Index;
if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_vmd_ssa,'r','linewidth',1);
     xlabel('time/s')
    ylabel('Amplitude/mm')
   legend('Original signal','WVS')
handles.Signal_vmd_ssa=Signal_vmd_ssa; 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_vmd_ssa,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','WVS')
end
end
else if RawData_Index==5

    RawData=handles.RawData;

SearchAgents_no=30; % Number of search agents
Function_name='F1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
Max_iteration=10;
 % Maximum numbef of iterations
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
% Load details of the selected benchmark function
[Best_score,Best_pos,WOABAT_cg_curve]=WOABAT(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,RawData);
display(['The best solution obtained by WOABAT is : ', num2str(Best_pos)]);

[Signal_vmd_ssa,allmode,T,tidex] = Method4(RawData,Best_pos(:,1),Best_pos(:,2));

Noise_Index=handles.Noise_Index;
if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_vmd_ssa,'r','linewidth',1);
     xlabel('time/s')
    ylabel('Amplitude/mm')
   legend('Original signal','WVS')
handles.Signal_vmd_ssa=Signal_vmd_ssa; 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_vmd_ssa,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','WVS')
end
end

else if RawData_Index==6

    RawData=handles.RawData;
MJD_Time=handles.MJD_Time;
SearchAgents_no=30; % Number of search agents
Function_name='F1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
Max_iteration=10;
 % Maximum numbef of iterations
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
% Load details of the selected benchmark function
[Best_score,Best_pos,WOABAT_cg_curve]=WOABAT(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,RawData);
display(['The best solution obtained by WOABAT is : ', num2str(Best_pos)]);

[Signal_vmd_ssa,allmode,T,tidex] = Method4(RawData,Best_pos(:,1),Best_pos(:,2));
figure

 plot(MJD2Day(MJD_Time),RawData,'k');
    hold on
    plot(MJD2Day(MJD_Time),Signal_vmd_ssa,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','WVS')
  
   
end
end
end
end
end
end


   figure
 semilogy(WOABAT_cg_curve,'Color','r')
 
 xlabel('Iteration');
 ylabel('Weaken or disappear');
 
 axis tight
 grid on
 box on
 
 fs=1;%采样频率
Ts=1/fs;%采样周期
L=length(RawData);%采样点数
t=(0:L-1)*Ts;%时间序列
allmode=allmode';
imfn=allmode';
n=size(imfn,1);
if n<5
    figure

subplot(5,1,1);
plot(t,RawData);%原始信号

ylabel('Original signal','fontsize',12,'fontname','Times new rowan');

for n1=1:4
    subplot(5,1,n1+1);
    plot(t,imfn(n1,:));%IMF分量
    
    ylabel(['IMF' int2str(n1)],'fontsize',12,'fontname','Times new roman');
end
 xlabel('time','fontsize',12,'fontname','Times new roman');
end
%STA=1;
if 4<n&&n<10
figure

subplot(5,1,1);
plot(t,RawData);%原始信号

ylabel('Original signal','fontsize',12,'fontname','Times new rowan');

for n1=1:4
    subplot(5,1,n1+1);
    plot(t,imfn(n1,:));%IMF分量
    
    ylabel(['IMF' int2str(n1)],'fontsize',12,'fontname','Times new roman');
end
 xlabel('time','fontsize',12,'fontname','Times new roman');
 
 figure
 
for n1=1:n-4
    subplot(5,1,n1);
    plot(t,imfn(n1+4,:));%IMF分量
    
    ylabel(['IMF' int2str(n1+4)],'fontsize',12,'fontname','Times new roman');
end

 xlabel('time','fontsize',12,'fontname','Times new roman');
end
if 9<n&&n<15
figure;

subplot(5,1,1);
plot(t,RawData);%原始信号

ylabel('Original signal','fontsize',12,'fontname','Times new rowan');

for n1=1:4
    subplot(5,1,n1+1);
    plot(t,imfn(n1,:));%IMF分量
    
    ylabel(['IMF' int2str(n1)],'fontsize',12,'fontname','Times new roman');
end
 xlabel('time','fontsize',12,'fontname','Times new roman');
 
 figure
 
for n1=1:n-9
    subplot(5,1,n1);
    plot(t,imfn(n1+4,:));%IMF分量
    
    ylabel(['IMF' int2str(n1+4)],'fontsize',12,'fontname','Times new roman');
end

 xlabel('time','fontsize',12,'fontname','Times new roman');
figure
for n1=1:n-9
    subplot(5,1,n1);
    plot(t,imfn(n1+9,:));%IMF分量
    
    ylabel(['IMF' int2str(n1+9)],'fontsize',12,'fontname','Times new roman');
end

 xlabel('time','fontsize',12,'fontname','Times new roman');
end

if 14<n&&n<20
figure;

subplot(5,1,1);
plot(t,RawData);%原始信号

ylabel('Original signal','fontsize',12,'fontname','Times new rowan');
figure
for n1=1:4
    subplot(5,1,n1+1);
    plot(t,imfn(n1,:));%IMF分量
    
    ylabel(['IMF' int2str(n1)],'fontsize',12,'fontname','Times new roman');
end
 xlabel('time','fontsize',12,'fontname','Times new roman');

for n1=1:n-14
    subplot(5,1,n1);
    plot(t,imfn(n1+4,:));%IMF分量
    
    ylabel(['IMF' int2str(n1+4)],'fontsize',12,'fontname','Times new roman');
end

 xlabel('time','fontsize',12,'fontname','Times new roman');
 figure
for n1=1:n-14
    subplot(5,1,n1);
    plot(t,imfn(n1+9,:));%IMF分量
    
    ylabel(['IMF' int2str(n1+9)],'fontsize',12,'fontname','Times new roman');
end

 xlabel('time','fontsize',12,'fontname','Times new roman');
figure
for n1=1:n-14
    subplot(5,1,n1);
    plot(t,imfn(n1+14,:));%IMF分量
    
    ylabel(['IMF' int2str(n1+14)],'fontsize',12,'fontname','Times new roman');
end

 xlabel('time','fontsize',12,'fontname','Times new roman');
end
if n==20
figure;

subplot(5,1,1);
plot(t,RawData);%原始信号

ylabel('Original signal','fontsize',12,'fontname','Times new rowan');

for n1=1:4
    subplot(5,1,n1+1);
    plot(t,imfn(n1,:));%IMF分量
    
    ylabel(['IMF' int2str(n1)],'fontsize',12,'fontname','Times new roman');
end
 xlabel('time','fontsize',12,'fontname','Times new roman');
 
 figure
 
for n1=1:n-15
    subplot(5,1,n1);
    plot(t,imfn(n1+4,:));%IMF分量
    
    ylabel(['IMF' int2str(n1+4)],'fontsize',12,'fontname','Times new roman');
end

 xlabel('time','fontsize',12,'fontname','Times new roman');
 figure
for n1=1:n-15
    subplot(5,1,n1);
    plot(t,imfn(n1+9,:));%IMF分量
    
    ylabel(['IMF' int2str(n1+9)],'fontsize',12,'fontname','Times new roman');
end

 xlabel('time','fontsize',12,'fontname','Times new roman');
figure
for n1=1:n-15
    subplot(5,1,n1);
    plot(t,imfn(n1+14,:));%IMF分量
    
    ylabel(['IMF' int2str(n1+14)],'fontsize',12,'fontname','Times new roman');
end

 xlabel('time','fontsize',12,'fontname','Times new roman');
figure

    subplot(5,1,1);
    plot(t,imfn(20,:));%IMF分量
    
    ylabel(['IMF' int2str(20)],'fontsize',12,'fontname','Times new roman');


 xlabel('time','fontsize',12,'fontname','Times new roman');

end
h=msgbox({'Best k and α:';num2str(Best_pos)});
handles.Signal_vmd_ssa=Signal_vmd_ssa; 
 else if strcmp(button,'NO')
end 
end

  
  handles.Signal_Index=1;
   guidata(hObject,handles)
% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button=questdlg('Run or not？','Done','YES','NO','NO');%内容，标题，选项（2个），默认选项
if strcmp(button,'YES')
 RawData_Index=handles.RawData_Index;
if RawData_Index==1

    RawData=handles.RawData;

[Signal_emd,Value,loc] = Method7(RawData);
Noise_Index=handles.Noise_Index;
if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_emd,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','EMD')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_emd,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','EMD')
end
end
else if RawData_Index==2

    RawData=handles.RawData;

[Signal_emd,Value,loc] = Method7(RawData);
Noise_Index=handles.Noise_Index;
if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_emd,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','EMD')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_emd,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','EMD')
end
end

else if RawData_Index==3

    RawData=handles.RawData;

[Signal_emd,Value,loc] = Method7(RawData);
Noise_Index=handles.Noise_Index;
if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_emd,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','EMD')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_emd,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','EMD')
end
end
else if RawData_Index==4

    RawData=handles.RawData;

[Signal_emd,Value,loc] = Method7(RawData);
Noise_Index=handles.Noise_Index;
if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_emd,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','EMD')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_emd,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','EMD')
end
end
else if RawData_Index==5

    RawData=handles.RawData;

[Signal_emd,Value,loc] = Method7(RawData);
Noise_Index=handles.Noise_Index;
if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_emd,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','EMD')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_emd,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','EMD')
end
end
else if RawData_Index==6
MJD_Time=handles.MJD_Time;
    RawData=handles.RawData;

[Signal_emd,Value,loc] = Method7(RawData);
figure

 plot(MJD2Day(MJD_Time),RawData,'k');
    hold on
    plot(MJD2Day(MJD_Time),Signal_emd,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','EMD')
end
end
end
end
end
end

handles.Signal_emd=Signal_emd; 
 else if strcmp(button,'NO')
end 
end

handles.Signal_Index=2;
   guidata(hObject,handles)
% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button=questdlg('Run or not？','Done','YES','NO','NO');
if strcmp(button,'YES')
      

RawData_Index=handles.RawData_Index;
if RawData_Index==1

    RawData=handles.RawData;

 [Signal_eemd,k1,IMF1] = Method5(RawData);
 Noise_Index=handles.Noise_Index;
 if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_eemd,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','EEMD')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_eemd,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','EEMD')
end
end

else if RawData_Index==2

    RawData=handles.RawData;

 [Signal_eemd,k1,IMF1] = Method5(RawData);
 Noise_Index=handles.Noise_Index;
  if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_eemd,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','EEMD')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_eemd,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','EEMD')
end
  end
else if RawData_Index==3

    RawData=handles.RawData;

 [Signal_eemd,k1,IMF1] = Method5(RawData);
 Noise_Index=handles.Noise_Index;
  if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_eemd,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','EEMD')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_eemd,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','EEMD')
end
end
else if RawData_Index==4
    RawData=handles.RawData;

[Signal_eemd,k1,IMF1] = Method5(RawData);
Noise_Index=handles.Noise_Index;
 if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_eemd,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','EEMD')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_eemd,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','EEMD')
end
end
else if RawData_Index==5

    RawData=handles.RawData;

 [Signal_eemd,k1,IMF1] = Method5(RawData);
 Noise_Index=handles.Noise_Index;
  if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_eemd,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','EEMD')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_eemd,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','EEMD')
end
end
else if  RawData_Index==6
     
   MJD_Time=handles.MJD_Time;

    RawData=handles.RawData;

[Signal_eemd,Value,loc] = Method5(RawData);
figure

 plot(MJD2Day(MJD_Time),RawData,'k');
    hold on
    plot(MJD2Day(MJD_Time),Signal_eemd,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','EEMD')


end
end
end
end
end
end
   handles.Signal_eemd=Signal_eemd; 
   else if strcmp(button,'NO')
end 
end

   handles.Signal_Index=3;
   guidata(hObject,handles)

% --- Executes on button press in pushbutton19.


% --- Executes during object creation, after setting all properties.


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button=questdlg('Run or not？','Done','YES','NO','NO');
if strcmp(button,'YES')
      

RawData_Index=handles.RawData_Index;
if RawData_Index==1

    RawData=handles.RawData;

 
 [Signal_ceemdan,k1,IMF1] = Method1(RawData);
 Noise_Index=handles.Noise_Index;
 if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_ceemdan,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','CEEMDAN')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_ceemdan,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','CEEMDAN')
end
end

else if RawData_Index==2

      RawData=handles.RawData;

 [Signal_ceemdan,k1,IMF1] = Method1(RawData);
 Noise_Index=handles.Noise_Index;
 if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_ceemdan,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','CEEMDAN')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_ceemdan,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','CEEMDAN')
end
  end
else if RawData_Index==3

    RawData=handles.RawData;

 [Signal_ceemdan,k1,IMF1] = Method1(RawData);
 Noise_Index=handles.Noise_Index;
 if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_ceemdan,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','CEEMDAN')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_ceemdan,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','CEEMDAN')
end
end
else if RawData_Index==4
    RawData=handles.RawData;

 [Signal_ceemdan,k1,IMF1] = Method1(RawData);
 Noise_Index=handles.Noise_Index;
 if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_ceemdan,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','CEEMDAN')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_ceemdan,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','CEEMDAN')
end
end
else if RawData_Index==5

    RawData=handles.RawData;

 [Signal_ceemdan,k1,IMF1] = Method1(RawData);
 Noise_Index=handles.Noise_Index;
 if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_ceemdan,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','CEEMDAN')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD_Time,Signal_ceemdan,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','CEEMDAN')
end
end
else if  RawData_Index==6
     
   MJD_Time=handles.MJD_Time;

    RawData=handles.RawData;

[Signal_ceemdan,Value,loc] = Method1(RawData);
figure

 plot(MJD2Day(MJD_Time),RawData,'k');
    hold on
    plot(MJD2Day(MJD_Time),Signal_ceemdan,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','CEEMDAN')


end
end
end
end
end
end
   handles.Signal_ceemdan=Signal_ceemdan; 
   else if strcmp(button,'NO')
end 
end

   handles.Signal_Index=4;
   guidata(hObject,handles)


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all


% --- Executes during object creation, after setting all properties.
function pushbutton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
quit


% --- Executes on selection change in popupmenu1.



% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

button=questdlg('Run or not？','Done','YES','NO','NO');
if strcmp(button,'YES')
      

RawData_Index=handles.RawData_Index;
if RawData_Index==1

    RawData=handles.RawData;

 
 [Signal_SSA]=Method2(RawData);
 Noise_Index=handles.Noise_Index;
 if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_SSA,'r','linewidth',1);
     xlabel('time/s')
    ylabel('Amplitude/mm')
   legend('Original signal','SSA')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
   plot(MJD2Day(MJD_Time),Signal_SSA,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','SSA')
end
end

else if RawData_Index==2

      RawData=handles.RawData;

[Signal_SSA]=Method2(RawData);
 Noise_Index=handles.Noise_Index;
 if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_SSA,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','SSA')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
     plot(MJD2Day(MJD_Time),Signal_SSA,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','SSA')
end
  end
else if RawData_Index==3

    RawData=handles.RawData;

[Signal_SSA]=Method2(RawData);
 Noise_Index=handles.Noise_Index;
 if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_SSA,'r','linewidth',1);
     xlabel('time/s')
    ylabel('Amplitude/mm')
   legend('Original signal','SSA')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
    plot(MJD2Day(MJD_Time),Signal_SSA,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','SSA')
end
end
else if RawData_Index==4
    RawData=handles.RawData;

[Signal_SSA]=Method2(RawData);
 Noise_Index=handles.Noise_Index;
 if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
     plot(Signal_SSA,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','SSA')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
     plot(MJD2Day(MJD_Time),Signal_SSA,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','SSA')
end
end
else if RawData_Index==5

    RawData=handles.RawData;

 [Signal_SSA]=Method2(RawData);
 Noise_Index=handles.Noise_Index;
 if Noise_Index==1
figure

 plot(RawData,'k');
    hold on
    plot(Signal_SSA,'r','linewidth',1);
     xlabel('time')
    ylabel('Amplitude/mm')
   legend('Original signal','SSA')
 
else if Noise_Index==2
MJD_Time=handles.MJD_Time;
figure

 plot(MJD_Time,RawData,'k');
    hold on
     plot(MJD2Day(MJD_Time),Signal_SSA,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','SSA')
end
end
else if  RawData_Index==6
     
   MJD_Time=handles.MJD_Time;

    RawData=handles.RawData;

[Signal_SSA]=Method2(RawData);
figure

 plot(MJD2Day(MJD_Time),RawData,'k');
    hold on
    plot(MJD2Day(MJD_Time),Signal_SSA,'r','linewidth',1);
     xlabel('time/a')
    ylabel('Amplitude/mm')
   legend('Original signal','SSA')


end
end
end
end
end
end
   handles.Signal_SSA=Signal_SSA; 
   else if strcmp(button,'NO')
end 
end

   handles.Signal_Index=6;
   guidata(hObject,handles)



% --- Executes on button press in pushbutton26.



% --------------------------------------------------------------------
