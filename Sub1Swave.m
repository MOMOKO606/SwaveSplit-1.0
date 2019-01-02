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

%  输入参数1为句柄h，此处为主界面figure的句柄。
h=varargin{1};
%  利用guihandles获得与句柄h相关联的handles结构体。
handles.MainHandles=guihandles(h);
%  更新结构体。
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
 '图片另存为','untitled.fig');
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


% --------------------------------------------------------------------
function Savedata_Callback(hObject, eventdata, handles)
% hObject    handle to Savedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  读取当前图像中的幅值数据。
ydata=getappdata(gca,'Y');
%  创建一个文件保存对话框。
[FileName,PathName]=uiputfile(...
{'*.dat','Golden Software Data(*.dat)';...
 '*.txt','ASCII Data(*.txt)';'*.*','All Files(*.*)'},...
 '文件另存为','untitled.dat');
if (FileName == 0)
    %  当用户点击“取消”时，函数终止。
    return
else
    dlmwrite(fullfile(PathName,FileName),ydata);
end


% --------------------------------------------------------------------
function Saveall_Callback(hObject, eventdata, handles)
% hObject    handle to Saveall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  截取GUI框架（相当于截图）。
h=getframe(handles.figure2);
%  将截取的框架转换为图像。
h=frame2im(h);
%  创建一个文件保存对话框。
[FileName,PathName]=uiputfile(...
{'*.jpg','JPEG image(*.jpg)';'*.bmp','Bitmap file(*.bmp)';...
 '*.tif','TIFF image(*.tif)';'*.*','All Files(*.*)'},...
 '图片另存为','untitled.jpg');
if (FileName == 0)
    %  当用户点击“取消”时，关闭新建figure，函数终止。
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
%  从主界面的uipanel1中读取intcpttime、EWdata、NSdata。
intcpttime=getappdata(MainHandles.uipanel1,'intcpttime');
EWdata=getappdata(MainHandles.uipanel1,'EWdata');
NSdata=getappdata(MainHandles.uipanel1,'NSdata');
%  做积分运算。
delta=intcpttime(2)-intcpttime(1);
EWdata=TrapInt(EWdata,delta);
NSdata=TrapInt(NSdata,delta);
%  重新绘图。
axes(handles.axes1);
plot(intcpttime,EWdata);
grid on;                                                             
axes(handles.axes2);
plot(intcpttime,NSdata);
grid on;                     
%  将更新后的数据存回主界面的uipanel1。
setappdata(MainHandles.uipanel1,'EWdata',EWdata);
setappdata(MainHandles.uipanel1,'NSdata',NSdata);


% --------------------------------------------------------------------
function Differet_Callback(hObject, eventdata, handles)
% hObject    handle to Differet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MainHandles=handles.MainHandles;
%  从主界面的uipanel1中读取intcpttime、EWdata、NSdata。
intcpttime=getappdata(MainHandles.uipanel1,'intcpttime');
EWdata=getappdata(MainHandles.uipanel1,'EWdata');
NSdata=getappdata(MainHandles.uipanel1,'NSdata');
%  做积分运算。
delta=intcpttime(2)-intcpttime(1);
EWdata=Deriva(intcpttime,EWdata,delta);
NSdata=Deriva(intcpttime,NSdata,delta);
%  重新绘图。
axes(handles.axes1);
plot(intcpttime,EWdata);
grid on;                                                             
axes(handles.axes2);
plot(intcpttime,NSdata);
grid on;                     
%  将更新后的数据存回主界面的uipanel1。
setappdata(MainHandles.uipanel1,'EWdata',EWdata);
setappdata(MainHandles.uipanel1,'NSdata',NSdata);


% --- Executes on mouse motion over figure - except title and menu.
function figure2_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure2 (see GCBO)
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 关闭子界面。
close(gcf);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MainHandles=handles.MainHandles;
%  对主界面uipanel1进行数据删除。
set(MainHandles.edit1,'String','');
set(MainHandles.edit2,'String','');
setappdata(MainHandles.uipanel1,'intcpttime',[]);
setappdata(MainHandles.uipanel1,'EWdata',[]);
setappdata(MainHandles.uipanel1,'NSdata',[]);
%  关闭子界面。
close(gcf);
