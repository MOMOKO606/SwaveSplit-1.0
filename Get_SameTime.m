function Get_SameTime
%  载入EW、NS分量句柄。
hEW=getappdata(0,'hEW');
hNS=getappdata(0,'hNS');
%  载入EW、NS分量对应的头文件。
h1=getappdata(hEW,'hd');
h2=getappdata(hNS,'hd');
%  将采样间隔存入delta，并取6位有效数字。
delta=h1{1,1}(1,1);
delta=round(delta*1000000)/1000000;  %  取6位有效数字
%  将EW分量的起始时间存入t1。
t1=h1{1,1}(73:74,1);
sec=h1{1,1}(75,1)+h1{1,1}(76,1)/1000;
t1=[t1;sec];
%  将NS分量的起始时间存入t2。
t2=h2{1,1}(73:74,1);
sec=h2{1,1}(75,1)+h2{1,1}(76,1)/1000;
t2=[t2;sec];
%  计算EW、NS分量起始时间时间差。
for i=1:2
    p=t1(i)-t2(i);
    t1(i+1)=p*60+t1(i+1);
end
p=t1(3)-t2(3);
%  根据计算出的时间差，调整记录起始时间较早的分量，将多出的时间部分截掉。
if (p > 0)
    hd1=hNS;
    hd2=hEW;
elseif (p < 0)
    hd1=hEW;
    hd2=hNS;
end
%  读取要截取的分量数据。
stime=getappdata(hd1,'stime');
sdata=getappdata(hd1,'sdata');
temp=getappdata(hd1,'clcu_info');
hplot=temp(1);
%  截掉多余的时间,更新stime、sdata数据。
q=int32(abs(p)/delta+1);
sdata=sdata(q:end);
stime=[0:delta:delta*(length(sdata)-1)]';
%  更新xtick以及xticklabel。
x=fix(max(stime)/60);  %  计算时间轴经历了几分钟
if (x <= 6)                para1=10;para2=1;  %  当时间轴小于6分钟时,每10秒1个刻度，每1分钟1个刻度标记
elseif (x > 6 && x <= 12)  para1=30;para2=1;  %  当时间轴大于6分钟小于12分钟时,每30秒1个刻度，每1分钟1个刻度标记
else                       para1=60;para2=2;  %  当时间轴大于12分钟时,每1分钟1个刻度，每2分钟1个刻度标记  
end
y=fix(max(stime)/para1);
xtick=[0:para1:y*para1];
xticklabel=cell(y+1,1);
str=get(hd2,'XTickLabel');
xticklabel{1,1}=char(str(1));
for i=1:x/para2
    j=(60/para1)*para2*i+1;
    xticklabel{j,1}=strcat('+',num2str(i*para2),'m');
end
%  更新曲线图。
set(hplot,'XData',stime);
set(hplot,'YData',sdata);
set(hd1,'XLim',[min(stime) max(stime)],'XTick',xtick,'XTickLabel',xticklabel);
%  将截取后的stime、sdata重新保存。
setappdata(hd1,'stime',stime);
setappdata(hd1,'sdata',sdata);
       
    
    
    
    
    
    
