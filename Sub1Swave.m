function varargout = Sub1Swave(varargin)
% SUB1SWAVE M-file for Sub1Swave.fig
%      SUB1SWAVE, by itself, creates a new SUB1SWAVE or raises the existing
%      singleton*.
%
%      H = SUB1SWAVE returns the handle to a new SUB1SWAVE or the handle to
%      the existing singleton*.
%
%      SUB1SWAVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUB1SWAVE.M with the given input arguments.
%
%      SUB1SWAVE('Property','Value',...) creates a new SUB1SWAVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sub1Swave_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Sub1Swave_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Sub1Swave

% Last Modified by GUIDE v2.5 31-Oct-2012 00:23:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Sub1Swave_OpeningFcn, ...
                   'gui_OutputFcn',  @Sub1Swave_OutputFcn, ...
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


% --- Executes just before Sub1Swave is made visible.
function Sub1Swave_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sub1Swave (see VARARGIN)

%  �������1Ϊ���h���˴�Ϊ������figure�ľ����
h=varargin{1};
%  ����guihandles�������h�������handles�ṹ�塣
handles.MainHandles=guihandles(h);
%  ���½ṹ�塣
guidata(hObject,handles);

% Choose default command line output for Sub1Swave
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Sub1Swave wait for user response (see UIRESUME)
% uiwait(handles.figure2);


% --- Outputs from this function are returned to the command line.
function varargout = Sub1Swave_OutputFcn(hObject, eventdata, handles) 
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
h=getframe(handles.figure2);
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
printpreview(handles.figure2);


% --------------------------------------------------------------------
function Print_Callback(hObject, eventdata, handles)
% hObject    handle to Print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure2);


% --------------------------------------------------------------------
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Integ_Callback(hObject, eventdata, handles)
% hObject    handle to Integ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MainHandles=handles.MainHandles;
%  ���������uipanel1�ж�ȡintcpttime��EWdata��NSdata��
intcpttime=getappdata(MainHandles.uipanel1,'intcpttime');
EWdata=getappdata(MainHandles.uipanel1,'EWdata');
NSdata=getappdata(MainHandles.uipanel1,'NSdata');
%  ���������㡣
delta=intcpttime(2)-intcpttime(1);
EWdata=TrapInt(EWdata,delta);
NSdata=TrapInt(NSdata,delta);
%  ���»�ͼ��
axes(handles.axes1);
plot(intcpttime,EWdata);
grid on;                                                             
axes(handles.axes2);
plot(intcpttime,NSdata);
grid on;                     
%  �����º�����ݴ���������uipanel1��
setappdata(MainHandles.uipanel1,'EWdata',EWdata);
setappdata(MainHandles.uipanel1,'NSdata',NSdata);


% --------------------------------------------------------------------
function Differet_Callback(hObject, eventdata, handles)
% hObject    handle to Differet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MainHandles=handles.MainHandles;
%  ���������uipanel1�ж�ȡintcpttime��EWdata��NSdata��
intcpttime=getappdata(MainHandles.uipanel1,'intcpttime');
EWdata=getappdata(MainHandles.uipanel1,'EWdata');
NSdata=getappdata(MainHandles.uipanel1,'NSdata');
%  ���������㡣
delta=intcpttime(2)-intcpttime(1);
EWdata=Deriva(intcpttime,EWdata,delta);
NSdata=Deriva(intcpttime,NSdata,delta);
%  ���»�ͼ��
axes(handles.axes1);
plot(intcpttime,EWdata);
grid on;                                                             
axes(handles.axes2);
plot(intcpttime,NSdata);
grid on;                     
%  �����º�����ݴ���������uipanel1��
setappdata(MainHandles.uipanel1,'EWdata',EWdata);
setappdata(MainHandles.uipanel1,'NSdata',NSdata);


% --- Executes on mouse motion over figure - except title and menu.
function figure2_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ���㵱ǰ����ϵx�ᡢy������귶Χ��
xmin=min(get(gca,'XLim'));  
xmax=max(get(gca,'XLim'));
ymin=min(get(gca,'YLim'));
ymax=max(get(gca,'YLim'));
pos=mean(get(gca,'CurrentPoint'));      %  ��õ�ǰ�����ꡣ
%  �жϣ�����ǰ�������ڵ�ǰ����ϵ��Χ�ڣ����ҵ�ǰ��������ͼ�����ǿ�����ϵ��ʱ����ͼ����ͼ����ʾ��ǰ������ꡣ
%  ����ͼ���Ĺ��̣�
%  1�����ȴ���һ�����������ͼ����ʾ�������Ӷ���
%  2�������������Ӷ���Ϊ��0��0���㣬�������䲻�ɼ�����ô����Ϊ���ڴ���ͼ��ʱ����2���ַ�����
%  3��ɾ��ͼ���е��ߣ�����ͼ�����ַ��������ݣ�������ʾ��ǰ�����ꡣ
if ((pos(1,1)-xmin)*(xmax-pos(1,1))>0 && (pos(1,2)-ymin)*(ymax-pos(1,2))>0)  
    h_group=hggroup;                                                                                              
    set(get(get(h_group,'Annotation'),'LegendInformation'),'IconDisplayStyle','children');
    line(0,0,'HitTest','off','Parent',h_group,'Visible','off');
    h_legend=legend(gca,'show');
    delete(findobj(h_legend,'Type','line'));
    h_text=findobj(h_legend,'Type','text');
    set(h_text(1),'Position',[0.1 0.7 0],'String',sprintf('x:%5.2f',pos(1,1)));
    set(h_text(2),'Position',[0.1 0.3 0],'String',sprintf('y:%5.2f',pos(1,2)));
end


% --------------------------------------------------------------------
function righthand_btn_Callback(hObject, eventdata, handles)
% hObject    handle to righthand_btn (see GCBO)
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
function Copy_Callback(hObject, eventdata, handles)
% hObject    handle to Copy (see GCBO)
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


% --- Executes on button press in pushbutton1.
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
MainHandles=handles.MainHandles;
%  ��������uipanel1��������ɾ����
set(MainHandles.edit1,'String','');
set(MainHandles.edit2,'String','');
setappdata(MainHandles.uipanel1,'intcpttime',[]);
setappdata(MainHandles.uipanel1,'EWdata',[]);
setappdata(MainHandles.uipanel1,'NSdata',[]);
%  �ر��ӽ��档
close(gcf);
