function AboutInfo
%  创建一个消息对话框，并修改其尺寸内容。

%  读入图标数据。
[x,map]=imread('sample.jpg');
%  创建一个消息对话框，句柄为h。
h=msgbox_fix({['SwaveSplit 横波分裂相关分析软件'],...
          ['版本：1.0'],...
          ['2012年12月1日'],...
          ['由卞龙开发制作'],...
          ['地址：陕西省 西安市 雁塔路126号长安大学雁塔校区，地测学院，710054'],...
          ['联系方式：0618bianlong@gmail.com']},'关于SwaveSplit','custom',x,map);
%  修改对话框的各参数。
set(h,'Visible','off');
%  有时候对话框中会显示一个空的坐标系（不知道为何），当出现这种情况时，将坐标系删除。
a=findobj(h,'Type','axes');
[m,n]=size(a);
if ( m == 3)
    delete(a(3));
end
%  设定对话框的部分Position参数。
ParentPos=get(gcbf,'Position');  %  gcbf表示正在执行的Callback对应的对象所在窗口的句柄，即handles.figure1的句柄
xoffset=ParentPos(1)+0.27192982*ParentPos(3);
yoffset=ParentPos(2)+0.54597701*ParentPos(4);

set(h,'Units','pixels','Position',[xoffset yoffset 512 174]);
set(findobj(h,'Tag','IconAxes'),'Position',[7 50.875 68 68]);  %  替换图标
set(findobj(h,'Type','text'),'Position',[82 48 0],'FontSize',10);  %  改变文字字体，位置
set(findobj(h,'Style','pushbutton'),'Position',[159.25 8 60 27],'FontSize',10,'String','确定');  %  修改按键
set(h,'Visible','on');
movegui(h);  %  确保对话框出现在屏幕上

