function [hocupd,hfree]=ChekAxes(handles)
%  ChekAxesΪSwave_GUI�ڲ������������Ǽ���handles.axes1��handles.axes3�Ƿ��е�����ͼ��
%  �Ѿ���ͼ��axes�����ŵ�hocupd�У���ͼ��axes�����ŵ�hfree�С�
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



















