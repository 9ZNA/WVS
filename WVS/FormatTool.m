function varargout = FormatTool(varargin)
% FORMATTOOL MATLAB code for FormatTool.fig
%      FORMATTOOL, by itself, creates a new FORMATTOOL or raises the existing
%      singleton*.
%
%      H = FORMATTOOL returns the handle to a new FORMATTOOL or the handle to
%      the existing singleton*.
%
%      FORMATTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FORMATTOOL.M with the given input arguments.
%
%      FORMATTOOL('Property','Value',...) creates a new FORMATTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FormatTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FormatTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FormatTool

% Last Modified by GUIDE v2.5 23-Jul-2020 16:05:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FormatTool_OpeningFcn, ...
                   'gui_OutputFcn',  @FormatTool_OutputFcn, ...
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


% --- Executes just before FormatTool is made visible.
function FormatTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FormatTool (see VARARGIN)

% Choose default command line output for FormatTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FormatTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FormatTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Filepath_list.
function Filepath_list_Callback(hObject, eventdata, handles)
% hObject    handle to Filepath_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Filepath_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Filepath_list


% --- Executes during object creation, after setting all properties.
function Filepath_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filepath_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Load_button.
function Load_button_Callback(hObject, eventdata, handles)
% hObject    handle to Load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filepath
filepath = uigetdir(strcat(cd,'\example'),'Please choose *.neu folder'); 
current = filepath;
A=dir(current);
wholefolder = '';
for ss=3:length(A)
    folder = strcat(current,'\',A(ss,1).name);
    wholefolder = [wholefolder;folder];
end
set(handles.Filepath_list,'String',wholefolder);
    
% --- Executes on button press in buttonCMONOC2Mom.
function buttonCMONOC2Mom_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCMONOC2Mom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filepath
cmonoc2mom(filepath)

% --- Executes on button press in View_button.
function View_button_Callback(hObject, eventdata, handles)
% hObject    handle to View_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
winopen('TSprocessing\Format Tool')

% --- Executes on button press in Close_button.
function Close_button_Callback(hObject, eventdata, handles)
% hObject    handle to Close_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1)


% --- Executes on button press in buttonSOPAC2Mom.
function buttonSOPAC2Mom_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSOPAC2Mom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filepath
sopac2mom(filepath)
