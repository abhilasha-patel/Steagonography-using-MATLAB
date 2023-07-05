function varargout = Extract(varargin)
% EXTRACT MATLAB code for Extract.fig
%      EXTRACT, by itself, creates a new EXTRACT or raises the existing
%      singleton*.
%
%      H = EXTRACT returns the handle to a new EXTRACT or the handle to
%      the existing singleton*.
%
%      EXTRACT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTRACT.M with the given input arguments.
%
%      EXTRACT('Property','Value',...) creates a new EXTRACT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Extract_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Extract_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Extract

% Last Modified by GUIDE v2.5 08-Apr-2015 10:26:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Extract_OpeningFcn, ...
                   'gui_OutputFcn',  @Extract_OutputFcn, ...
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


% --- Executes just before Extract is made visible.
function Extract_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Extract (see VARARGIN)

% Choose default command line output for Extract
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Extract wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Extract_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global StegoPath;
global StegoImageReceived;
[StegoPath] = InputImage();

StegoImageReceived = imread(StegoPath);
axes(handles.axes1);
imshow(StegoImageReceived);



function message_disp_Callback(hObject, eventdata, handles)
% hObject    handle to message_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of message_disp as text
%        str2double(get(hObject,'String')) returns contents of message_disp as a double


function message_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Get_a_Message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end








% --- Executes on button press in Extract_Message.
function Extract_Message_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_Message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global StegoImageReceived;
global textString;



[ LighterAlgo, DarkerAlgo] = Function_2_Lighter_or_Darker(StegoImageReceived);

if (LighterAlgo == 1)
    
    [textString] = My_Lighter_Extracting_New(StegoImageReceived);

end 

if (DarkerAlgo == 1)
    

    [textString] = My_Darker_Extracting_New(StegoImageReceived);

end

set(handles.message_disp,'string',textString);
