function SacPlot(h,hd,stime,sdata)
%  SacPlot函数功能：
%  1、绘制SAC文件地震波形图。
%  2、将SAC文件的部分计算参数、头文件信息、地震波形图的横坐标时间信息、地震波形图的纵坐标振幅信
%     息（可能是位移、速度、加速度）存入句柄为h的axes中的Application Data，并分别存为clcu_info,
%     hd,stime,sdata。

%  从头文件中读入所需参数。
delta=hd{1,1}(1,1);
KSTNM=hd{2,1};         %  Station name.
KCMPNM=hd{22,1};       %  Component name.
KNETWK=hd{23,1};       %  Name of seismic network.
ST=hd{1,1}(71:76,1);   %  Time corresponding to reference (zero) time in file.
try
    [StartData,StartTime]=SacTime(ST);  
catch
    StartData=[];  %  当读取ASCII文件时，ST定义为0数组，此时SacTime函数无法运行
    StartTime=0;  %  故将StartData,StartTime重新定义
end
%  定义xtick以及xticklabel。
x=fix(max(stime)/60);  %  计算时间轴经历了几分钟
if (x <= 6)                para1=10;para2=1;  %  当时间轴小于6分钟时,每10秒1个刻度，每1分钟1个刻度标记
elseif (x > 6 && x <= 12)  para1=30;para2=1;  %  当时间轴大于6分钟小于12分钟时,每30秒1个刻度，每1分钟1个刻度标记
else                       para1=60;para2=2;  %  当时间轴大于12分钟时,每1分钟1个刻度，每2分钟1个刻度标记  
end
y=fix(max(stime)/para1);
xtick=[0:para1:y*para1];
xticklabel=cell(y+1,1);
xticklabel{1,1}=StartTime;
for i=1:x/para2
    j=(60/para1)*para2*i+1;
    xticklabel{j,1}=strcat('+',num2str(i*para2),'m');
end
%  绘制地震波形图。
if (isempty(StartData) ~= 1)
    DataTime=strcat(StartData,32,StartTime);
else
    DataTime=[];  %  当读取ASCII文件时，StartData为空值，此时将DataTime也定义为空值。
end
str=strcat(DataTime,32,32,32,32,32,32,KNETWK,':',KSTNM,':',KCMPNM);   %  str为图名，32为字符串连接时的空格。
axes(h);  
hplot=plot(stime,sdata);
grid on;                                                              %  打开网格。
box off;                                                              %  取消边框。
title(str);
set(h,'XLim',[min(stime) max(stime)],'XTick',xtick,'XTickLabel',xticklabel);
%  将此SAC文件的数据存入对应的axes中的Application Data。
%  clcu_info中分别存放：
%  clcu_info（1）：plot曲线图的句柄hplot；
%  clcu_info（2）：SAC数据的采样间隔delta；
%  clcu_info（3）：该曲线图去除零点漂移的次数；
%  clcu_info（4）：该曲线图去除线性漂移的次数；
%  clcu_info（5）：该曲线图做积分的次数；
%  clcu_info（6）：该曲线图求导的次数；
%  clcu_info（7）：经计算得到的震中矩，初始值为空；
%  clcu_info（8）：经计算得到的方位角，初始值为空；
%  clcu_info（9）：经计算得到的反方位角，初始值为空；
%  clcu_info（10）：经计算得到的离源角，初始值为空；
%  clcu_info(11)：经计算得到的信噪比，初始值为空；
%  clcu_info(12)：地震信号是否在横波窗内的标识。初值为0；不满足横波窗内时,值为1；满足横波窗内时,值为2。
clcu_info=[hplot;delta;zeros(4,1);nan;nan;nan;nan;nan;0];
setappdata(h,'clcu_info',clcu_info);
setappdata(h,'hd',hd);
setappdata(h,'stime',stime);
setappdata(h,'sdata',sdata);











