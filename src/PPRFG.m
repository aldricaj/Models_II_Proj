function varargout = PPRFG(varargin)
%Planet Selection And Payload
% PPRFG MATLAB code for PPRFG.fig
%      PPRFG, by itself, creates a new PPRFG or raises the existing
%      singleton*.
%
%      H = PPRFG returns the handle to a new PPRFG or the handle to
%      the existing singleton*.
%
%      PPRFG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PPRFG.M with the given input arguments.
%
%      PPRFG('Property','Value',...) creates a new PPRFG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PPRFG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PPRFG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PPRFG

% Last Modified by GUIDE v2.5 13-Apr-2016 08:11:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PPRFG_OpeningFcn, ...
                   'gui_OutputFcn',  @PPRFG_OutputFcn, ...
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


% --- Executes just before PPRFG is made visible.
function PPRFG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PPRFG (see VARARGIN)

% Choose default command line output for PPRFG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PPRFG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PPRFG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in PlanetSelect.
function PlanetSelect_Callback(hObject, eventdata, handles)
% hObject    handle to PlanetSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PlanetSelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PlanetSelect
number=get(handles.PlanetSelect,'Value');
[mass,gravity,radius,print] = planetData(number);
set(handles.Mass,'String',num2str(print))
set(handles.Gravity,'String',num2str(gravity))
set(handles.Radius,'String',num2str(radius))



% --- Executes during object creation, after setting all properties.
function PlanetSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlanetSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Payload_Callback(hObject, eventdata, handles)
% hObject    handle to Payload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Payload as text
%        str2double(get(hObject,'String')) returns contents of Payload as a double
payload = str2double(get(handles.Payload,'String'));
if (isnan(payload))||(payload==1i)                       
    set(handles.Payload, 'String','100');
    errordlg('Input must be a number');   
end



% --- Executes during object creation, after setting all properties.
function Payload_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Payload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on slider movement.
function HightSlider_Callback(hObject, eventdata, handles)
% hObject    handle to HightSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
hight = get(handles.HightSlider, 'Value');
set(handles.HightBox,'String',hight)



% --- Executes during object creation, after setting all properties.
function HightSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HightSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function HightBox_Callback(hObject, eventdata, handles)
% hObject    handle to HightBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HightBox as text
%        str2double(get(hObject,'String')) returns contents of HightBox as a double
hight = str2double(get(handles.HightBox,'String'));
if (isnan(hight))||(hight==1i)                      
    set(handles.HightBox, 'String','0');
    errordlg('Input must be a number');
    set(handles.HightSlider,'Value',0)
elseif (hight>10)||(hight<0)
    set(handles.HightBox,'String','0');
    errordlg('Input must be between 0 and 10')
    set(handles.HightSlider,'Value',0)
else
    hight = str2num(get(handles.HightBox, 'String'));
    set(handles.HightSlider,'Value',hight)
end

% --- Executes during object creation, after setting all properties.
function HightBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HightBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Launch.
function Launch_Callback(hObject, eventdata, handles)
% hObject    handle to Launch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.Graph);
cla;
number=get(handles.PlanetSelect,'Value');
[mass,gravity,radius,print] = planetData(number);
[xPlanet,yPlanet,size] = circle( 0,0,radius );
plot(xPlanet,yPlanet)
axis([size])
axis square
hold on


% --- Executes on slider movement.
function AngleSlider_Callback(hObject, eventdata, handles)
% hObject    handle to AngleSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
angle = get(handles.AngleSlider, 'Value');
set(handles.AngleBox,'String',angle)

% --- Executes during object creation, after setting all properties.
function AngleSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AngleSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function AngleBox_Callback(hObject, eventdata, handles)
% hObject    handle to AngleBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AngleBox as text
%        str2double(get(hObject,'String')) returns contents of AngleBox as a double
angle = str2double(get(handles.AngleBox,'String'));
if (isnan(angle))||(angle==1i)                      
    set(handles.AngleBox, 'String','0');
    errordlg('Input must be a number');
    set(handles.AngleSlider,'Value',0)
elseif (angle>90)||(angle<-90)
    set(handles.AngleBox,'String','0');
    errordlg('Input must be between -90 and 90')
    set(handles.AngleSlider,'Value',0)
else
    angle = str2num(get(handles.AngleBox, 'String'));
    set(handles.AngleSlider,'Value',angle)
end

% --- Executes during object creation, after setting all properties.
function AngleBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AngleBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function ThrustSlider_Callback(hObject, eventdata, handles)
% hObject    handle to ThrustSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
thrust = get(handles.ThrustSlider, 'Value');
set(handles.ThrustBox,'String',thrust)

% --- Executes during object creation, after setting all properties.
function ThrustSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ThrustSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ThrustBox_Callback(hObject, eventdata, handles)
% hObject    handle to ThrustBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ThrustBox as text
%        str2double(get(hObject,'String')) returns contents of ThrustBox as a double
thrust = str2double(get(handles.ThrustBox,'String'));
if (isnan(thrust))||(thrust==1i)                      
    set(handles.ThrustBox, 'String','0');
    errordlg('Input must be a number');
    set(handles.ThrustSlider,'Value',0)
elseif (thrust>90)||(thrust<-90)
    set(handles.ThrustBox,'String','0');
    errordlg('Input must be between -90 and 90')
    set(handles.ThrustSlider,'Value',0)
else
    thrust = str2num(get(handles.ThrustBox, 'String'));
    set(handles.ThrustSlider,'Value',thrust)
end

% --- Executes during object creation, after setting all properties.
function ThrustBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ThrustBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
