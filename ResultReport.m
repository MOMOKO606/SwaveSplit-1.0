function ResultReport(handles,haxes,hfigure,maxcoef,t,deg)
%  haxesΪ������ط�����EW��������ͼ��NS��������ͼ��axes�����
%  maxcoefΪ������ֵ��
%  tΪ����ʱ���ӳ٣�
%  degΪ�첨ƫ����

%  ��ȡ�����ʽ������
report_index=getappdata(0,'report_index');
%  ������ɱ�����Ҫ�Ĳ�����
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
%  filenameΪ�ĵ�����
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
filename=[path,'\�Შ������ط����������',32,str,'.doc'];
%  ����Microsoft Word��������
Word=actxserver('Word.Application'); 
%  ������������󣬹ر�Microsoft Word��������
c=onCleanup(@()Word.Quit);
% �������ļ����ڣ��򿪸�word�ļ��������½�һ���ļ��������档
if exist(filename,'file'); 
    Document=Word.Documents.Open(filename);     
else
    Document=Word.Documents.Add;     
    Document.SaveAs(filename);
end

Content=Document.Content;  %  ����Content�ӿھ��
Selection=Word.Selection;  %  ����Selection�ӿھ��
%  �����λ���Ƶ��ı������
Selection.Start=Content.end;  
%  ���Ʊ���ڹ������λ�ò���һ��14��6�еı�񣬲����ؾ��DTI��
DTI=Document.Tables.Add(Selection.Range,14,6);  
%  ���ñ��߿�
DTI.Borders.OutsideLineStyle='wdLineStyleSingle';
DTI.Borders.InsideLineStyle='wdLineStyleSingle';
DTI.Rows.Item(14).Borders.Item(1).LineStyle='wdLineStyleNone';  %  ����15�е��ϱ߿���ɾ��
DTI.Rows.Alignment='wdAlignRowCenter';  %  �������
%  ���ñ���п�
column_width=[53.7736,84.1434,53.7736,84.1434,53.7736,84.1434];
for i=1:6
    DTI.Columns.Item(i).Width=column_width(i);
end
%  �ϲ���Ԫ��
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
%  ���ñ���ڵ�����λ�ã���С����Ϣ��
DTI.Range.Font.Size=10.5;  %  ȫ������Ϊ�����
DTI.Cell(1,1).Range.Paragraphs.Alignment='wdAlignParagraphCenter';  %  ��1�о���
DTI.Cell(1,1).Range.Font.Size=26;  %  ��һ����������
DTI.Cell(1,1).Range.Font.Bold=4;  %  ����Ӵ�
for i=3:4
    for j=1:6
        DTI.Cell(i,j).Range.Paragraphs.Alignment='wdAlignParagraphCenter';  %  3��4���������
    end
end
for i=10:12
    for j=1:2
        DTI.Cell(i,j).Range.Paragraphs.Alignment='wdAlignParagraphCenter';  %  �������
    end
end
DTI.Cell(14,1).Range.Paragraphs.Alignment='wdAlignParagraphRight';  %  ��14���Ҷ���
%  д�������ݡ�
%  �����ⲿ��
DTI.Cell(1,1).Range.Text='��ط����������';  %  ����������
%  ������Ϣ����
DTI.Cell(2,1).Range.Text='������Ϣ��';
DTI.Cell(3,1).Range.Text='̨վ����';
DTI.Cell(3,2).Range.Text=KSTNM;
DTI.Cell(3,3).Range.Text='̨վ����';
DTI.Cell(3,4).Range.Text=num2str(slong);
DTI.Cell(3,5).Range.Text='̨վγ��';
DTI.Cell(3,6).Range.Text=num2str(slati);
DTI.Cell(4,1).Range.Text='�����¼�ʱ��';
DTI.Cell(4,2).Range.Text=[StartData,32,32,StartTime];
DTI.Cell(4,3).Range.Text='�¼�����';
DTI.Cell(4,4).Range.Text=num2str(elong);
DTI.Cell(4,5).Range.Text='�¼�γ��';
DTI.Cell(4,6).Range.Text=num2str(elati);
DTI.Cell(5,1).Range.Text='�û����������';
DTI.Cell(6,1).Range.Text=['��ȡ',t1,'s��',t2,'s��',num2str(temp),'s���Ĳ��Ρ�'];
DTI.Cell(7,1).Range.Text=['��ת�Ƕȱ仯��Χ��',d1,'�㡫',d2,'�㣬�������',d3,'�㡣'];
DTI.Cell(8,1).Range.Text=['ʱ���ӳٱ仯��Χ��',t3,'s��',t4,'s���������',t5,'s��'];
DTI.Cell(9,1).Range.Text='��������';
DTI.Cell(10,1).Range.Text='������ֵ��';
DTI.Cell(10,2).Range.Text=num2str(maxcoef);
DTI.Cell(11,1).Range.Text='�첨ƫ����';
DTI.Cell(11,2).Range.Text=[num2str(deg),'��'];
DTI.Cell(12,1).Range.Text='����ʱ���ӳ٣�';
DTI.Cell(12,2).Range.Text=[num2str(t),'s'];
DTI.Cell(14,1).Range.Text=str0;
%  ��ͼ�θ��Ƶ�ճ���塣
hgexport(hfigure, '-clipboard');
%  �ڵ�13�е�Ԫ����ͼ��
DTI.Cell(13,1).Range.Paragraphs.Item(1).Range.Paste;

Selection.Start=Content.end;  %  ������ƶ����ı����
Selection.TypeParagraph;  %  �س�
%  �����ĵ���
Document.Save;     
Document.Close;  %  �ر�Word�ļ�������ڶ��μ��Ժ�����ʱ�����������潫�ɼ�