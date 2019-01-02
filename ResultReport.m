function ResultReport(handles,haxes,hfigure,maxcoef,t,deg)
%  haxes为进行相关分析的EW分量波形图或NS分量波形图的axes句柄；
%  maxcoef为最大相关值；
%  t为慢波时间延迟；
%  deg为快波偏振方向。

%  读取输出形式参数。
report_index=getappdata(0,'report_index');
%  获得生成报告需要的参数。
hd=getappdata(haxes,'hd');
slong=hd{1,1}(33,1);    %  Station longitude (degrees, east positive).
slati=hd{1,1}(32,1);    %  Station latitude (degrees, north positive).
elong=hd{1,1}(37,1);    %  Event longitude (degrees, east positive). 
elati=hd{1,1}(36,1);    %  Event latitude (degrees, north positive). 
ST=hd{1,1}(71:76,1);   %  Time corresponding to reference (zero) time in file.
[StartData,StartTime]=SacTime(ST);
KSTNM=hd{2,1};         %  Station name.
t1=get(handles.edit1,'String');
t2=get(handles.edit2,'String');
temp=str2num(t2)-str2num(t1);
d1=get(handles.edit3,'String');
d2=get(handles.edit4,'String');
d3=get(handles.edit5,'String');
t3=get(handles.edit6,'String');
t4=get(handles.edit7,'String');
t5=get(handles.edit8,'String');
%  filename为文档名。
ti=now;
str=datestr(ti,0);
str0=[str(1:12),str(13:14),'h',str(16:17),'min',str(19:20),'s'];
str1=str(1:12);
if (report_index == 0)
    str=str0;
else
    str=str1;
end
path=getappdata(0,'path2');
filename=[path,'\横波分裂相关分析结果报告',32,str,'.doc'];
%  创建Microsoft Word服务器。
Word=actxserver('Word.Application'); 
%  当函数运行完后，关闭Microsoft Word服务器。
c=onCleanup(@()Word.Quit);
% 若测试文件存在，打开该word文件，否则，新建一个文件，并保存。
if exist(filename,'file'); 
    Document=Word.Documents.Open(filename);     
else
    Document=Word.Documents.Add;     
    Document.SaveAs(filename);
end

Content=Document.Content;  %  返回Content接口句柄
Selection=Word.Selection;  %  返回Selection接口句柄
%  将光标位置移到文本的最后。
Selection.Start=Content.end;  
%  绘制表格，在光标所在位置插入一个14行6列的表格，并返回句柄DTI。
DTI=Document.Tables.Add(Selection.Range,14,6);  
%  设置表格边框
DTI.Borders.OutsideLineStyle='wdLineStyleSingle';
DTI.Borders.InsideLineStyle='wdLineStyleSingle';
DTI.Rows.Item(14).Borders.Item(1).LineStyle='wdLineStyleNone';  %  将第15行的上边框线删除
DTI.Rows.Alignment='wdAlignRowCenter';  %  令表格居中
%  设置表格列宽
column_width=[53.7736,84.1434,53.7736,84.1434,53.7736,84.1434];
for i=1:6
    DTI.Columns.Item(i).Width=column_width(i);
end
%  合并单元格。
DTI.Cell(1,1).Merge(DTI.Cell(1,6));
DTI.Cell(2,1).Merge(DTI.Cell(2,6));
for i=5:9
    DTI.Cell(i,1).Merge(DTI.Cell(i,6));
end
for i=10:12
    DTI.Cell(i,1).Merge(DTI.Cell(i,3));
    DTI.Cell(i,2).Merge(DTI.Cell(i,4));
end
DTI.Cell(13,1).Merge(DTI.Cell(13,6));
DTI.Cell(14,1).Merge(DTI.Cell(14,6));
%  设置表格内的文字位置，大小等信息。
DTI.Range.Font.Size=10.5;  %  全文设置为五号字
DTI.Cell(1,1).Range.Paragraphs.Alignment='wdAlignParagraphCenter';  %  第1行居中
DTI.Cell(1,1).Range.Font.Size=26;  %  第一行用三号字
DTI.Cell(1,1).Range.Font.Bold=4;  %  字体加粗
for i=3:4
    for j=1:6
        DTI.Cell(i,j).Range.Paragraphs.Alignment='wdAlignParagraphCenter';  %  3到4行字体居中
    end
end
for i=10:12
    for j=1:2
        DTI.Cell(i,j).Range.Paragraphs.Alignment='wdAlignParagraphCenter';  %  字体居中
    end
end
DTI.Cell(14,1).Range.Paragraphs.Alignment='wdAlignParagraphRight';  %  第14行右对齐
%  写入表格内容。
%  表格标题部分
DTI.Cell(1,1).Range.Text='相关分析结果报告';  %  表格标题内容
%  基本信息部分
DTI.Cell(2,1).Range.Text='基本信息：';
DTI.Cell(3,1).Range.Text='台站名称';
DTI.Cell(3,2).Range.Text=KSTNM;
DTI.Cell(3,3).Range.Text='台站经度';
DTI.Cell(3,4).Range.Text=num2str(slong);
DTI.Cell(3,5).Range.Text='台站纬度';
DTI.Cell(3,6).Range.Text=num2str(slati);
DTI.Cell(4,1).Range.Text='地震事件时间';
DTI.Cell(4,2).Range.Text=[StartData,32,32,StartTime];
DTI.Cell(4,3).Range.Text='事件经度';
DTI.Cell(4,4).Range.Text=num2str(elong);
DTI.Cell(4,5).Range.Text='事件纬度';
DTI.Cell(4,6).Range.Text=num2str(elati);
DTI.Cell(5,1).Range.Text='用户输入参数：';
DTI.Cell(6,1).Range.Text=['截取',t1,'s～',t2,'s，',num2str(temp),'s长的波形。'];
DTI.Cell(7,1).Range.Text=['旋转角度变化范围：',d1,'°～',d2,'°，步长间隔',d3,'°。'];
DTI.Cell(8,1).Range.Text=['时间延迟变化范围：',t3,'s～',t4,'s，步长间隔',t5,'s。'];
DTI.Cell(9,1).Range.Text='计算结果：';
DTI.Cell(10,1).Range.Text='最大相关值：';
DTI.Cell(10,2).Range.Text=num2str(maxcoef);
DTI.Cell(11,1).Range.Text='快波偏振方向：';
DTI.Cell(11,2).Range.Text=[num2str(deg),'°'];
DTI.Cell(12,1).Range.Text='慢波时间延迟：';
DTI.Cell(12,2).Range.Text=[num2str(t),'s'];
DTI.Cell(14,1).Range.Text=str0;
%  将图形复制到粘贴板。
hgexport(hfigure, '-clipboard');
%  在第13行单元格贴图。
DTI.Cell(13,1).Range.Paragraphs.Item(1).Range.Paste;

Selection.Start=Content.end;  %  将光标移动到文本最后
Selection.TypeParagraph;  %  回车
%  保存文档。
Document.Save;     
Document.Close;  %  关闭Word文件，否则第二次及以后输入时，服务器界面将可见