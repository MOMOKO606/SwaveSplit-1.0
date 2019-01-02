function varargout = Sub2Swave(varargin)
% SUB2SWAVE M-file for Sub2Swave.fig
%      SUB2SWAVE, by itself, creates a new SUB2SWAVE or raises the existing
%      singleton*.
%
%      H = SUB2SWAVE returns the handle to a new SUB2SWAVE or the handle to
%      the existing singleton*.
%
%      SUB2SWAVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUB2SWAVE.M with the given input arguments.
%
%      SUB2SWAVE('Property','Value',...) creates a new SUB2SWAVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sub2Swave_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Sub2Swave_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Sub2Swave

% Last Modified by GUIDE v2.5 30-Oct-2012 23:28:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Sub2Swave_OpeningFcn, ...
                   'gui_OutputFcn',  @Sub2Swave_OutputFcn, ...
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


% --- Executes just before Sub2Swave is made visible.
function Sub2Swave_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sub2Swave (see VARARGIN)

%  �������1Ϊ���h���˴�Ϊ������figure�ľ����
h=varargin{1};
%  ����guihandles�������h�������handles�ṹ�塣
handles.MainHandles=guihandles(h);
%  ���½ṹ�塣
guidata(hObject,handles);

% Choose default command line output for Sub2Swave
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Sub2Swave wait for user response (see UIRESUME)
% uiwait(handles.figure3);


% --- Outputs from this function are returned to the command line.
function varargout = Sub2Swave_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Savepic_Callback(hObject, eventdata, handles)
% hObject    handle to Savepic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ����ǰҪ����ͼ��ľ������ֵ��hpic�ϡ�
hpic=gca;
%  ����saveasֻ�����figure����ͼ�񣬹���Ҫ����һ����figure��
newfig=figure;
set(newfig,'Visible','off');  %  ���䲻�ɼ�
delete(get(newfig,'Children'));  %  ɾ��figure�ڵ��Ӷ��󣬱����������ص�
%  ��Ҫ�����ͼ���Ƶ���figure�ϡ�
copyobj(hpic,newfig);
set(newfig,'Units','Normalized','Position',[0,0,1,1]);  %  ����figure���
set(gca,'Units','Normalized','Position',[0.08,0.11,0.83,0.815]);  %  ����ͼ����figure�е�λ��
%  ����һ���ļ�����Ի���
[FileName,PathName]=uiputfile(...
{'*.fig','MATLAB Figure(*.fig)';'*.jpg','JPEG image(*.jpg)';...
 '*.bmp','Bitmap file(*.bmp)';'*.tif','TIFF image(*.tif)';'*.*','All Files(*.*)'},...
 'ͼƬ���Ϊ','untitled.fig');
if (FileName == 0)
    %  ���û������ȡ����ʱ���ر��½�figure��������ֹ��
    close(newfig);
    return
else
    if (strcmpi(FileName(end-3:end),'.fig'))  %  �˴���Ҫ�ж��û��Ƿ�ѡ�񱣴�Ϊfig��ʽ����Ϊ��ͼ�񱣴�Ϊfigʱ��
        set(newfig,'Visible','on');           %  ��Ҫ��figure��Visible��������Ϊ�ɼ�������򿪱���õ�figʱ����Ļ��ʲô��������֡�
    end
    saveas(newfig,fullfile(PathName,FileName));
    close(newfig);
end


% --------------------------------------------------------------------
function Savedata_Callback(hObject, eventdata, handles)
% hObject    handle to Savedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰͼ���еķ�ֵ���ݡ�
ydata=getappdata(gca,'Y');
%  ����һ���ļ�����Ի���
[FileName,PathName]=uiputfile(...
{'*.dat','Golden Software Data(*.dat)';...
 '*.txt','ASCII Data(*.txt)';'*.*','All Files(*.*)'},...
 '�ļ����Ϊ','untitled.dat');
if (FileName == 0)
    %  ���û������ȡ����ʱ��������ֹ��
    return
else
    dlmwrite(fullfile(PathName,FileName),ydata);
end


% --------------------------------------------------------------------
function Saveall_Callback(hObject, eventdata, handles)
% hObject    handle to Saveall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡGUI��ܣ��൱�ڽ�ͼ����
h=getframe(handles.figure3);
%  ����ȡ�Ŀ��ת��Ϊͼ��
h=frame2im(h);
%  ����һ���ļ�����Ի���
[FileName,PathName]=uiputfile(...
{'*.jpg','JPEG image(*.jpg)';'*.bmp','Bitmap file(*.bmp)';...
 '*.tif','TIFF image(*.tif)';'*.*','All Files(*.*)'},...
 'ͼƬ���Ϊ','untitled.jpg');
if (FileName == 0)
    %  ���û������ȡ����ʱ���ر��½�figure��������ֹ��
    return
else
    imwrite(h,fullfile(PathName,FileName));
end


% --------------------------------------------------------------------
function PrintView_Callback(hObject, eventdata, handles)
% hObject    handle to PrintView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printpreview(handles.figure3);


% --------------------------------------------------------------------
function Print_Callback(hObject, eventdata, handles)
% hObject    handle to Print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure3);


% --------------------------------------------------------------------
function righthand_btn1_Callback(hObject, eventdata, handles)
% hObject    handle to righthand_btn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Rbtn_Savepic_Callback(hObject, eventdata, handles)
% hObject    handle to Rbtn_Savepic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Savepic_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function Rbtn_Savedata_Callback(hObject, eventdata, handles)
% hObject    handle to Rbtn_Savedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Savedata_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function Copypic_Callback(hObject, eventdata, handles)
% hObject    handle to Copypic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ����ǰҪ����ͼ��ľ������ֵ��hpic�ϡ�
hpic=gca;
%  ����saveasֻ�����figure����ͼ�񣬹���Ҫ����һ����figure��
newfig=figure;
set(newfig,'Visible','off');  %  ���䲻�ɼ�
delete(get(newfig,'Children'));  %  ɾ��figure�ڵ��Ӷ��󣬱����������ص�
%  ��Ҫ�����ͼ���Ƶ���figure�ϡ�
copyobj(hpic,newfig);
set(newfig,'Units','Normalized','Position',[0,0,1,1]);  %  ����figure���
set(gca,'Units','Normalized','Position',[0.08,0.11,0.83,0.815]);  %  ����ͼ����figure�е�λ��
%  ��ͼ���Ƶ����а塣
hgexport(newfig,'-clipboard');
%  �ر���figure��
close(newfig);


% --------------------------------------------------------------------
function righthand_btn2_Callback(hObject, eventdata, handles)
% hObject    handle to righthand_btn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Copystr_Callback(hObject, eventdata, handles)
% hObject    handle to Copystr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in pushbutton1.

%  �õ���ǰ�����ı����е�String��  
str=get(gco,'String');
%  ��String�����ݸ��Ƶ����а塣
clipboard('copy',str);


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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% �ر��ӽ��档
close(gcf);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ���������ı����������ɾ����
MainHandles=handles.MainHandles;
for i=3:8
    t=['MainHandles.edit',num2str(i)];
    eval(['str=',t,';'])
    set(str,'String',[]);
end
%  �ر��ӽ��档
close(gcf);
    
