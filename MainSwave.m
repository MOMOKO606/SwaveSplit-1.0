function varargout = MainSwave(varargin)
% MAINSWAVE M-file for MainSwave.fig
%      MAINSWAVE, by itself, creates a new MAINSWAVE or raises the existing
%      singleton*.
%
%      H = MAINSWAVE returns the handle to a new MAINSWAVE or the handle to
%      the existing singleton*.
%
%      MAINSWAVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINSWAVE.M with the given input arguments.
%
%      MAINSWAVE('Property','Value',...) creates a new MAINSWAVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainSwave_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainSwave_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainSwave

% Last Modified by GUIDE v2.5 24-May-2013 17:44:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainSwave_OpeningFcn, ...
                   'gui_OutputFcn',  @MainSwave_OutputFcn, ...
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


% --- Executes just before MainSwave is made visible.
function MainSwave_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainSwave (see VARARGIN)

% Choose default command line output for MainSwave
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainSwave wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%  ���´��������Ϊ�޸�GUI���Ͻ�ͼ�ꡣ
%newIcon=javax.swing.ImageIcon('sample.jpg');
%figFrame=get(handles.figure1,'JavaFrame');  %  ȡ��Figure��JavaFrame��
%figFrame.setFigureIcon(newIcon); %  �޸�ͼ��


% --- Outputs from this function are returned to the command line.
function varargout = MainSwave_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

pltn1=0;  %  pltn1��ʾ��ǰ��ͼ�������Ĳ�����GUI����ʱ����ֵΪ0��
setappdata(0,'pltn1',pltn1);  %  ��pltn1����Ϊȫ�ֱ�����
%  report_index�Ǳ�ʾ������������ʽ�Ĳ�����
%  ��report_index=0ʱ��Ĭ��ֵ������ʾ�������ɽ�����棻
%  ��report_index=1ʱ����ʾ����ν�����������ͬһ��word�ĵ��С�
%  ͬ��location_index�Ǳ�ʾ���ɽ���ռ�ֲ�ͼ��ʽ�Ĳ�����
%  ��location_index=0ʱ��Ĭ��ֵ������ʾ�������ɽ���ռ�ֲ�ͼ��
%  ��location_index=1ʱ����ʾ�ö�ν������һ������ռ�ֲ�ͼ��
%  ͬ��OutputReport_index�Ǳ�ʾ�Ƿ�����������Ĳ�����
%  ��OutputReport=1ʱ��Ĭ��ֵ������ʾ���������棻
%  ��OutputReport=-1ʱ����ʾ�����������档
setappdata(0,'report_index',0);
setappdata(0,'location_index',0);
setappdata(0,'OutputReport_index',1);
%  reptdata1��reptdata2Ϊ����ռ�ֲ�ͼ��ͼ������
%  ����Ĭ�ϵ������ɽ���ռ�ֲ�ͼ�����ȸ���ֵ��
setappdata(0,'reptdata1',[]);
setappdata(0,'reptdata2',[]);
%  Ϊpath1��path2��path3����ֵ����ֵΪ��ǰ·����
%  path1��ʾ���ļ�·����
%  path2��ʾ�����������·����
%  path3��ʾ�ļ��洢·����
setappdata(0,'path1',pwd);
setappdata(0,'path2',pwd);
setappdata(0,'path3',pwd);


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡȫ�ֱ���pltn1��ֵ��pltn1ΪĿǰ�Ѿ��򿪵ĵ�����ͼ��Ŀ��  
pltn1=getappdata(0,'pltn1');
%  ����ͼ����С��3ʱ�����򿪡����ܿ�ʹ��
if (pltn1 < 3)
    set(handles.Open,'enable','on');
else
    set(handles.Open,'enable','off');
end
%  �����ڴ򿪵ĵ�����ͼʱ�������桱�����رա��ȹ��ܿ����������ܹرա�
if (pltn1 == 0)
    set(handles.Close,'enable','off');
    set(handles.Closeall,'enable','off');
    set(handles.Savepic,'enable','off');
    set(handles.Savedata,'enable','off');
else
    set(handles.Close,'enable','on');
    set(handles.Closeall,'enable','on');
    set(handles.Savepic,'enable','on');
    set(handles.Savedata,'enable','on');
end


% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰ���õĴ��ļ�·����
DefaultPath=getappdata(0,'path1');
%  �����ܳ��ֵ�6��axes��Positionֵ����axespos�У�axesposΪcell����
axespos(1,1)={[0.041,0.271,0.755,0.498]};
axespos(2,1)={[0.041,0.573,0.755,0.349;0.041,0.113,0.755,0.349]};
axespos(3,1)={[0.041,0.711,0.755,0.23;0.041,0.386,0.755,0.23;0.041,0.06,0.755,0.23]};
%  ��ȡȫ�ֱ���pltn1��ֵ��pltn1ΪĿǰ�Ѿ��򿪵ĵ�����ͼ��Ŀ��
pltn1=getappdata(0,'pltn1');
%  ����һ�����ļ��Ի���
[FileName,PathName]=uigetfile(...
{'*.SAC','SAC Files(*.SAC)';'*.txt','ASCII Data(*.txt)';...
 '*.dat','Golden Software Data(*.dat)';'*.*','All Files(*.*)'},...
 'ѡ���ļ�',DefaultPath,'MultiSelect','on');
%  ���û��ڶԻ����е����ȡ����ʱ��Open_Callbackֹͣ��
if ((iscellstr(FileName) == 0) & (FileName == 0))
    return
end
[inputfile,pltn2,pltn3]=Get_Pltn2(handles,pltn1,PathName,FileName);
if (pltn3 > 3)
    errordlg('����ͬʱ��3�ŵ�����ͼ��','������ʾ');
    return
end
%  ͨ��ChekAxes�����õ���ͼƬ��axes�Լ���axes�ľ����
[hocupd,hfree]=ChekAxes(handles);
%  ��������ͼƬ���Լ���Ҫ��ͼƬ��������axes�ĳߴ��λ�ñ仯��
%  1����������ͼ�ε�axes�ĳߴ��λ�ã�
for i=1:pltn1
    set(hocupd(i),'Units','normalized','Visible','on','Position',axespos{pltn3,1}(i,:));
end
%  2������Ҫ���ƵĲ���ͼ����axes��������Щaxes�ĳߴ��λ�ã�����ͼ��
for i=1:pltn2
    set(hfree(i),'Units','normalized','Position',axespos{pltn3,1}(pltn1+i,:));  %  ����axes�ĳߴ��λ��
    %  ��ȡ���ݡ�
    filename=inputfile{1,pltn2+1-i};  %  pltn2+1-i��Ϊ������ѡ������ͼƬ��ʾ�����档
    type_index=strcmpi(filename(end-3:end),'.SAC');
    if (type_index == 1)
        [hd,stime,sdata]=rdSac(filename);  
    else
        sdata=getappdata(handles.Open,filename);  %  ����sdata
        delta_temp=inputdlg_fix('������ASCII��ʽ�������ݵĲ������(s)��','������ʾ',1);
        if (isempty(delta_temp) ~= 1 )
            delta=str2num(cell2mat(delta_temp));  %  �Ƚ�cellת��Ϊ��ͨ�����ַ��������ٽ�deltaת��Ϊdouble��
        else
            delta=0.025;  %  ���û�ѡ��ȡ����û������������ֵʱ��ϵͳĬ�ϲ������Ϊ0.025s��
        end
        n=length(sdata);
        stime=[0:delta:(n-1)*delta];  %  ����stime
        t=[delta;zeros(78,1);n;zeros(20,1)];
        hd=cell(25,1);
        hd{1,1}=t;  %  ����hd
    end
    SacPlot(hfree(i),hd,stime,sdata);
    set(hfree(i),'Visible','on');  %  ��ͼ��ɺ���ʾaxes
end
%  3�����ÿ�axesΪ���ɼ���
temp=length(hfree)-pltn2;
for i=1:temp
    set(hfree(pltn2+i),'Visible','off');
end
%  ����pltn1��ֵ������Ϊȫ�ֱ�����
pltn1=pltn3;
setappdata(0,'pltn1',pltn1);
%  ���´��ļ�·����
setappdata(0,'path1',PathName);


% --------------------------------------------------------------------
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ���Ҽ��˵��С������ͼ�񡱹�����ͬ��
removeplot_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function Closeall_Callback(hObject, eventdata, handles)
% hObject    handle to Closeall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  �������axes�ϵ�ͼ�����ݡ�
for i=1:3
    str=['handles.axes',num2str(i)];
    eval(['h=',str,';']);
    cla(h,'reset');
    set(h,'Visible','off');
end
%  ��pltn1�ָ�Ϊ��ʼֵ0��
setappdata(0,'pltn1',0);  
%  ��EWindex��EWtemp��hEW�ָ�Ϊ��ʼֵ��
setappdata(0,'EWindex',0);
setappdata(0,'EWtemp',-1);
setappdata(0,'hEW',[]);
set(handles.ChooseEW,'Checked','off');
%  ��NSindex��NStemp��hNS�ָ�Ϊ��ʼֵ��
setappdata(0,'NSindex',0);
setappdata(0,'NStemp',-1);
setappdata(0,'hNS',[]);
set(handles.ChooseNS,'Checked','off');


% --------------------------------------------------------------------
function Savepic_Callback(hObject, eventdata, handles)
% hObject    handle to Savepic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰ���õĴ洢�ļ�·����
str=getappdata(0,'path3');
DefaultPath=[str,'\untitled.fig'];
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
 'ͼƬ���Ϊ',DefaultPath);
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
%  ���´洢�ļ�·����
setappdata(0,'path3',PathName);


% --------------------------------------------------------------------
function Savedata_Callback(hObject, eventdata, handles)
% hObject    handle to Savedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰ���õĴ洢�ļ�·����
str=getappdata(0,'path3');
DefaultPath=[str,'\untitled.dat'];
%  ��ȡ��ǰͼ���еķ�ֵ���ݡ�
sdata=getappdata(gca,'sdata');
%  ����һ���ļ�����Ի���
[FileName,PathName]=uiputfile(...
{'*.dat','Golden Software Data(*.dat)';...
 '*.txt','ASCII Data(*.txt)';'*.*','All Files(*.*)'},...
 '�ļ����Ϊ',DefaultPath);
if (FileName == 0)
    %  ���û������ȡ����ʱ��������ֹ��
    return
else
    dlmwrite(fullfile(PathName,FileName),sdata);
end
%  ���´洢�ļ�·����
setappdata(0,'path3',PathName);


% --------------------------------------------------------------------
function Saveall_Callback(hObject, eventdata, handles)
% hObject    handle to Saveall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰ���õĴ洢�ļ�·����
str=getappdata(0,'path3');
DefaultPath=[str,'\untitled.jpg'];
%  ��ȡGUI��ܣ��൱�ڽ�ͼ����
h=getframe(handles.figure1);
%  ����ȡ�Ŀ��ת��Ϊͼ��
h=frame2im(h);
%  ����һ���ļ�����Ի���
[FileName,PathName]=uiputfile(...
{'*.jpg','JPEG image(*.jpg)';'*.bmp','Bitmap file(*.bmp)';...
 '*.tif','TIFF image(*.tif)';'*.*','All Files(*.*)'},...
 'ͼƬ���Ϊ',DefaultPath);
if (FileName == 0)
    %  ���û������ȡ����ʱ���ر��½�figure��������ֹ��
    return
else
    imwrite(h,fullfile(PathName,FileName));
end
%  ���´洢�ļ�·����
setappdata(0,'path3',PathName);


% --------------------------------------------------------------------
function PrintView_Callback(hObject, eventdata, handles)
% hObject    handle to PrintView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printpreview(handles.figure1);


% --------------------------------------------------------------------
function Print_Callback(hObject, eventdata, handles)
% hObject    handle to Print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1);


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


% --------------------------------------------------------------------
function process_Callback(hObject, eventdata, handles)
% hObject    handle to process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡȫ�ֱ���pltn1��ֵ��pltn1ΪĿǰ�Ѿ��򿪵ĵ�����ͼ��Ŀ��  
pltn1=getappdata(0,'pltn1');
%  ��ȡȫ�ֱ���hEW��hNS��
hEW=getappdata(0,'hEW');
hNS=getappdata(0,'hNS');
%  �����ڴ򿪵ĵ�����ͼʱ����Ԥ�������ܿ����������ܹرա�
if (pltn1 == 0)
    set(handles.Remv_Iresponse,'enable','off');
    set(handles.Remvzd,'enable','off');
    set(handles.Remvld,'enable','off');
    set(handles.Input_EventLatLon,'enable','off');
else
    set(handles.Remv_Iresponse,'enable','on');
    set(handles.Remvzd,'enable','on');
    set(handles.Remvld,'enable','on');
    set(handles.Input_EventLatLon,'enable','on');
end
%  ���б�ѡΪ��EW���͡�NS���ķ���ʱ����ͳһʱ�䡱���ܿ����������ܹرա�
if ((isempty(hEW) == 0) && (isempty(hNS) == 0))
    set(handles.Sametime,'enable','on');
else
    set(handles.Sametime,'enable','off');
end


% --------------------------------------------------------------------
function Remv_Iresponse_Callback(hObject, eventdata, handles)
% hObject    handle to Remv_Iresponse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function rough_Callback(hObject, eventdata, handles)
% hObject    handle to rough (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰaxes�ϵĲ������ݡ�
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
sdata=getappdata(gca,'sdata');
hd=getappdata(gca,'hd');
scale=hd{1,1}(4,1);  %  �õ��Ŵ���
%  �趨����Ի���Ĭ��ֵ��
if ((scale == 0) || (scale == -12345) )
    defAns={''};
else
    scale=1/(scale*10^-6);  %  ת���������ȣ���λ��m per (A/D)
    defAns={num2str(scale)};
end
scale=inputdlg_fix('������������(��m per count):','������ʾ',1,defAns,'on');
%  ѡ��ȡ��ʱ����������
if (isempty(scale) == 1)
    return
end
scale=str2num(cell2mat(scale));  %  �Ƚ�cellת��Ϊ��ͨ�����ַ��������ٽ�scaleת��Ϊdouble��
%  ȥ��������Ӧ
sdata=sdata*scale;
set(hplot,'YData',sdata);
%  �����º��ͼ�Σ��������±��浽��ǰaxes��Application Data��
setappdata(gca,'sdata',sdata);


% --------------------------------------------------------------------
function precise_Callback(hObject, eventdata, handles)
% hObject    handle to precise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰaxes�ϵĲ������ݡ�
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
delta=clcu_info(2);
sdata=getappdata(gca,'sdata');
%  ����һ�������ļ���ʽ��ʾ��
FormatHint;   
%  ����һ�����ļ��Ի���
[FileName,PathName]=uigetfile({'*.txt','ASCII Data(*.txt)'},'ѡ���ļ�');
if (FileName == 0)
    return
else
    ResFile=[PathName,FileName];
end
%  ����������Ӧ�����ݺ�������
sdata=RemvTransf(ResFile,delta,sdata);
%  ����ͼ�Σ��������±��浽��ǰaxes��Application Data��
set(hplot,'YData',sdata);
setappdata(gca,'sdata',sdata);


% --------------------------------------------------------------------
function Remvzd_Callback(hObject, eventdata, handles)
% hObject    handle to Remvzd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰaxes�ϵĲ������ݡ�
sdata=getappdata(gca,'sdata');
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
clcu_info(3)=clcu_info(3)+1;
%  ȥ�����Ư�ơ�
sdata=dtrend(sdata);
set(hplot,'YData',sdata);
%  �����º��ͼ�Σ��������±��浽��ǰaxes��Application Data��
setappdata(gca,'sdata',sdata);
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function Remvld_Callback(hObject, eventdata, handles)
% hObject    handle to Remvld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰaxes�ϵĲ������ݡ�
sdata=getappdata(gca,'sdata');
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
clcu_info(4)=clcu_info(4)+1;
%  ȥ������Ư�ơ�
sdata=dtrend(sdata,1);
set(hplot,'YData',sdata);
%  �����º��ͼ�Σ��������±��浽��ǰaxes��Application Data��
setappdata(gca,'sdata',sdata);
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function Input_EventLatLon_Callback(hObject, eventdata, handles)
% hObject    handle to Input_EventLatLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰaxes�ϵĲ������ݡ�
hd=getappdata(gca,'hd');
%  ��������Ի��򣬵����¼����о��ȡ������¼�����γ�ȡ�
prompt={'�����¼����о���(��)��','�����¼�����γ��(��)��'};
dlg_title='�ֶ�����õ�����ͼ��Ӧ���¼���γ��';
answer=inputdlg_fix(prompt,dlg_title,1);
if (isempty(answer) == 1)
    return
end
hd{1,1}(36,1)=str2num(char(answer(1,1)));  %  Event latitude (degrees, north positive). 
hd{1,1}(37,1)=str2num(char(answer(2,1)));  %  Event longitude (degrees, east positive). 
%  �����º���������±��浽��ǰaxes��Application Data��
setappdata(gca,'hd',hd);


% --------------------------------------------------------------------
function Sametime_Callback(hObject, eventdata, handles)
% hObject    handle to Sametime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Get_SameTime;


% --------------------------------------------------------------------
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡȫ�ֱ���pltn1��ֵ��pltn1ΪĿǰ�Ѿ��򿪵ĵ�����ͼ��Ŀ��  
pltn1=getappdata(0,'pltn1');
%  �����ڴ򿪵ĵ�����ͼʱ�������㡱���ܿ����������ܹرա�
if (pltn1 == 0)
    set(handles.Integ,'enable','off');
    set(handles.Differet,'enable','off');
    set(handles.filter,'enable','off');
    set(handles.SigNois_Ratio,'enable','off');
    set(handles.epcentldis,'enable','off');
    set(handles.azimuth,'enable','off');
    set(handles.bkazimuth,'enable','off');
    set(handles.offsource,'enable','off');
else
    set(handles.Integ,'enable','on');
    set(handles.Differet,'enable','on');
    set(handles.filter,'enable','on');
    set(handles.SigNois_Ratio,'enable','on');
    set(handles.epcentldis,'enable','on');
    set(handles.azimuth,'enable','on');
    set(handles.bkazimuth,'enable','on');
    set(handles.offsource,'enable','on');
end


% --------------------------------------------------------------------
function Integ_Callback(hObject, eventdata, handles)
% hObject    handle to Integ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰͼ���л������������
sdata=getappdata(gca,'sdata');
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
delta=clcu_info(2);
clcu_info(5)=clcu_info(5)+1;
%  ���λ��ֲ�����ͼ�Ρ�
sdata=TrapInt(sdata,delta);
set(hplot,'YData',sdata);
%  �����º��ͼ�Σ��������±��浽��ǰaxes��Application Data��
setappdata(gca,'sdata',sdata);
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function Differet_Callback(hObject, eventdata, handles)
% hObject    handle to Differet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰͼ���л������������
stime=getappdata(gca,'stime');
sdata=getappdata(gca,'sdata');
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
delta=clcu_info(2);
clcu_info(6)=clcu_info(6)+1;
%  ���λ��ֲ�����ͼ�Ρ�
sdata=Deriva(stime,sdata,delta);
set(hplot,'YData',sdata);
%  �����º��ͼ�Σ��������±��浽��ǰaxes��Application Data��
setappdata(gca,'sdata',sdata);
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function filter_Callback(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰͼ���е�sdata��hplot��
sdata=getappdata(gca,'sdata');
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
%  �õ��û�������˲�Ƶ�ʷ�Χ��
answer=FreqRange;
if (isempty(answer) == 1)
    return
end
f1=char(answer(1,1));
f2=char(answer(2,1));
f1=str2num(f1)*pi/180;
f2=str2num(f2)*pi/180;
%  �˲�������ͼ�Ρ�
sdata=idfilt(sdata,5,[f1 f2]);
set(hplot,'YData',sdata);
%  ������º��sdata���ݵ���ǰaxes��Application Data��
setappdata(gca,'sdata',sdata);


% --------------------------------------------------------------------
function SigNois_Ratio_Callback(hObject, eventdata, handles)
% hObject    handle to SigNois_Ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ���뵱ǰͼ��Ĳ�����Ϣ��
clcu_info=getappdata(gca,'clcu_info');
sdata=getappdata(gca,'sdata');
%  �õ���ǰͼ����������
delta=round(clcu_info(2)*1000000)/1000000;  % ����6λ��Ч����
%  ��������Ի��������źſ�ʼ����ֹʱ�䡣
prompt={'�ź���ʼʱ��(s)��','�źŽ�ֹʱ��(s)��'};
dlg_title='���������';
answer=inputdlg_fix(prompt,dlg_title,1);
%  �õ��û�������źŷ�Χ��
if (isempty(answer) == 1)  %  ���û�ѡ��ȡ��ʱ��������ֹ��
    return  
end
time1=str2num(char(answer(1,1)));
time2=str2num(char(answer(2,1)));
%  �ж��û�����������Ƿ����Ҫ��
if (mod(time1,delta) ~= 0)
    errordlg(['��ʼʱ��Ӧ��Ϊ�������',num2str(delta),'�ı��������������룡'],'������ʾ');
    return
elseif (mod(time2,delta) ~= 0)
    errordlg(['��ֹʱ��Ӧ��Ϊ�������',num2str(delta),'�ı��������������룡'],'������ʾ');
    return
end
t1=time1/delta+1;
t2=time2/delta+1;
sig=sdata(t1:t2);
nois=sdata(1:t1-1);
ps=sqrt(sum((sig.^2))/(t2-t1+1));
pn=sqrt(sum((nois.^2))/(t1-1));
%  ��������ȡ�
snr=10*log10(ps/pn);  
clcu_info(11)=snr;
%  ���µ�ǰaxes��Application Data��
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function epcentldis_Callback(hObject, eventdata, handles)
% hObject    handle to epcentldis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��Ӧ�������õĲ�����
hd=getappdata(gca,'hd');
clcu_info=getappdata(gca,'clcu_info');
%  �����Ѿ���������о�������ֹ���������¼��㡣
if (isnan(clcu_info(7)) == 0 )
    return
end
%  ���ļ�ͷ�ж�ȡ���о࣬�������ݴ������ټ��㣻
DIST=hd{1,1}(51,1);
if (DIST ~= -12345 && DIST ~= 0)
    clcu_info(7)=DIST;
else
    %  ���ļ�ͷ�в��������о�����ʱ��ͨ��̨վ�����еľ�γ�������㣻
    STLA=hd{1,1}(32,1);    %  Station latitude (degrees, north positive).
    STLO=hd{1,1}(33,1);    %  Station longitude (degrees, east positive).
    EVLA=hd{1,1}(36,1);    %  Event latitude (degrees, north positive). 
    EVLO=hd{1,1}(37,1);    %  Event longitude (degrees, east positive). 
    %  ��̨վ�����о�γ������ȱʧʱ��������ֹ��
    if ((STLA == 0 && STLO == 0 && EVLA ==0 && EVLO ==0) || (STLA == -12345 && STLO == -12345 && EVLA ==-12345 && EVLO ==-12345))
        errordlg('̨վ�����о�γ������ȱʧ���޷����㣡','������ʾ');
        return
    end
    slo=STLO*pi/180;  %  ̨վ���ȣ�ת��Ϊ���ȣ�
    sla=LatiTrans(STLA);  %  ̨վ������γ��
    elo=EVLO*pi/180;  %  ���о��ȣ�ת��Ϊ���ȣ�
    ela=LatiTrans(EVLA);  %  ���е�����γ��
    %  �������о�(Epicentral distance)��
    t=acos(cos(ela)*cos(sla)+sin(ela)*sin(sla)*cos(elo-slo));
    clcu_info(7)=t*180*111.12/pi; %  ��λΪǧ��
end
%  ���µ�ǰaxes��Application Data��
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function azimuth_Callback(hObject, eventdata, handles)
% hObject    handle to azimuth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��Ӧ�������õĲ�����
hd=getappdata(gca,'hd');
clcu_info=getappdata(gca,'clcu_info');
%  �����Ѿ��������λ��������ֹ���������¼��㡣
if (isnan(clcu_info(8)) == 0 )
    return
end
%  ���ļ�ͷ�ж�ȡ��λ�ǣ��������ݴ������ټ��㣻
AZ=hd{1,1}(52,1);
if (AZ ~= -12345 && AZ ~= 0)
    clcu_info(8)=AZ;
else
    %  ���ļ�ͷ�в����ڷ�λ������ʱ��ͨ��̨վ�����еľ�γ�������㣻
    STLA=hd{1,1}(32,1);    %  Station latitude (degrees, north positive).
    STLO=hd{1,1}(33,1);    %  Station longitude (degrees, east positive).
    EVLA=hd{1,1}(36,1);    %  Event latitude (degrees, north positive). 
    EVLO=hd{1,1}(37,1);    %  Event longitude (degrees, east positive). 
    %  ��̨վ�����о�γ������ȱʧʱ��������ֹ��
    if ((STLA == 0 && STLO == 0 && EVLA ==0 && EVLO ==0) || (STLA == -12345 && STLO == -12345 && EVLA ==-12345 && EVLO ==-12345))
        errordlg('̨վ�����о�γ������ȱʧ���޷����㣡','������ʾ');
        return
    end
    %  ���㷽λ�ǣ�̨վ��������еķ�λ�ǣ���
    clcu_info(8)=Azim(STLO,STLA,EVLO,EVLA);
end
%  ���µ�ǰaxes��Application Data��
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function bkazimuth_Callback(hObject, eventdata, handles)
% hObject    handle to bkazimuth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��Ӧ�������õĲ�����
hd=getappdata(gca,'hd');
clcu_info=getappdata(gca,'clcu_info');
%  �����Ѿ����������λ��������ֹ���������¼��㡣
if (isnan(clcu_info(9)) == 0 )
    return
end
%  ���ļ�ͷ�ж�ȡ����λ�ǣ��������ݴ������ټ��㣻
BAZ=hd{1,1}(53,1);
if (BAZ ~= -12345 && BAZ ~= 0)
    clcu_info(9)=BAZ;
else
    %  ���ļ�ͷ�в����ڷ�λ������ʱ��ͨ��̨վ�����еľ�γ�������㣻
    STLA=hd{1,1}(32,1);    %  Station latitude (degrees, north positive).
    STLO=hd{1,1}(33,1);    %  Station longitude (degrees, east positive).
    EVLA=hd{1,1}(36,1);    %  Event latitude (degrees, north positive). 
    EVLO=hd{1,1}(37,1);    %  Event longitude (degrees, east positive). 
    %  ��̨վ�����о�γ������ȱʧʱ��������ֹ��
    if ((STLA == 0 && STLO == 0 && EVLA ==0 && EVLO ==0) || (STLA == -12345 && STLO == -12345 && EVLA ==-12345 && EVLO ==-12345))
        errordlg('̨վ�����о�γ������ȱʧ���޷����㣡','������ʾ');
        return
    end
    %  ���㷴��λ�ǣ��൱�����������̨վ�ķ�λ�ǣ���
    clcu_info(9)=Azim(EVLO,EVLA,STLO,STLA);
end
%  ���µ�ǰaxes��Application Data��
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function offsource_Callback(hObject, eventdata, handles)
% hObject    handle to offsource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��Ӧ�������õĲ�����
hd=getappdata(gca,'hd');
clcu_info=getappdata(gca,'clcu_info');
%  �����Ѿ��������Դ��������ֹ���������¼��㡣
if (isnan(clcu_info(10)) == 0 )
    return
end
%  ��ȡ̨վ�����о�γ�����ݡ�
STLA=hd{1,1}(32,1);    %  Station latitude (degrees, north positive).
STLO=hd{1,1}(33,1);    %  Station longitude (degrees, east positive).
EVLA=hd{1,1}(36,1);    %  Event latitude (degrees, north positive). 
EVLO=hd{1,1}(37,1);    %  Event longitude (degrees, east positive). 
%  ��ȡ��Դ������ݡ�
EVDP=hd{1,1}(39,1);
%  ����Դ�������ȱʧʱ��������ֹ��
if (EVDP == 0 || EVDP == -12345)
    errordlg('��Դ�������ȱʧ���޷����㣡','������ʾ');
    return
end
slo=STLO*pi/180;  %  ̨վ���ȣ�ת��Ϊ���ȣ�
sla=LatiTrans(STLA);  %  ̨վ������γ��
elo=EVLO*pi/180;  %  ���о��ȣ�ת��Ϊ���ȣ�
ela=LatiTrans(EVLA);  %  ���е�����γ��
%  �������о�(Epicentral distance)��
t=acos(cos(ela)*cos(sla)+sin(ela)*sin(sla)*cos(elo-slo));
epc_dis=t*180*111.12/pi; %  ��λΪǧ��
%  ������Դ�ǣ�ֱ��P������Դ�ǣ���
deg=atan(epc_dis*1000/EVDP);
clcu_info(10)=deg*180/pi;
%  �����Შ����ʶ����ֵ��
if (epc_dis >= 1000)
    clcu_info(12)=1;
else
    if (clcu_info(10) >= 45)
        clcu_info(12)=1;
    else
        clcu_info(12)=2;
    end
end
%  ���µ�ǰaxes��Application Data��
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function Setting_Callback(hObject, eventdata, handles)
% hObject    handle to Setting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Output_Report_Callback(hObject, eventdata, handles)
% hObject    handle to Output_Report (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡȫ�ֱ���OutputReport_index��
OutputReport_index=getappdata(0,'OutputReport_index');
%  ����OutputReport_index�ж��Ƿ�ѡ�У���ʵ����Ӧ�Ĺ��ܡ�
OutputReport_index=OutputReport_index*-1;
if (OutputReport_index == 1)
    set(handles.Output_Report,'Checked','on');
else
    set(handles.Output_Report,'Checked','off');
end
%  ����ȫ�ֱ���OutputReport_index��
setappdata(0,'OutputReport_index',OutputReport_index);


% --------------------------------------------------------------------
function RptPath_Callback(hObject, eventdata, handles)
% hObject    handle to RptPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ǰ���õ����·����
path=getappdata(0,'path2');
%  ����һ��Ŀ¼ѡ��Ի���Ĭ��·��Ϊ��ǰ·����
str=uigetdir(path,'��ѡ��·��');
%  ���û����ȡ��ʱ������������
if (str == 0)
    return
else
    path=str;
end
%  ����·����
setappdata(0,'path2',path);


% --------------------------------------------------------------------
function ReportSeparated_Callback(hObject, eventdata, handles)
% hObject    handle to ReportSeparated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'report_index',0);
set(handles.ReportSeparated,'Checked','on');
set(handles.ReportCumulated,'Checked','off');


% --------------------------------------------------------------------
function ReportCumulated_Callback(hObject, eventdata, handles)
% hObject    handle to ReportCumulated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'report_index',1);
set(handles.ReportSeparated,'Checked','off');
set(handles.ReportCumulated,'Checked','on');


% --------------------------------------------------------------------
function LocationSeparated_Callback(hObject, eventdata, handles)
% hObject    handle to LocationSeparated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'location_index',0);
setappdata(0,'reptdata1',[]);
setappdata(0,'reptdata2',[]);
set(handles.LocationSeparated,'Checked','on');
set(handles.LocationCumulated,'Checked','off');


% --------------------------------------------------------------------
function LocationCumulated_Callback(hObject, eventdata, handles)
% hObject    handle to LocationCumulated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'location_index',1);
set(handles.LocationSeparated,'Checked','off');
set(handles.LocationCumulated,'Checked','on');


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function help1_Callback(hObject, eventdata, handles)
% hObject    handle to help1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ����������ĵ���
!SwaveSplit�����ĵ�.chm;


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AboutInfo;


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
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
if ((pos(1,1)-xmin)*(xmax-pos(1,1))>0 && (pos(1,2)-ymin)*(ymax-pos(1,2))>0 && isempty(get(gca,'children'))~=1)  
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

%  ��ȡ����EWindex��NSindex��hEW��hNS��
EWindex=getappdata(0,'EWindex');
NSindex=getappdata(0,'NSindex');
hEW=getappdata(0,'hEW');
hNS=getappdata(0,'hNS');
%  �������ϲ��������Ҽ��˵���
adjstlabl(handles,EWindex,NSindex,hEW,hNS);


% --------------------------------------------------------------------
function View_Info_Callback(hObject, eventdata, handles)
% hObject    handle to View_Info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hd=getappdata(gca,'hd');
clcu_info=getappdata(gca,'clcu_info');
SeisInfo(hd,clcu_info);
   

% --- Executes during object creation, after setting all properties.
function ChooseEW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChooseEW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%  EWindex��������ʾ����ǰͼ���Ƿ�ѡΪ������ط����Ķ��������źŵĲ�����
%  ��EWindex==0ʱ����ʾ��δѡ�С�����EWindex==1ʱ����ʾ��ѡ�С���
%  �����EWindex��EWtemp���������������ֵ������Ϊȫ�ֱ�����
EWindex=0;
EWtemp=-1;
hEW=[];
setappdata(0,'EWindex',EWindex);
setappdata(0,'EWtemp',EWtemp);
setappdata(0,'hEW',hEW);


% --------------------------------------------------------------------
function ChooseEW_Callback(hObject, eventdata, handles)
% hObject    handle to ChooseEW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡEWindex��EWtemp��
EWindex=getappdata(0,'EWindex');
EWtemp=getappdata(0,'EWtemp');
%  ����EWindex�ж��Ƿ�ѡ�У���ʵ����Ӧ�Ĺ��ܡ�
EWtemp=EWtemp*(-1);
EWindex=EWindex+EWtemp;
if (EWindex == 1)
    ylabel(gca,'EW','FontWeight','bold','FontSize',10,'Color','r',...
           'Rotation',[0],'Units','normalized','Position',[-0.0377 0.5 0]);
    set(handles.ChooseEW,'Checked','on');
    hEW=gca;
else
    h=get(gca,'YLabel');
    delete(h);
    set(handles.ChooseEW,'Checked','off');
    hEW=[];
end
%  ����EWindex��EWtemp
setappdata(0,'EWindex',EWindex);
setappdata(0,'EWtemp',EWtemp);
setappdata(0,'hEW',hEW);


% --- Executes during object creation, after setting all properties.
function ChooseNS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChooseNS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%  NSindex��������ʾ����ǰͼ���Ƿ�ѡΪ������ط������ϱ������źŵĲ�����
%  ��NSindex==0ʱ����ʾ��δѡ�С�����NSindex==1ʱ����ʾ��ѡ�С���
%  �����NSindex��NStemp���������������ֵ������Ϊȫ�ֱ�����
NSindex=0;
NStemp=-1;
hNS=[];
setappdata(0,'NSindex',NSindex);
setappdata(0,'NStemp',NStemp);
setappdata(0,'hNS',hNS);


% --------------------------------------------------------------------
function ChooseNS_Callback(hObject, eventdata, handles)
% hObject    handle to ChooseNS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡNSindex��NStemp��
NSindex=getappdata(0,'NSindex');
NStemp=getappdata(0,'NStemp');
%  ����NSindex�ж��Ƿ�ѡ�У���ʵ����Ӧ�Ĺ��ܡ�
NStemp=NStemp*(-1);
NSindex=NSindex+NStemp;
if (NSindex == 1)
    ylabel(gca,'NS','FontWeight','bold','FontSize',10,'Color','r',...
           'Rotation',[0],'Units','normalized','Position',[-0.0377 0.5 0]);
    set(handles.ChooseNS,'Checked','on');
    hNS=gca;
else
    h=get(gca,'YLabel');
    delete(h);
    set(handles.ChooseNS,'Checked','off');
    hNS=[];
end
%  ����NSindex��NStemp��
setappdata(0,'NSindex',NSindex);
setappdata(0,'NStemp',NStemp);
setappdata(0,'hNS',hNS);


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


% --------------------------------------------------------------------
function removeplot_Callback(hObject, eventdata, handles)
% hObject    handle to removeplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ���һ��ͼƬ��ȫ�ֱ���pltn1��1�������´��浽Application Data��
pltn1=getappdata(0,'pltn1');
pltn1=pltn1-1;
setappdata(0,'pltn1',pltn1);
%  ����ͼƬ�����֮ǰ��ѡΪEW��NS������ͼƬ���������Ӧ��indexҲ��֮�ı䡣
Delete_EWNS_Index(handles);
%  ���ͼƬ������axes��Visible���ó�off��
cla(gca,'reset');
set(gca,'Visible','off');
%  ͨ��ChekAxes�����õ���ͼƬ��axes�Լ���axes�ľ����
[hocupd,hfree]=ChekAxes(handles);
switch pltn1
    case 1
        set(hocupd(1),'Position',[0.041 0.271 0.755 0.498]);
    case 2
        temp1=get(hocupd(1),'Position');
        temp2=get(hocupd(2),'Position');
        if (abs(temp1(2)-0.573) < abs(temp2(2)-0.573))
            set(hocupd(1),'Position',[0.041 0.573 0.755 0.349]);
            set(hocupd(2),'Position',[0.041 0.113 0.755 0.349]);
        else
            set(hocupd(2),'Position',[0.041 0.573 0.755 0.349]);
            set(hocupd(1),'Position',[0.041 0.113 0.755 0.349]);
        end
end


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡEW��NS�����ľ���������ʡ�
hEW=getappdata(0,'hEW');
hNS=getappdata(0,'hNS');
%  �ж��Ƿ���ѡ�������ϱ�������
if ((isempty(hEW) == 1) || (isempty(hNS) == 1))
    errordlg('�����Ҽ�ѡ�������ϱ�������','������ʾ');
    return
end
t1=getappdata(hEW,'clcu_info');
t2=getappdata(hNS,'clcu_info');
t1(2)=round(t1(2)*1000000)/1000000;  % ����6λ��Ч����
t2(2)=round(t2(2)*1000000)/1000000;  % ����6λ��Ч����
%  ��ȡ�û�����Ľ�ȡʱ�䡣
st=get(handles.edit1,'String');
st=str2num(st);
ct=get(handles.edit2,'String');
ct=str2num(ct);
%  �ж��û�ѡ��ķ���ͼ������Ľ�ȡʱ���Ƿ����Ҫ��
if (t1(2) ~= t2(2))
    errordlg('EW��NS��������ͼ�Ĳ����ʲ�һ�£�','������ʾ');
    return
else
    delta=t1(2);
    if (mod(st,delta) ~= 0)
        errordlg(['��ʼʱ��Ӧ��Ϊ�������',num2str(delta),'�ı��������������룡'],'������ʾ');
        return
    elseif (mod(ct,delta) ~= 0)
        errordlg(['��ֹʱ��Ӧ��Ϊ�������',num2str(delta),'�ı��������������룡'],'������ʾ');
        return
    end
end
%  ��ȡ��ʱ������Ϊintcpttime;�����������ΪEWdata;�ϱ��������ΪNSdata��
t1=st/delta+1;
t2=ct/delta+1;
intcpttime=[0:delta:(t2-t1)*delta];
EWdata=getappdata(hEW,'sdata');
EWdata=EWdata(t1:t2);
NSdata=getappdata(hNS,'sdata');
NSdata=NSdata(t1:t2);
%  �����ȡ������ݡ�
setappdata(handles.uipanel1,'intcpttime',intcpttime);
setappdata(handles.uipanel1,'EWdata',EWdata);
setappdata(handles.uipanel1,'NSdata',NSdata);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡ��ͼ������
intcpttime=getappdata(handles.uipanel1,'intcpttime');
EWdata=getappdata(handles.uipanel1,'EWdata');
NSdata=getappdata(handles.uipanel1,'NSdata');
%  û�����ȷ�ϡ��Ĵ�����ʾ��
if ( isempty(intcpttime) == 1)
    errordlg('���������ȡʱ�䣬���ȷ�ϣ��ٵ��''��ʾ��ȡ���EW��NS����ͼ''','������ʾ');
    return
end
%  ���ӽ���Sub1Swave��Sub1Swave���������Ϊ�������figure������������Ϊ�������ӽ��棩��figure�����
h=Sub1Swave(handles.figure1);
%  ����guihandles�������h�������handles�ṹ�塣
Sub1Handles=guihandles(h);
%  ���ӽ����axes1�ϻ��ƽ�ȡ��EW���η�����
axes(Sub1Handles.axes1);
plot(intcpttime,EWdata);
grid on;                                                             
%  ���ӽ����axes2�ϻ��ƽ�ȡ��NS���η�����
axes(Sub1Handles.axes2);
plot(intcpttime,NSdata);
grid on;          
%  �������ݣ�������ͼ�ķ�ֵ�ֱ�浽��Ӧ����ϵ�С�
setappdata(Sub1Handles.axes1,'Y',EWdata);
setappdata(Sub1Handles.axes2,'Y',NSdata);


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


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  ��ȡȫ�ֱ���OutputReport_index��
OutputReport_index=getappdata(0,'OutputReport_index');
%  ����EWdata��NSdata���ݡ�
EWdata=getappdata(handles.uipanel1,'EWdata');
NSdata=getappdata(handles.uipanel1,'NSdata');
%  ��������������ȡ6λ��Ч���֡�
hEW=getappdata(0,'hEW');
%  �ж��Ƿ���ѡ�������ϱ�������
if (isempty(hEW) == 1)
    errordlg('�����Ҽ�ѡ�������ϱ�������','������ʾ');
    return
end
temp=getappdata(hEW,'clcu_info');
temp(2)=round(temp(2)*1000000)/1000000;  %  ȡ6λ��Ч����
delta=temp(2);
%  ��ȡ�û��������ת�Ƕȡ�ʱ���ӳٲ��������ж��Ƿ���á�
[ds,dsl,df]=Get_RotatAngle(handles);
if ((isempty(ds) == 1)||(isempty(dsl) == 1)||(isempty(df) == 1))
    errordlg('��ת�ǶȲ�����������','������ʾ');
    return
end
[ts,tsl,tf]=Get_DelayTime(handles);
if ((isempty(ts) == 1)||(isempty(tsl) == 1)||(isempty(tf) == 1))
    errordlg('ʱ���ӳٲ�����������','������ʾ');
    return
end
%  ��ʱ�����ת��Ϊ��Ӧ�������š�
t1=ts/delta;
t2=tf/delta;
t3=tsl/delta;
if (mod(ts,delta) ~= 0)||(mod(tf,delta) ~= 0)||(mod(tsl,delta) ~= 0)
    errordlg(['ʱ���ӳ�Ӧ��Ϊ�������',num2str(delta),'�ı��������������룡'],'������ʾ');
    return
end
%  �������ֵ��
[c,cmax,cmin]=Correlation(EWdata,NSdata,ds,dsl,df,t1,t2,t3);
x=[ds:dsl:df];
y=[ts:tsl:tf];
%  ����������ֵ�Լ����Ӧ����ת�Ƕȡ�ʱ���ӳ١�
c=round(c*1e14)/1e14;  % �����ֵȡ14λ��Ч����
maxcoef=max(max(abs(c)));
[i,j]=find(c == maxcoef);
maxt=ts+(i(1)-1)*tsl;
maxd=ds+(j(1)-1)*dsl;
if (maxt < 0)
    bianlong=maxd;
    maxd=maxd+90;
    if (maxd > 180)
        maxd=maxd-180;
    end
end
%  ���ӽ���Sub2Swave��Sub1Swave���������Ϊ�������figure������������Ϊ�������ӽ��棩��figure�����
h=Sub2Swave(handles.figure1);
%  ����guihandles�������h�������handles�ṹ�塣
Sub2Handles=guihandles(h);
%  ���������ֵ���첨ƫ��������ʱ���ӳ١�
set(Sub2Handles.edit1,'String',num2str(maxcoef));
set(Sub2Handles.edit2,'String',num2str(maxd));
set(Sub2Handles.edit3,'String',num2str(maxt));
%  ���ӽ����axes1�ϻ��Ƶ�ֵ��ͼ��
axes(Sub2Handles.axes1);
[A,h]=contour(x,y,abs(c));
xlabel('Degree/��','Units','normalized','Position',[0.49748 -0.07 0]);
ylabel('Time/s');
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2);
hold on  %  ������ֵ��ͼ
plot(h,maxd,maxt,'r.');  %  ��������ֵ�����ƺ�ɫ�Ǻ�
text(maxd,maxt,num2str(maxcoef));  %  ��������ֵ��д���ֵ�Ĵ�С
set(Sub2Handles.axes1,'Visible','on');
%  ���ӽ����axes2�ϻ��Ƶ������С���ֵͼ��
axes(Sub2Handles.axes2);
plot(x,cmax,x,cmin);
xlabel('Degree/��','Units','normalized','Position',[0.49748 -0.07 0]);
ylabel('Correlation Value C');
set(Sub2Handles.axes2,'Visible','on');
if (OutputReport_index == 1)
    %  ����S�����ѽ���ռ�ֲ�ͼ��
    hfigure=LocationPlot(handles,hEW,maxt,maxd);
    %  ���ɷ���������档
    ResultReport(handles,hEW,hfigure,maxcoef,maxt,maxd);
end
%  �������ݣ�������ͼ�Ļ�ͼ���ݷֱ�浽��Ӧ����ϵ�С�
temp=[x',cmin',cmax'];
setappdata(Sub2Handles.axes1,'Y',c);
setappdata(Sub2Handles.axes2,'Y',temp);



        


