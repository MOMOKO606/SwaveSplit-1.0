function [ds,dsl,df]=Get_RotatAngle(handles)
ds=get(handles.edit3,'String');
ds=str2num(ds);
df=get(handles.edit4,'String');
df=str2num(df);
dsl=get(handles.edit5,'String');
dsl=str2num(dsl);
