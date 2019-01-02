function [hocupd,hfree]=ChekAxes(handles)
%  ChekAxes为Swave_GUI内部函数，功能是检索handles.axes1～handles.axes3是否有地震波形图。
%  已经有图的axes句柄存放到hocupd中，无图的axes句柄存放到hfree中。
hocupd=[];
hfree=[];
for i=1:3
    ha=eval(['handles.axes' num2str(i)]);
    index=isempty(get(ha,'Children'));
    if (index ~= 1)
        hocupd=[hocupd;ha];
    else
        hfree=[hfree;ha];
    end
end



















