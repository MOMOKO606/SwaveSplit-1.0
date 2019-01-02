function hfigure=LocationPlot(handles,haxes,t,deg)
%  haxesΪ������ط�����EW��������ͼ��NS��������ͼ��axes�����
%  tΪ����ʱ���ӳ٣�
%  degΪ�첨ƫ����

%  ��ȡ��ͼ��ʽ�����ͻ�ͼ������
location_index=getappdata(0,'location_index');
reptdata1=getappdata(0,'reptdata1');
reptdata2=getappdata(0,'reptdata2');
%  ���̨վ���ơ�̨վ�͵����¼��ľ�γ�ȡ�
hd=getappdata(haxes,'hd');
temp(1)=hd{1,1}(33,1);    %  Station longitude (degrees, east positive).
temp(2)=hd{1,1}(32,1);    %  Station latitude (degrees, north positive).
temp(3)=hd{1,1}(37,1);    %  Event longitude (degrees, east positive). 
temp(4)=hd{1,1}(36,1);    %  Event latitude (degrees, north positive). 
KSTNM=hd{2,1};         %  Station name.
%  ����û������ʱ���ӳٷ�Χ��
ts=get(handles.edit6,'String');
tf=get(handles.edit7,'String');
%  ���ַ��Ͳ���ת��Ϊʵ�͡�
ts=str2num(ts);
tf=str2num(tf);
%  ȡ�û������ʱ���ӳٷ�Χ����ֵ��1/2������Ϊʱ��ͼ���ĳ��ȡ�
if (ts < 0)
    temp(5)=tf/2;
else
    temp(5)=(tf-ts)/2;
end
temp(6)=t;
temp(7)=deg;
%  ���»�ͼ����reptdata1��reptdata2��
reptdata1=[reptdata1,temp'];
reptdata2=strvcat(reptdata2,KSTNM);
%  ����̨վ����λ�÷ֲ�ͼ�����귶Χ��
[xmin,xmax,ymin,ymax]=Boundary(reptdata1);
%  ����ͼ��������ʱ���ӳٵĳ��ȼ�λ�õȲ�����
lgdx1=xmin+(xmax-xmin)*0.75;  %  ͼ��x������ʼ��
lgdx2=xmin+(xmax-xmin)*0.9;  %  ͼ��x������ֹ��
lgdy1=ymin+(ymax-ymin)*0.1;  %  ͼ��y������ʼ��
lgdy2=lgdy1+(ymax-ymin)*0.01;  %  ͼ��y������ֹ��
lgd_length=(lgdx2-lgdx1);  %  ͼ��ʱ���ӳٳ���
%  ��ͼ(���ڸ�ͼ����ճ���ڱ����У��ʽ�Visibel��������Ϊoff����Ҫ����Ļ�����ʱ��Ϊon���ɡ�):
hfigure=figure('Visible','off');
title('S�����ѽ���ռ�ֲ�ͼ');
xlabel('Longitude(deg.)','FontSize',12);
ylabel('Latitude(deg.)','FontSize',12);
%  ��ͼ���½ǻ���ͼ����
plot([lgdx1,lgdx2],[lgdy1,lgdy1],'b',[lgdx1,lgdx1],[lgdy1,lgdy2],'b',...
    [lgdx2,lgdx2],[lgdy1,lgdy2],'b');
text((lgdx1+lgdx2)/2,lgdy1,[num2str(max(reptdata1(5,:))),'s'],'VerticalAlignment','top',...
       'HorizontalAlignment','center');
hold on;
%  �õ���������n��nҲ��ʾn�����ݵ㣬��ѭ��n�Ρ�
n=size(reptdata1,2); 
for i=1:n
    slong=reptdata1(1,i);
    slati=reptdata1(2,i);
    elong=reptdata1(3,i);
    elati=reptdata1(4,i);
    ep_length=(reptdata1(6,i)*lgd_length)/max(reptdata1(5,:));  %  ����ʱ���ӳٳ��ȣ�ep��event point��
    d=(180-reptdata1(7,i))*pi/180;  %  �Ƕ�ת��
    epx1=elong+0.5*ep_length*sin(d);  %  ����ʱ���ӳ�x�������
    epx2=elong-0.5*ep_length*sin(d);  %  ����ʱ���ӳ�x�����յ�
    epy1=elati-0.5*ep_length*cos(d);  %  ����ʱ���ӳ�y�������
    epy2=elati+0.5*ep_length*cos(d);  %  ����ʱ���ӳ�y�����յ�
    %  ����̨վλ�ã��ú�ɫʵ�����Ǳ�ʾ������ʾ̨վ���ơ�
    plot(slong,slati,'r^','MarkerFaceColor','Red');
    text(slong,slati,reptdata2(i,:),'VerticalAlignment','top');
    %  ��������λ�ã�����ɫʵ��СԲ��ʾ�����߱�ʾʱ���ӳٵķ��򼰴�С��
    plot(elong,elati,'o','MarkerFaceColor','Blue','MarkerSize',4);
    plot([epx1,epx2],[epy1,epy2]);
end
%  �޸������᷶Χ��
axis([xmin xmax ymin ymax]); 
%  ����ǡ��ۼƳ�ͼ����ģʽ���򽫻�ͼ����reptdata1��reptdata2���¡�
if (location_index == 1)
    setappdata(0,'reptdata1',reptdata1);
    setappdata(0,'reptdata2',reptdata2);
end








