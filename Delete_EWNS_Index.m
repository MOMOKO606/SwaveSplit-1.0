function Delete_EWNS_Index(handles)
%  ��ȡ��ǰ��ѡΪEW��NS����ͼ���axes�����
hEW=getappdata(0,'hEW');
hNS=getappdata(0,'hNS');
%  �жϱ�ɾ��ͼ���Ƿ�ѡΪEW��NS�����������Բ������Ҽ��˵����е�����
if (gca == hEW)
    set(handles.ChooseEW,'Checked','off');
    EWindex=0;
    EWtemp=-1;
    hEW=[];
%  ��������Ĳ�����������¡�    
    setappdata(0,'EWindex',EWindex);
    setappdata(0,'EWtemp',EWtemp);
    setappdata(0,'hEW',hEW);
elseif ( gca == hNS )
    set(handles.ChooseNS,'Checked','off');
    NSindex=0;
    NStemp=-1;
    hNS=[];
%  ��������Ĳ�����������¡�    
    setappdata(0,'NSindex',NSindex);
    setappdata(0,'NStemp',NStemp);
    setappdata(0,'hNS',hNS);
end

