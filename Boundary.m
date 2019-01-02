function [xmin,xmax,ymin,ymax]=Boundary(reptdata1)
%  �������Ϊreptdata1���������е�̨վ�͵���γ�����ݡ�
%  �������Ϊ̨վ����λ�÷ֲ�ͼ�����귶Χ��

%  ����̨վ�������������Ĳ�ֵ��
temp1=[reptdata1(1,:),reptdata1(3,:)];  %  �����еľ������ݷ���temp1
temp2=[reptdata1(2,:),reptdata1(4,:)];  %  �����е�γ�����ݷ���temp2
maxlong=max(temp1);
minlong=min(temp1);
maxlati=max(temp2);
minlati=min(temp2);
x=abs(maxlong-minlong);  %  ��󾭶Ȳ�
y=abs(maxlati-minlati);  %  ���γ�Ȳ�
if ((x/y < 2)&&(x/y > 0.5))
    % �����Ȳ���γ�Ȳ���2������ʱ����̨վ��������ͼ�����м䡣
    %  ���᷶ΧΪ̨վ����𾭶Ȳ��2����
    %  ���᷶ΧΪ̨վ�����γ�Ȳ��2����
    xmin=minlong-0.5*x;
    xmax=maxlong+0.5*x;
    ymin=minlati-0.5*y;
    ymax=maxlati+0.5*y;
elseif (x/y >= 2)
    %  �����Ȳ����γ�Ȳ�2������ʱ��
    %  ���᷶ΧΪ̨վ����𾭶Ȳ��2����
    %  ���᳤������᳤��һ�¡�
    xmin=minlong-0.5*x;
    xmax=maxlong+0.5*x;
    ymin=(minlati+maxlati-x*2)/2;
    ymax=(minlati+maxlati+x*2)/2;
elseif (x/y <= 0.5)
    %  ��γ�Ȳ���ھ��Ȳ�2������ʱ��
    %  ���᷶ΧΪ̨վ�����γ�Ȳ��2����
    %  ���᳤�������᳤��һ�¡�
    ymin=minlati-y;
    ymax=maxlati+y;
    xmin=(minlong+maxlong-y*2)/2;
    xmax=(minlong+minlong+y*2)/2;
end
    
