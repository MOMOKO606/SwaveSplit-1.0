function [ts,tsl,tf]=Get_DelayTime(handles)
%  �õ��û������ʱ���ӳٲ�����
%  tsΪʱ���ӳ���ʼֵ��
%  tfΪʱ���ӳ���ֵֹ��
%  tslΪʱ���ӳٵ�ʱ������
ts=get(handles.edit6,'String');
ts=str2num(ts);
tf=get(handles.edit7,'String');
tf=str2num(tf);
tsl=get(handles.edit8,'String');
tsl=str2num(tsl);

