function answer=FreqRange
%  ����hd�õ���ֹƵ�ʡ�
hd=getappdata(gca,'hd');
sps=1/hd{1,1}(1,1);
f=num2str(sps/2);
%  �жϳ����������Ͳ�������Ӧ��Ƶ�ʷ�ΧĬ��ֵ:
%  B��ʾ��Ƶ����L��ʾ�����ڣ�S��ʾ�����ڡ�
str=hd{22,1}(1,1);
switch str
    case 'B'
        defAns={num2str(0.0083),f};
    case 'L'
        defAns={num2str(0.03),f};
    case 'S'
        defAns={num2str(0.3),f};
    otherwise
        defAns={'',''};
end
%  ��������Ի��򣬽������answer�С�   
prompt={'��ʼƵ��(Hz)��','��ֹƵ��(Hz)��'};
dlg_title='�˲���ͨ����Χ';
answer=inputdlg_fix(prompt,dlg_title,1,defAns,'on');
