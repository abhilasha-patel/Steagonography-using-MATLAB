function varargout = Insert_Message(varargin)
% INSERT_MESSAGE M-file for Insert_Message.fig
%      INSERT_MESSAGE, by itself, creates a new INSERT_MESSAGE or raises the existing
%      singleton*.
%
%      H = INSERT_MESSAGE returns the handle to a new INSERT_MESSAGE or the handle to
%      the existing singleton*.
%
%      INSERT_MESSAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INSERT_MESSAGE.M with the given input arguments.
%
%      INSERT_MESSAGE('Property','Value',...) creates a new INSERT_MESSAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Insert_Message_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Insert_Message_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Insert_Message

% Last Modified by GUIDE v2.5 22-Mar-2015 19:23:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Insert_Message_OpeningFcn, ...
                   'gui_OutputFcn',  @Insert_Message_OutputFcn, ...
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


% --- Executes just before Insert_Message is made visible.
function Insert_Message_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Insert_Message (see VARARGIN)

% Choose default command line output for Insert_Message
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Insert_Message wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = Insert_Message_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Get_a_Message_Callback(hObject, eventdata, handles)
% hObject    handle to Get_a_Message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Get_a_Message as text
%        str2double(get(hObject,'String')) returns contents of Get_a_Message as a double

inputdata = get(hObject,'String');

global message;
global Length_of_Message;


[ message, Length_of_Message] = Function_1_Message(inputdata);


% --- Executes during object creation, after setting all properties.
function Get_a_Message_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Get_a_Message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cover_image.
function cover_image_Callback(hObject, eventdata, handles)
% hObject    handle to cover_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Path;

[Path] = InputImage();

axes(handles.axes1);
imshow(Path)

global OriginalImage;

[OriginalImage] = imread(Path);

%OriginalImage = imresize(OriginalImage,[180,80]);


% --- Executes on button press in Create_Stego.
function Create_Stego_Callback(hObject, eventdata, handles)
% hObject    handle to Create_Stego (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global OriginalImage
global StegoImage;
global message;
global Length_of_Message;
global LighterAlgo;
global DarkerAlgo;
global lighter;
global darker;

clc;



[ LighterAlgo, DarkerAlgo,  lighter, darker] = Function_2_Lighter_or_Darker(OriginalImage);

if (LighterAlgo == 1)
    
    [StegoImage] =  My_Lighter_Embedding_New(OriginalImage,message,Length_of_Message,lighter);
    
end

if (DarkerAlgo == 1)
    
   [StegoImage] = My_Darker_Embedding_New(OriginalImage,message,Length_of_Message,darker);
    
end

global StegoPath;

[StegoPath] = StoreStegoImage(StegoImage);


axes(handles.axes2);
imshow(StegoPath);
  


% --- Executes on button press in Enter_Message.
function Enter_Message_Callback(hObject, eventdata, handles)
% hObject    handle to Enter_Message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
