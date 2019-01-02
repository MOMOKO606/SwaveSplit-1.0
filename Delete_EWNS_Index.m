function Delete_EWNS_Index(handles)
%  读取当前被选为EW、NS分量图像的axes句柄。
hEW=getappdata(0,'hEW');
hNS=getappdata(0,'hNS');
%  判断被删除图像是否被选为EW、NS分量，进而对参数和右键菜单进行调整。
if (gca == hEW)
    set(handles.ChooseEW,'Checked','off');
    EWindex=0;
    EWtemp=-1;
    hEW=[];
%  将调整后的参数、句柄更新。    
    setappdata(0,'EWindex',EWindex);
    setappdata(0,'EWtemp',EWtemp);
    setappdata(0,'hEW',hEW);
elseif ( gca == hNS )
    set(handles.ChooseNS,'Checked','off');
    NSindex=0;
    NStemp=-1;
    hNS=[];
%  将调整后的参数、句柄更新。    
    setappdata(0,'NSindex',NSindex);
    setappdata(0,'NStemp',NStemp);
    setappdata(0,'hNS',hNS);
end

