function AboutInfo
%  ����һ����Ϣ�Ի��򣬲��޸���ߴ����ݡ�

%  ����ͼ�����ݡ�
[x,map]=imread('sample.jpg');
%  ����һ����Ϣ�Ի��򣬾��Ϊh��
h=msgbox_fix({['SwaveSplit �Შ������ط������'],...
          ['�汾��1.0'],...
          ['2012��12��1��'],...
          ['�ɱ�����������'],...
          ['��ַ������ʡ ������ ����·126�ų�����ѧ����У�����ز�ѧԺ��710054'],...
          ['��ϵ��ʽ��0618bianlong@gmail.com']},'����SwaveSplit','custom',x,map);
%  �޸ĶԻ���ĸ�������
set(h,'Visible','off');
%  ��ʱ��Ի����л���ʾһ���յ�����ϵ����֪��Ϊ�Σ����������������ʱ��������ϵɾ����
a=findobj(h,'Type','axes');
[m,n]=size(a);
if ( m == 3)
    delete(a(3));
end
%  �趨�Ի���Ĳ���Position������
ParentPos=get(gcbf,'Position');  %  gcbf��ʾ����ִ�е�Callback��Ӧ�Ķ������ڴ��ڵľ������handles.figure1�ľ��
xoffset=ParentPos(1)+0.27192982*ParentPos(3);
yoffset=ParentPos(2)+0.54597701*ParentPos(4);

set(h,'Units','pixels','Position',[xoffset yoffset 512 174]);
set(findobj(h,'Tag','IconAxes'),'Position',[7 50.875 68 68]);  %  �滻ͼ��
set(findobj(h,'Type','text'),'Position',[82 48 0],'FontSize',10);  %  �ı��������壬λ��
set(findobj(h,'Style','pushbutton'),'Position',[159.25 8 60 27],'FontSize',10,'String','ȷ��');  %  �޸İ���
set(h,'Visible','on');
movegui(h);  %  ȷ���Ի����������Ļ��

