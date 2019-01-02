function SacPlot(h,hd,stime,sdata)
%  SacPlot�������ܣ�
%  1������SAC�ļ�������ͼ��
%  2����SAC�ļ��Ĳ��ּ��������ͷ�ļ���Ϣ��������ͼ�ĺ�����ʱ����Ϣ��������ͼ�������������
%     Ϣ��������λ�ơ��ٶȡ����ٶȣ�������Ϊh��axes�е�Application Data�����ֱ��Ϊclcu_info,
%     hd,stime,sdata��

%  ��ͷ�ļ��ж������������
delta=hd{1,1}(1,1);
KSTNM=hd{2,1};         %  Station name.
KCMPNM=hd{22,1};       %  Component name.
KNETWK=hd{23,1};       %  Name of seismic network.
ST=hd{1,1}(71:76,1);   %  Time corresponding to reference (zero) time in file.
try
    [StartData,StartTime]=SacTime(ST);  
catch
    StartData=[];  %  ����ȡASCII�ļ�ʱ��ST����Ϊ0���飬��ʱSacTime�����޷�����
    StartTime=0;  %  �ʽ�StartData,StartTime���¶���
end
%  ����xtick�Լ�xticklabel��
x=fix(max(stime)/60);  %  ����ʱ���ᾭ���˼�����
if (x <= 6)                para1=10;para2=1;  %  ��ʱ����С��6����ʱ,ÿ10��1���̶ȣ�ÿ1����1���̶ȱ��
elseif (x > 6 && x <= 12)  para1=30;para2=1;  %  ��ʱ�������6����С��12����ʱ,ÿ30��1���̶ȣ�ÿ1����1���̶ȱ��
else                       para1=60;para2=2;  %  ��ʱ�������12����ʱ,ÿ1����1���̶ȣ�ÿ2����1���̶ȱ��  
end
y=fix(max(stime)/para1);
xtick=[0:para1:y*para1];
xticklabel=cell(y+1,1);
xticklabel{1,1}=StartTime;
for i=1:x/para2
    j=(60/para1)*para2*i+1;
    xticklabel{j,1}=strcat('+',num2str(i*para2),'m');
end
%  ���Ƶ�����ͼ��
if (isempty(StartData) ~= 1)
    DataTime=strcat(StartData,32,StartTime);
else
    DataTime=[];  %  ����ȡASCII�ļ�ʱ��StartDataΪ��ֵ����ʱ��DataTimeҲ����Ϊ��ֵ��
end
str=strcat(DataTime,32,32,32,32,32,32,KNETWK,':',KSTNM,':',KCMPNM);   %  strΪͼ����32Ϊ�ַ�������ʱ�Ŀո�
axes(h);  
hplot=plot(stime,sdata);
grid on;                                                              %  ������
box off;                                                              %  ȡ���߿�
title(str);
set(h,'XLim',[min(stime) max(stime)],'XTick',xtick,'XTickLabel',xticklabel);
%  ����SAC�ļ������ݴ����Ӧ��axes�е�Application Data��
%  clcu_info�зֱ��ţ�
%  clcu_info��1����plot����ͼ�ľ��hplot��
%  clcu_info��2����SAC���ݵĲ������delta��
%  clcu_info��3����������ͼȥ�����Ư�ƵĴ�����
%  clcu_info��4����������ͼȥ������Ư�ƵĴ�����
%  clcu_info��5����������ͼ�����ֵĴ�����
%  clcu_info��6����������ͼ�󵼵Ĵ�����
%  clcu_info��7����������õ������оأ���ʼֵΪ�գ�
%  clcu_info��8����������õ��ķ�λ�ǣ���ʼֵΪ�գ�
%  clcu_info��9����������õ��ķ���λ�ǣ���ʼֵΪ�գ�
%  clcu_info��10����������õ�����Դ�ǣ���ʼֵΪ�գ�
%  clcu_info(11)��������õ�������ȣ���ʼֵΪ�գ�
%  clcu_info(12)�������ź��Ƿ��ںᲨ���ڵı�ʶ����ֵΪ0��������Შ����ʱ,ֵΪ1������Შ����ʱ,ֵΪ2��
clcu_info=[hplot;delta;zeros(4,1);nan;nan;nan;nan;nan;0];
setappdata(h,'clcu_info',clcu_info);
setappdata(h,'hd',hd);
setappdata(h,'stime',stime);
setappdata(h,'sdata',sdata);











