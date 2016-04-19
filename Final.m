function varargout = Final(varargin)
%Planet Selection And Payload
% Final MATLAB code for Final.fig
%      Final, by itself, creates a new Final or raises the existing
%      singleton*.
%
%      H = Final returns the handle to a new Final or the handle to
%      the existing singleton*.
%
%      Final('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Final.M with the given input arguments.
%
%      Final('Property','Value',...) creates a new Final or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Final_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Final_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Final

% Last Modified by GUIDE v2.5 19-Apr-2016 15:22:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Final_OpeningFcn, ...
                   'gui_OutputFcn',  @Final_OutputFcn, ...
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


% --- Executes just before Final is made visible.
function Final_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Final (see VARARGIN)

% Choose default command line output for Final
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Final wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Final_OutputFcn(hObject, eventdata, handles) 
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
elseif (hight>120)||(hight<0)
    set(handles.HightBox,'String','0');
    errordlg('Input must be between 0 and 120')
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
hold off
axes(handles.Graph);
cla;
%Data Pull
payload = str2double(get(handles.Payload,'String'));
number=get(handles.PlanetSelect,'Value');
[mass,gravity,radius,print] = planetData(number);
thrust = str2double(get(handles.ThrustBox,'String'));
hight = str2double(get(handles.HightBox,'String'));
launchAngle = str2double(get(handles.AngleBox,'String'));
[posVector] = runSim(launchAngle,1000*thrust,payload, radius, gravity, hight);
[xPlanet,yPlanet,size] = circle( 0,0,radius );
magnitudeA=0;
%%%%evan
    x=posVector(:,1);
    y=posVector(:,2);
    maxAxis = radius*1.2
for t=1:1:length(posVector) % change later  
    %fprintf('t+%0.2f x=%0.4f y=%0.4f\n',t,x(t),y(t));
    
%CrashTest
    if mag(posVector(t))<radius
        errordlg('You have crashed and burned :(')
        clear=imread('rocket.jpg');
        imshow(clear)
        break
    end
%Apogee&Perigee
    magnitudeB=mag(posVector(t);
    if magnitudeB>magnitudeA
        set(handles.Apogee,'String',num2str(magnitudeB)
    elseif magnitudeB<magnitudeB
        set(handles.Perigee,'string',num2str(magnitudeB)
    end
    
    pause(.001) % speed adjustable
    if true % rocketIsBuring(i)
        
        dir = atan(y(t)/x(t));
        burnEnd = t; % keeps track of when it was last burned
        [tx ty] = plotTriangle(x(t),y(t),dir,max([x(t) y(t)])/20);
        % burn sound maybe?
        burnPath = 1:t;
        if mod(t,2) == 0
            plot(x(t),'.-r');
        else
            plot(x(t),'.-y');
        end
        % plot planet
        plot(xPlanet,yPlanet)
        hold on;
        plot(x(burnPath),y(burnPath),'r'); % red burn path, with turning rocket
        plot(tx,ty,'k');
        hold off;
%     else            
%        
%         [tx ty] = plotTriangle(pos.x(i),pos.y(i),dir,max([pos.x pos.y])/20);
%         
%         burnPath = 1:burnEnd;
%         
%         % plot earth
%         plot(xPlanet,yPlanet)
%         hold on;
%         plot(pos.x(burnEnd),pos.y(burnEnd),'ko'); % point where burn stops
%         plot(pos.x(burnPath),pos.y(burnPath),'r'); % red burn path, with turning rocket
%         plot(pos.x(burnEnd:i),pos.y(burnEnd:i),'k'); % path of 'floating rocket'
%         plot(tx,ty,'k'); % plot the actual rocket
%         hold off;

%     if max([x(t) y(t)])*1.2  > max
%         maxAxis = max([x(t) y(t)])*1.2
%     end
    maxAxis = max([x(t) y(t)])*1.2;

    axis([-maxAxis maxAxis -maxAxis maxAxis])
    end    
    %axis([%-max([pos.x pos.y])% max([pos.x pos.y]) -max([pos.x pos.y]) max([pos.x pos.y])]);
end


hold on
plot(posVector(:,1),posVector(:,2))



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
elseif (thrust>1000)||(thrust<0)
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
