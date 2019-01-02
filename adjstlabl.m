function adjstlabl(handles,EWindex,NSindex,hEW,hNS)
 set(handles.ChooseEW,'enable','on');
 set(handles.ChooseNS,'enable','on');
 if ((EWindex == 1) && (NSindex == 0))
     if (gca == hEW)
        set(handles.ChooseNS,'enable','off');
     else
        set(handles.ChooseEW,'enable','off');
     end
 elseif ((EWindex == 0) && (NSindex == 1))
    if (gca == hNS)
        set(handles.ChooseEW,'enable','off');
    else
        set(handles.ChooseNS,'enable','off');
    end
 elseif (EWindex+NSindex == 2)
    if (gca == hEW)
        set(handles.ChooseNS,'enable','off');
    elseif (gca == hNS)
        set(handles.ChooseEW,'enable','off');
    else
        set(handles.ChooseEW,'enable','off');
        set(handles.ChooseNS,'enable','off');
    end
 end