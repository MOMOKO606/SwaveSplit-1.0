function [ts,tsl,tf]=Get_DelayTime(handles)
%  得到用户输入的时间延迟参数：
%  ts为时间延迟起始值；
%  tf为时间延迟终止值；
%  tsl为时间延迟的时间间隔。
ts=get(handles.edit6,'String');
ts=str2num(ts);
tf=get(handles.edit7,'String');
tf=str2num(tf);
tsl=get(handles.edit8,'String');
tsl=str2num(tsl);

