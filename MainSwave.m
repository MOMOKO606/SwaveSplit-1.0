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

%  以下代码的作用为修改GUI左上角图标。
%newIcon=javax.swing.ImageIcon('sample.jpg');
%figFrame=get(handles.figure1,'JavaFrame');  %  取得Figure的JavaFrame。
%figFrame.setFigureIcon(newIcon); %  修改图标


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

pltn1=0;  %  pltn1表示当前打开图线数量的参数，GUI运行时赋初值为0。
setappdata(0,'pltn1',pltn1);  %  将pltn1保存为全局变量。
%  report_index是表示输出结果报告形式的参数：
%  当report_index=0时（默认值），表示单独生成结果报告；
%  当report_index=1时，表示将多次结果报告输出到同一个word文档中。
%  同理，location_index是表示生成结果空间分布图形式的参数：
%  当location_index=0时（默认值），表示单独生成结果空间分布图；
%  当location_index=1时，表示用多次结果生成一幅结果空间分布图。
%  同理，OutputReport_index是表示是否输出结果报告的参数：
%  当OutputReport=1时（默认值），表示输出结果报告；
%  当OutputReport=-1时，表示不输出结果报告。
setappdata(0,'report_index',0);
setappdata(0,'location_index',0);
setappdata(0,'OutputReport_index',1);
%  reptdata1、reptdata2为结果空间分布图绘图参数。
%  由于默认单独生成结果空间分布图，故先赋空值。
setappdata(0,'reptdata1',[]);
setappdata(0,'reptdata2',[]);
%  为path1、path2、path3赋初值，初值为当前路径；
%  path1表示打开文件路径。
%  path2表示结果报告的输出路径。
%  path3表示文件存储路径。
setappdata(0,'path1',pwd);
setappdata(0,'path2',pwd);
setappdata(0,'path3',pwd);


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  获取全局变量pltn1的值，pltn1为目前已经打开的地震波形图数目。  
pltn1=getappdata(0,'pltn1');
%  当打开图形数小于3时，“打开”功能可使用
if (pltn1 < 3)
    set(handles.Open,'enable','on');
else
    set(handles.Open,'enable','off');
end
%  当存在打开的地震波形图时，“保存”、“关闭”等功能开启，否则功能关闭。
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

%  读取当前设置的打开文件路径。
DefaultPath=getappdata(0,'path1');
%  将可能出现的6种axes的Position值存入axespos中，axespos为cell矩阵。
axespos(1,1)={[0.041,0.271,0.755,0.498]};
axespos(2,1)={[0.041,0.573,0.755,0.349;0.041,0.113,0.755,0.349]};
axespos(3,1)={[0.041,0.711,0.755,0.23;0.041,0.386,0.755,0.23;0.041,0.06,0.755,0.23]};
%  获取全局变量pltn1的值，pltn1为目前已经打开的地震波形图数目。
pltn1=getappdata(0,'pltn1');
%  创建一个打开文件对话框。
[FileName,PathName]=uigetfile(...
{'*.SAC','SAC Files(*.SAC)';'*.txt','ASCII Data(*.txt)';...
 '*.dat','Golden Software Data(*.dat)';'*.*','All Files(*.*)'},...
 '选择文件',DefaultPath,'MultiSelect','on');
%  当用户在对话框中点击“取消”时，Open_Callback停止。
if ((iscellstr(FileName) == 0) & (FileName == 0))
    return
end
[inputfile,pltn2,pltn3]=Get_Pltn2(handles,pltn1,PathName,FileName);
if (pltn3 > 3)
    errordlg('最多可同时打开3张地震波形图！','错误提示');
    return
end
%  通过ChekAxes函数得到有图片的axes以及空axes的句柄。
[hocupd,hfree]=ChekAxes(handles);
%  根据现有图片数以及将要打开图片数，进行axes的尺寸和位置变化：
%  1、更改已有图形的axes的尺寸和位置；
for i=1:pltn1
    set(hocupd(i),'Units','normalized','Visible','on','Position',axespos{pltn3,1}(i,:));
end
%  2、给将要绘制的波形图分配axes，调整这些axes的尺寸和位置，并绘图；
for i=1:pltn2
    set(hfree(i),'Units','normalized','Position',axespos{pltn3,1}(pltn1+i,:));  %  调整axes的尺寸和位置
    %  读取数据。
    filename=inputfile{1,pltn2+1-i};  %  pltn2+1-i是为了让先选的数据图片显示在上面。
    type_index=strcmpi(filename(end-3:end),'.SAC');
    if (type_index == 1)
        [hd,stime,sdata]=rdSac(filename);  
    else
        sdata=getappdata(handles.Open,filename);  %  生成sdata
        delta_temp=inputdlg_fix('请输入ASCII形式波形数据的采样间隔(s)：','输入提示',1);
        if (isempty(delta_temp) ~= 1 )
            delta=str2num(cell2mat(delta_temp));  %  先将cell转换为普通矩阵（字符串），再降delta转换为double型
        else
            delta=0.025;  %  当用户选择取消，没有输入采样间隔值时，系统默认采样间隔为0.025s。
        end
        n=length(sdata);
        stime=[0:delta:(n-1)*delta];  %  生成stime
        t=[delta;zeros(78,1);n;zeros(20,1)];
        hd=cell(25,1);
        hd{1,1}=t;  %  生成hd
    end
    SacPlot(hfree(i),hd,stime,sdata);
    set(hfree(i),'Visible','on');  %  绘图完成后显示axes
end
%  3、设置空axes为不可见。
temp=length(hfree)-pltn2;
for i=1:temp
    set(hfree(pltn2+i),'Visible','off');
end
%  更新pltn1的值，并存为全局变量。
pltn1=pltn3;
setappdata(0,'pltn1',pltn1);
%  更新打开文件路径。
setappdata(0,'path1',PathName);


% --------------------------------------------------------------------
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  与右键菜单中“清除该图像”功能相同。
removeplot_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function Closeall_Callback(hObject, eventdata, handles)
% hObject    handle to Closeall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  清除所有axes上的图像及数据。
for i=1:3
    str=['handles.axes',num2str(i)];
    eval(['h=',str,';']);
    cla(h,'reset');
    set(h,'Visible','off');
end
%  将pltn1恢复为初始值0。
setappdata(0,'pltn1',0);  
%  将EWindex、EWtemp、hEW恢复为初始值。
setappdata(0,'EWindex',0);
setappdata(0,'EWtemp',-1);
setappdata(0,'hEW',[]);
set(handles.ChooseEW,'Checked','off');
%  将NSindex、NStemp、hNS恢复为初始值。
setappdata(0,'NSindex',0);
setappdata(0,'NStemp',-1);
setappdata(0,'hNS',[]);
set(handles.ChooseNS,'Checked','off');


% --------------------------------------------------------------------
function Savepic_Callback(hObject, eventdata, handles)
% hObject    handle to Savepic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取当前设置的存储文件路径。
str=getappdata(0,'path3');
DefaultPath=[str,'\untitled.fig'];
%  将当前要储存图像的句柄，赋值到hpic上。
hpic=gca;
%  由于saveas只能针对figure储存图像，故需要创建一个新figure。
newfig=figure;
set(newfig,'Visible','off');  %  令其不可见
delete(get(newfig,'Children'));  %  删除figure内的子对象，避免坐标轴重叠
%  将要储存的图像复制到新figure上。
copyobj(hpic,newfig);
set(newfig,'Units','Normalized','Position',[0,0,1,1]);  %  令新figure最大化
set(gca,'Units','Normalized','Position',[0.08,0.11,0.83,0.815]);  %  调整图像在figure中的位置
%  创建一个文件保存对话框。
[FileName,PathName]=uiputfile(...
{'*.fig','MATLAB Figure(*.fig)';'*.jpg','JPEG image(*.jpg)';...
 '*.bmp','Bitmap file(*.bmp)';'*.tif','TIFF image(*.tif)';'*.*','All Files(*.*)'},...
 '图片另存为',DefaultPath);
if (FileName == 0)
    %  当用户点击“取消”时，关闭新建figure，函数终止。
    close(newfig);
    return
else
    if (strcmpi(FileName(end-3:end),'.fig'))  %  此处需要判断用户是否选择保存为fig格式。因为当图像保存为fig时，
        set(newfig,'Visible','on');           %  需要将figure的Visible属性设置为可见，否则打开保存好的fig时，屏幕上什么都不会出现。
    end
    saveas(newfig,fullfile(PathName,FileName));
    close(newfig);
end
%  更新存储文件路径。
setappdata(0,'path3',PathName);


% --------------------------------------------------------------------
function Savedata_Callback(hObject, eventdata, handles)
% hObject    handle to Savedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取当前设置的存储文件路径。
str=getappdata(0,'path3');
DefaultPath=[str,'\untitled.dat'];
%  读取当前图像中的幅值数据。
sdata=getappdata(gca,'sdata');
%  创建一个文件保存对话框。
[FileName,PathName]=uiputfile(...
{'*.dat','Golden Software Data(*.dat)';...
 '*.txt','ASCII Data(*.txt)';'*.*','All Files(*.*)'},...
 '文件另存为',DefaultPath);
if (FileName == 0)
    %  当用户点击“取消”时，函数终止。
    return
else
    dlmwrite(fullfile(PathName,FileName),sdata);
end
%  更新存储文件路径。
setappdata(0,'path3',PathName);


% --------------------------------------------------------------------
function Saveall_Callback(hObject, eventdata, handles)
% hObject    handle to Saveall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取当前设置的存储文件路径。
str=getappdata(0,'path3');
DefaultPath=[str,'\untitled.jpg'];
%  截取GUI框架（相当于截图）。
h=getframe(handles.figure1);
%  将截取的框架转换为图像。
h=frame2im(h);
%  创建一个文件保存对话框。
[FileName,PathName]=uiputfile(...
{'*.jpg','JPEG image(*.jpg)';'*.bmp','Bitmap file(*.bmp)';...
 '*.tif','TIFF image(*.tif)';'*.*','All Files(*.*)'},...
 '图片另存为',DefaultPath);
if (FileName == 0)
    %  当用户点击“取消”时，关闭新建figure，函数终止。
    return
else
    imwrite(h,fullfile(PathName,FileName));
end
%  更新存储文件路径。
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

%  获取全局变量pltn1的值，pltn1为目前已经打开的地震波形图数目。  
pltn1=getappdata(0,'pltn1');
%  获取全局变量hEW、hNS。
hEW=getappdata(0,'hEW');
hNS=getappdata(0,'hNS');
%  当存在打开的地震波形图时，“预处理”功能开启，否则功能关闭。
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
%  当有被选为“EW”和“NS”的分量时，“统一时间”功能开启；否则功能关闭。
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

%  读取当前axes上的参数数据。
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
sdata=getappdata(gca,'sdata');
hd=getappdata(gca,'hd');
scale=hd{1,1}(4,1);  %  得到放大倍数
%  设定输入对话框默认值。
if ((scale == 0) || (scale == -12345) )
    defAns={''};
else
    scale=1/(scale*10^-6);  %  转换成灵敏度，单位μm per (A/D)
    defAns={num2str(scale)};
end
scale=inputdlg_fix('请输入灵敏度(μm per count):','输入提示',1,defAns,'on');
%  选择取消时跳出函数。
if (isempty(scale) == 1)
    return
end
scale=str2num(cell2mat(scale));  %  先将cell转换为普通矩阵（字符串），再降scale转换为double型
%  去除仪器响应
sdata=sdata*scale;
set(hplot,'YData',sdata);
%  将更新后的图形，数据重新保存到当前axes的Application Data。
setappdata(gca,'sdata',sdata);


% --------------------------------------------------------------------
function precise_Callback(hObject, eventdata, handles)
% hObject    handle to precise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取当前axes上的参数数据。
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
delta=clcu_info(2);
sdata=getappdata(gca,'sdata');
%  创建一个输入文件格式提示。
FormatHint;   
%  创建一个打开文件对话框。
[FileName,PathName]=uigetfile({'*.txt','ASCII Data(*.txt)'},'选择文件');
if (FileName == 0)
    return
else
    ResFile=[PathName,FileName];
end
%  消除仪器响应（传递函数）。
sdata=RemvTransf(ResFile,delta,sdata);
%  更新图形，数据重新保存到当前axes的Application Data。
set(hplot,'YData',sdata);
setappdata(gca,'sdata',sdata);


% --------------------------------------------------------------------
function Remvzd_Callback(hObject, eventdata, handles)
% hObject    handle to Remvzd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取当前axes上的参数数据。
sdata=getappdata(gca,'sdata');
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
clcu_info(3)=clcu_info(3)+1;
%  去除零点漂移。
sdata=dtrend(sdata);
set(hplot,'YData',sdata);
%  将更新后的图形，数据重新保存到当前axes的Application Data。
setappdata(gca,'sdata',sdata);
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function Remvld_Callback(hObject, eventdata, handles)
% hObject    handle to Remvld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取当前axes上的参数数据。
sdata=getappdata(gca,'sdata');
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
clcu_info(4)=clcu_info(4)+1;
%  去除线性漂移。
sdata=dtrend(sdata,1);
set(hplot,'YData',sdata);
%  将更新后的图形，数据重新保存到当前axes的Application Data。
setappdata(gca,'sdata',sdata);
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function Input_EventLatLon_Callback(hObject, eventdata, handles)
% hObject    handle to Input_EventLatLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取当前axes上的参数数据。
hd=getappdata(gca,'hd');
%  创建输入对话框，地震事件震中经度、地震事件震中纬度。
prompt={'地震事件震中经度(°)：','地震事件震中纬度(°)：'};
dlg_title='手动输入该地震波形图对应的事件经纬度';
answer=inputdlg_fix(prompt,dlg_title,1);
if (isempty(answer) == 1)
    return
end
hd{1,1}(36,1)=str2num(char(answer(1,1)));  %  Event latitude (degrees, north positive). 
hd{1,1}(37,1)=str2num(char(answer(2,1)));  %  Event longitude (degrees, east positive). 
%  将更新后的数据重新保存到当前axes的Application Data。
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

%  获取全局变量pltn1的值，pltn1为目前已经打开的地震波形图数目。  
pltn1=getappdata(0,'pltn1');
%  当存在打开的地震波形图时，“计算”功能开启，否则功能关闭。
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

%  读取当前图形中积分所需参数。
sdata=getappdata(gca,'sdata');
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
delta=clcu_info(2);
clcu_info(5)=clcu_info(5)+1;
%  梯形积分并更新图形。
sdata=TrapInt(sdata,delta);
set(hplot,'YData',sdata);
%  将更新后的图形，数据重新保存到当前axes的Application Data。
setappdata(gca,'sdata',sdata);
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function Differet_Callback(hObject, eventdata, handles)
% hObject    handle to Differet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取当前图形中积分所需参数。
stime=getappdata(gca,'stime');
sdata=getappdata(gca,'sdata');
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
delta=clcu_info(2);
clcu_info(6)=clcu_info(6)+1;
%  梯形积分并更新图形。
sdata=Deriva(stime,sdata,delta);
set(hplot,'YData',sdata);
%  将更新后的图形，数据重新保存到当前axes的Application Data。
setappdata(gca,'sdata',sdata);
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function filter_Callback(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取当前图形中的sdata、hplot。
sdata=getappdata(gca,'sdata');
clcu_info=getappdata(gca,'clcu_info');
hplot=clcu_info(1);
%  得到用户输入的滤波频率范围。
answer=FreqRange;
if (isempty(answer) == 1)
    return
end
f1=char(answer(1,1));
f2=char(answer(2,1));
f1=str2num(f1)*pi/180;
f2=str2num(f2)*pi/180;
%  滤波并更新图形。
sdata=idfilt(sdata,5,[f1 f2]);
set(hplot,'YData',sdata);
%  保存更新后的sdata数据到当前axes的Application Data。
setappdata(gca,'sdata',sdata);


% --------------------------------------------------------------------
function SigNois_Ratio_Callback(hObject, eventdata, handles)
% hObject    handle to SigNois_Ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  载入当前图像的参数信息。
clcu_info=getappdata(gca,'clcu_info');
sdata=getappdata(gca,'sdata');
%  得到当前图像采样间隔。
delta=round(clcu_info(2)*1000000)/1000000;  % 控制6位有效数字
%  创建输入对话框，输入信号开始、截止时间。
prompt={'信号起始时间(s)：','信号截止时间(s)：'};
dlg_title='计算信噪比';
answer=inputdlg_fix(prompt,dlg_title,1);
%  得到用户输入的信号范围。
if (isempty(answer) == 1)  %  当用户选择取消时，函数终止。
    return  
end
time1=str2num(char(answer(1,1)));
time2=str2num(char(answer(2,1)));
%  判断用户的输入参数是否符合要求。
if (mod(time1,delta) ~= 0)
    errordlg(['起始时间应该为采样间隔',num2str(delta),'的倍数，请重新输入！'],'错误提示');
    return
elseif (mod(time2,delta) ~= 0)
    errordlg(['截止时间应该为采样间隔',num2str(delta),'的倍数，请重新输入！'],'错误提示');
    return
end
t1=time1/delta+1;
t2=time2/delta+1;
sig=sdata(t1:t2);
nois=sdata(1:t1-1);
ps=sqrt(sum((sig.^2))/(t2-t1+1));
pn=sqrt(sum((nois.^2))/(t1-1));
%  计算信噪比。
snr=10*log10(ps/pn);  
clcu_info(11)=snr;
%  更新当前axes的Application Data。
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function epcentldis_Callback(hObject, eventdata, handles)
% hObject    handle to epcentldis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取相应计算所用的参数。
hd=getappdata(gca,'hd');
clcu_info=getappdata(gca,'clcu_info');
%  假如已经计算过震中距则函数终止，不再重新计算。
if (isnan(clcu_info(7)) == 0 )
    return
end
%  从文件头中读取震中距，假如数据存在则不再计算；
DIST=hd{1,1}(51,1);
if (DIST ~= -12345 && DIST ~= 0)
    clcu_info(7)=DIST;
else
    %  当文件头中不存在震中距数据时，通过台站、震中的经纬度来计算；
    STLA=hd{1,1}(32,1);    %  Station latitude (degrees, north positive).
    STLO=hd{1,1}(33,1);    %  Station longitude (degrees, east positive).
    EVLA=hd{1,1}(36,1);    %  Event latitude (degrees, north positive). 
    EVLO=hd{1,1}(37,1);    %  Event longitude (degrees, east positive). 
    %  当台站、震中经纬度数据缺失时，计算终止。
    if ((STLA == 0 && STLO == 0 && EVLA ==0 && EVLO ==0) || (STLA == -12345 && STLO == -12345 && EVLA ==-12345 && EVLO ==-12345))
        errordlg('台站、震中经纬度数据缺失，无法计算！','错误提示');
        return
    end
    slo=STLO*pi/180;  %  台站经度（转换为弧度）
    sla=LatiTrans(STLA);  %  台站地心余纬度
    elo=EVLO*pi/180;  %  震中经度（转换为弧度）
    ela=LatiTrans(EVLA);  %  震中地心余纬度
    %  计算震中距(Epicentral distance)。
    t=acos(cos(ela)*cos(sla)+sin(ela)*sin(sla)*cos(elo-slo));
    clcu_info(7)=t*180*111.12/pi; %  单位为千米
end
%  更新当前axes的Application Data。
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function azimuth_Callback(hObject, eventdata, handles)
% hObject    handle to azimuth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取相应计算所用的参数。
hd=getappdata(gca,'hd');
clcu_info=getappdata(gca,'clcu_info');
%  假如已经计算过方位角则函数终止，不再重新计算。
if (isnan(clcu_info(8)) == 0 )
    return
end
%  从文件头中读取方位角，假如数据存在则不再计算；
AZ=hd{1,1}(52,1);
if (AZ ~= -12345 && AZ ~= 0)
    clcu_info(8)=AZ;
else
    %  当文件头中不存在方位角数据时，通过台站、震中的经纬度来计算；
    STLA=hd{1,1}(32,1);    %  Station latitude (degrees, north positive).
    STLO=hd{1,1}(33,1);    %  Station longitude (degrees, east positive).
    EVLA=hd{1,1}(36,1);    %  Event latitude (degrees, north positive). 
    EVLO=hd{1,1}(37,1);    %  Event longitude (degrees, east positive). 
    %  当台站、震中经纬度数据缺失时，计算终止。
    if ((STLA == 0 && STLO == 0 && EVLA ==0 && EVLO ==0) || (STLA == -12345 && STLO == -12345 && EVLA ==-12345 && EVLO ==-12345))
        errordlg('台站、震中经纬度数据缺失，无法计算！','错误提示');
        return
    end
    %  计算方位角（台站相对于震中的方位角）。
    clcu_info(8)=Azim(STLO,STLA,EVLO,EVLA);
end
%  更新当前axes的Application Data。
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function bkazimuth_Callback(hObject, eventdata, handles)
% hObject    handle to bkazimuth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取相应计算所用的参数。
hd=getappdata(gca,'hd');
clcu_info=getappdata(gca,'clcu_info');
%  假如已经计算过反方位角则函数终止，不再重新计算。
if (isnan(clcu_info(9)) == 0 )
    return
end
%  从文件头中读取反方位角，假如数据存在则不再计算；
BAZ=hd{1,1}(53,1);
if (BAZ ~= -12345 && BAZ ~= 0)
    clcu_info(9)=BAZ;
else
    %  当文件头中不存在方位角数据时，通过台站、震中的经纬度来计算；
    STLA=hd{1,1}(32,1);    %  Station latitude (degrees, north positive).
    STLO=hd{1,1}(33,1);    %  Station longitude (degrees, east positive).
    EVLA=hd{1,1}(36,1);    %  Event latitude (degrees, north positive). 
    EVLO=hd{1,1}(37,1);    %  Event longitude (degrees, east positive). 
    %  当台站、震中经纬度数据缺失时，计算终止。
    if ((STLA == 0 && STLO == 0 && EVLA ==0 && EVLO ==0) || (STLA == -12345 && STLO == -12345 && EVLA ==-12345 && EVLO ==-12345))
        errordlg('台站、震中经纬度数据缺失，无法计算！','错误提示');
        return
    end
    %  计算反方位角（相当于震中相对于台站的方位角）。
    clcu_info(9)=Azim(EVLO,EVLA,STLO,STLA);
end
%  更新当前axes的Application Data。
setappdata(gca,'clcu_info',clcu_info);


% --------------------------------------------------------------------
function offsource_Callback(hObject, eventdata, handles)
% hObject    handle to offsource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取相应计算所用的参数。
hd=getappdata(gca,'hd');
clcu_info=getappdata(gca,'clcu_info');
%  假如已经计算过离源角则函数终止，不再重新计算。
if (isnan(clcu_info(10)) == 0 )
    return
end
%  读取台站、震中经纬度数据。
STLA=hd{1,1}(32,1);    %  Station latitude (degrees, north positive).
STLO=hd{1,1}(33,1);    %  Station longitude (degrees, east positive).
EVLA=hd{1,1}(36,1);    %  Event latitude (degrees, north positive). 
EVLO=hd{1,1}(37,1);    %  Event longitude (degrees, east positive). 
%  读取震源深度数据。
EVDP=hd{1,1}(39,1);
%  当震源深度数据缺失时，计算终止。
if (EVDP == 0 || EVDP == -12345)
    errordlg('震源深度数据缺失，无法计算！','错误提示');
    return
end
slo=STLO*pi/180;  %  台站经度（转换为弧度）
sla=LatiTrans(STLA);  %  台站地心余纬度
elo=EVLO*pi/180;  %  震中经度（转换为弧度）
ela=LatiTrans(EVLA);  %  震中地心余纬度
%  计算震中距(Epicentral distance)。
t=acos(cos(ela)*cos(sla)+sin(ela)*sin(sla)*cos(elo-slo));
epc_dis=t*180*111.12/pi; %  单位为千米
%  计算离源角（直达P波的离源角）。
deg=atan(epc_dis*1000/EVDP);
clcu_info(10)=deg*180/pi;
%  给“横波窗标识”赋值。
if (epc_dis >= 1000)
    clcu_info(12)=1;
else
    if (clcu_info(10) >= 45)
        clcu_info(12)=1;
    else
        clcu_info(12)=2;
    end
end
%  更新当前axes的Application Data。
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

%  读取全局变量OutputReport_index。
OutputReport_index=getappdata(0,'OutputReport_index');
%  根据OutputReport_index判断是否选中，并实现相应的功能。
OutputReport_index=OutputReport_index*-1;
if (OutputReport_index == 1)
    set(handles.Output_Report,'Checked','on');
else
    set(handles.Output_Report,'Checked','off');
end
%  更新全局变量OutputReport_index。
setappdata(0,'OutputReport_index',OutputReport_index);


% --------------------------------------------------------------------
function RptPath_Callback(hObject, eventdata, handles)
% hObject    handle to RptPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取当前设置的输出路径。
path=getappdata(0,'path2');
%  创建一个目录选择对话框，默认路径为当前路径。
str=uigetdir(path,'请选择路径');
%  当用户点击取消时，函数结束。
if (str == 0)
    return
else
    path=str;
end
%  保存路径。
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

%  打开软件帮助文档。
!SwaveSplit帮助文档.chm;


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

%  计算当前坐标系x轴、y轴的坐标范围。
xmin=min(get(gca,'XLim'));  
xmax=max(get(gca,'XLim'));
ymin=min(get(gca,'YLim'));
ymax=max(get(gca,'YLim'));
pos=mean(get(gca,'CurrentPoint'));      %  获得当前点坐标。
%  判断：当当前点坐标在当前坐标系范围内，并且当前坐标上有图（不是空坐标系）时创建图例，图例显示当前点的坐标。
%  创建图例的过程：
%  1、首先创建一个组对象，设置图例显示组对象的子对象。
%  2、创建组对象的子对象为（0，0）点，并且令其不可见。这么做是为了在创建图例时产生2个字符串。
%  3、删除图例中的线，更改图例中字符串的内容，令其显示当前点坐标。
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

%  读取参数EWindex、NSindex、hEW、hNS。
EWindex=getappdata(0,'EWindex');
NSindex=getappdata(0,'NSindex');
hEW=getappdata(0,'hEW');
hNS=getappdata(0,'hNS');
%  根据以上参数调整右键菜单。
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

%  EWindex是用来表示，当前图像是否被选为进行相关分析的东西分量信号的参数。
%  当EWindex==0时，表示“未选中”；当EWindex==1时，表示“选中”。
%  这里给EWindex，EWtemp（计算参数）赋初值，并存为全局变量。
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

%  读取EWindex，EWtemp。
EWindex=getappdata(0,'EWindex');
EWtemp=getappdata(0,'EWtemp');
%  根据EWindex判断是否选中，并实现相应的功能。
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
%  更新EWindex，EWtemp
setappdata(0,'EWindex',EWindex);
setappdata(0,'EWtemp',EWtemp);
setappdata(0,'hEW',hEW);


% --- Executes during object creation, after setting all properties.
function ChooseNS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChooseNS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%  NSindex是用来表示，当前图像是否被选为进行相关分析的南北分量信号的参数。
%  当NSindex==0时，表示“未选中”；当NSindex==1时，表示“选中”。
%  这里给NSindex，NStemp（计算参数）赋初值，并存为全局变量。
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

%  读取NSindex，NStemp。
NSindex=getappdata(0,'NSindex');
NStemp=getappdata(0,'NStemp');
%  根据NSindex判断是否选中，并实现相应的功能。
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
%  更新NSindex，NStemp。
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

%  将当前要储存图像的句柄，赋值到hpic上。
hpic=gca;
%  由于saveas只能针对figure储存图像，故需要创建一个新figure。
newfig=figure;
set(newfig,'Visible','off');  %  令其不可见
delete(get(newfig,'Children'));  %  删除figure内的子对象，避免坐标轴重叠
%  将要储存的图像复制到新figure上。
copyobj(hpic,newfig);
set(newfig,'Units','Normalized','Position',[0,0,1,1]);  %  令新figure最大化
set(gca,'Units','Normalized','Position',[0.08,0.11,0.83,0.815]);  %  调整图像在figure中的位置
%  将图像复制到剪切板。
hgexport(newfig,'-clipboard');
%  关闭新figure。
close(newfig);


% --------------------------------------------------------------------
function removeplot_Callback(hObject, eventdata, handles)
% hObject    handle to removeplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  清除一张图片，全局变量pltn1减1，并重新储存到Application Data。
pltn1=getappdata(0,'pltn1');
pltn1=pltn1-1;
setappdata(0,'pltn1',pltn1);
%  若该图片被清除之前被选为EW或NS分量，图片被清除后相应的index也随之改变。
Delete_EWNS_Index(handles);
%  清除图片，并将axes的Visible设置成off。
cla(gca,'reset');
set(gca,'Visible','off');
%  通过ChekAxes函数得到有图片的axes以及空axes的句柄。
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

%  读取EW、NS分量的句柄，采样率。
hEW=getappdata(0,'hEW');
hNS=getappdata(0,'hNS');
%  判断是否已选东西、南北分量。
if ((isempty(hEW) == 1) || (isempty(hNS) == 1))
    errordlg('请先右键选择东西、南北分量！','错误提示');
    return
end
t1=getappdata(hEW,'clcu_info');
t2=getappdata(hNS,'clcu_info');
t1(2)=round(t1(2)*1000000)/1000000;  % 控制6位有效数字
t2(2)=round(t2(2)*1000000)/1000000;  % 控制6位有效数字
%  读取用户输入的截取时间。
st=get(handles.edit1,'String');
st=str2num(st);
ct=get(handles.edit2,'String');
ct=str2num(ct);
%  判断用户选择的分量图、输入的截取时间是否符合要求。
if (t1(2) ~= t2(2))
    errordlg('EW、NS分量波形图的采样率不一致！','错误提示');
    return
else
    delta=t1(2);
    if (mod(st,delta) ~= 0)
        errordlg(['起始时间应该为采样间隔',num2str(delta),'的倍数，请重新输入！'],'错误提示');
        return
    elseif (mod(ct,delta) ~= 0)
        errordlg(['截止时间应该为采样间隔',num2str(delta),'的倍数，请重新输入！'],'错误提示');
        return
    end
end
%  截取的时间数据为intcpttime;东西分量振幅为EWdata;南北分量振幅为NSdata。
t1=st/delta+1;
t2=ct/delta+1;
intcpttime=[0:delta:(t2-t1)*delta];
EWdata=getappdata(hEW,'sdata');
EWdata=EWdata(t1:t2);
NSdata=getappdata(hNS,'sdata');
NSdata=NSdata(t1:t2);
%  储存截取后的数据。
setappdata(handles.uipanel1,'intcpttime',intcpttime);
setappdata(handles.uipanel1,'EWdata',EWdata);
setappdata(handles.uipanel1,'NSdata',NSdata);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取绘图参数。
intcpttime=getappdata(handles.uipanel1,'intcpttime');
EWdata=getappdata(handles.uipanel1,'EWdata');
NSdata=getappdata(handles.uipanel1,'NSdata');
%  没点击“确认”的错误提示。
if ( isempty(intcpttime) == 1)
    errordlg('请先输入截取时间，点击确认，再点击''显示截取后的EW、NS波形图''','错误提示');
    return
end
%  打开子界面Sub1Swave，Sub1Swave的输入参数为主界面的figure句柄，输出参数为自身（即子界面）的figure句柄。
h=Sub1Swave(handles.figure1);
%  利用guihandles获得与句柄h相关联的handles结构体。
Sub1Handles=guihandles(h);
%  在子界面的axes1上绘制截取的EW波形分量。
axes(Sub1Handles.axes1);
plot(intcpttime,EWdata);
grid on;                                                             
%  在子界面的axes2上绘制截取的NS波形分量。
axes(Sub1Handles.axes2);
plot(intcpttime,NSdata);
grid on;          
%  保存数据，将两幅图的幅值分别存到对应坐标系中。
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

%  读取全局变量OutputReport_index。
OutputReport_index=getappdata(0,'OutputReport_index');
%  载入EWdata、NSdata数据。
EWdata=getappdata(handles.uipanel1,'EWdata');
NSdata=getappdata(handles.uipanel1,'NSdata');
%  载入采样间隔，并取6位有效数字。
hEW=getappdata(0,'hEW');
%  判断是否已选东西、南北分量。
if (isempty(hEW) == 1)
    errordlg('请先右键选择东西、南北分量！','错误提示');
    return
end
temp=getappdata(hEW,'clcu_info');
temp(2)=round(temp(2)*1000000)/1000000;  %  取6位有效数字
delta=temp(2);
%  获取用户输入的旋转角度、时间延迟参数，并判断是否可用。
[ds,dsl,df]=Get_RotatAngle(handles);
if ((isempty(ds) == 1)||(isempty(dsl) == 1)||(isempty(df) == 1))
    errordlg('旋转角度参数不完整！','错误提示');
    return
end
[ts,tsl,tf]=Get_DelayTime(handles);
if ((isempty(ts) == 1)||(isempty(tsl) == 1)||(isempty(tf) == 1))
    errordlg('时间延迟参数不完整！','错误提示');
    return
end
%  将时间参数转换为对应的数组标号。
t1=ts/delta;
t2=tf/delta;
t3=tsl/delta;
if (mod(ts,delta) ~= 0)||(mod(tf,delta) ~= 0)||(mod(tsl,delta) ~= 0)
    errordlg(['时间延迟应该为采样间隔',num2str(delta),'的倍数，请重新输入！'],'错误提示');
    return
end
%  计算相关值。
[c,cmax,cmin]=Correlation(EWdata,NSdata,ds,dsl,df,t1,t2,t3);
x=[ds:dsl:df];
y=[ts:tsl:tf];
%  计算最大相关值以及其对应的旋转角度、时间延迟。
c=round(c*1e14)/1e14;  % 对相关值取14位有效数字
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
%  打开子界面Sub2Swave，Sub1Swave的输入参数为主界面的figure句柄，输出参数为自身（即子界面）的figure句柄。
h=Sub2Swave(handles.figure1);
%  利用guihandles获得与句柄h相关联的handles结构体。
Sub2Handles=guihandles(h);
%  输出最大相关值，快波偏振方向，慢波时间延迟。
set(Sub2Handles.edit1,'String',num2str(maxcoef));
set(Sub2Handles.edit2,'String',num2str(maxd));
set(Sub2Handles.edit3,'String',num2str(maxt));
%  在子界面的axes1上绘制等值线图。
axes(Sub2Handles.axes1);
[A,h]=contour(x,y,abs(c));
xlabel('Degree/°','Units','normalized','Position',[0.49748 -0.07 0]);
ylabel('Time/s');
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2);
hold on  %  锁定等值线图
plot(h,maxd,maxt,'r.');  %  在最大相关值处绘制红色星号
text(maxd,maxt,num2str(maxcoef));  %  在最大相关值处写相关值的大小
set(Sub2Handles.axes1,'Visible','on');
%  在子界面的axes2上绘制等最大最小相关值图。
axes(Sub2Handles.axes2);
plot(x,cmax,x,cmin);
xlabel('Degree/°','Units','normalized','Position',[0.49748 -0.07 0]);
ylabel('Correlation Value C');
set(Sub2Handles.axes2,'Visible','on');
if (OutputReport_index == 1)
    %  绘制S波分裂结果空间分布图。
    hfigure=LocationPlot(handles,hEW,maxt,maxd);
    %  生成分析结果报告。
    ResultReport(handles,hEW,hfigure,maxcoef,maxt,maxd);
end
%  保存数据，将两幅图的绘图数据分别存到对应坐标系中。
temp=[x',cmin',cmax'];
setappdata(Sub2Handles.axes1,'Y',c);
setappdata(Sub2Handles.axes2,'Y',temp);



        


