function SeisInfo(hd,clcu_info)
delta=hd{1,1}(1,1);
STLA=hd{1,1}(32,1);    %  Station latitude (degrees, north positive).
STLO=hd{1,1}(33,1);    %  Station longitude (degrees, east positive).
EVLA=hd{1,1}(36,1);    %  Event latitude (degrees, north positive). 
EVLO=hd{1,1}(37,1);    %  Event longitude (degrees, east positive). 
EVDP=hd{1,1}(39,1);    %  Event Depth(km).
ST=hd{1,1}(71:76,1);   %  Time corresponding to reference (zero) time in file.
NPTS=hd{1,1}(80,1);    %  Number of points per data component.
KSTNM=hd{2,1};         %  Station name.
KCMPNM=hd{22,1};       %  Component name.
KNETWK=hd{23,1};       %  Name of seismic network.
try
    [StartData,StartTime]=SacTime(ST);  
catch
    StartData=[];  %  当读取ASCII文件时，ST定义为0数组，此时SacTime函数无法运行
    StartTime=[];  %  故将StartData,StartTime重新定义
end
%  将台站和地震事件的经纬度转换为字符串。
%  当纬度值大于0时，表示北纬；经度值大于0时表示东经。
if (STLA > 0)  %  判断台站纬度
    STLA=[num2str(STLA),'N'];
elseif (STLA < 0) 
    STLA=[num2str(STLA),'S'];
else  
    STLA=num2str(STLA);
end
if (EVLA > 0)  %  判断地震事件纬度
    EVLA=[num2str(EVLA),'N'];
elseif (EVLA < 0) 
    EVLA=[num2str(EVLA),'S'];
else  
    EVLA=num2str(EVLA);
end
if (STLO > 0)  %  判断台站经度
    STLO=[num2str(STLO),'E'];
elseif (STLO < 0) 
    STLO=[num2str(STLO),'W'];
else  
    STLO=num2str(STLO);
end
if (EVLO > 0)  %  判断地震事件经度
    EVLO=[num2str(EVLO),'E'];
elseif (EVLO < 0) 
    EVLO=[num2str(EVLO),'W'];
else  
    EVLO=num2str(EVLO);
end
index=clcu_info(12);
if (index == 0)
    msg='';
elseif (index == 1)
    msg='该地震事件不在剪切波窗内';
elseif (index == 2)
    msg='该地震事件在剪切波窗内';
end
%  设定普通对话框的部分Position参数。
ParentPos=get(gcbf,'Position');  %  gcbf表示正在执行的Callback对应的对象所在窗口的句柄，即handles.figure1的句柄
xoffset=ParentPos(1)+0.29122807*ParentPos(3);
yoffset=ParentPos(2)+0.15517241*ParentPos(4);
%  创建普通对话框
hdialog=dialog('Name','Seismogram Info','Units','pixels','Position',[xoffset yoffset 256 520]);
delete(get(hdialog,'Children'));
uicontrol('Style','text','Units','pixels','Position',[35 100 200 400],...
          'FontWeight','bold','FontSize',10,'Parent',hdialog,...
          'HorizontalAlignment','left','String',...
          {['Network:',32,32,KNETWK],...
           ['Station Name:',32,32,KSTNM],...
           ['Component Name:',32,32,KCMPNM],...
           ['Station Latitude:',32,32,STLA],...
           ['Station Longitude:',32,32,STLO],...
           ['Samples:',32,32,num2str(NPTS)],...
           ['SPS:',32,32,num2str(1/delta)],...
           ['Start Data:',32,32,StartData],...
           ['Start Time:',32,32,StartTime],...
           ['Event Latitude:',32,32,EVLA],...
           ['Event Longitude:',32,32,EVLO],...
           ['Event Depth:',32,32,num2str(EVDP/1000),'(km)'],...
           '----------------------------------------------',...
           ['震中距:',32,32,num2str(clcu_info(7)),'(km)'],...
           ['方位角:',32,32,num2str(clcu_info(8))],...
           ['反方位角:',32,32,num2str(clcu_info(9))],...
           ['离源角:',32,32,num2str(clcu_info(10))],...
           msg,...
           '----------------------------------------------',...
           ['信噪比:',32,32,num2str(clcu_info(11))],...
           ['消除零点漂移次数:',32,32,num2str(clcu_info(3))],...
           ['消除线性漂移次数:',32,32,num2str(clcu_info(4))],...
           ['做积分运算次数:',32,32,num2str(clcu_info(5))],...
           ['做微分运算次数:',32,32,num2str(clcu_info(6))]});
uicontrol('Units','pixels','Position',[85 20 80 40],'FontSize',10,...
           'Parent',hdialog,'String','确定','Callback','delete(gcf)');
movegui(hdialog);  %  确保对话框出现在屏幕上
       

       
       