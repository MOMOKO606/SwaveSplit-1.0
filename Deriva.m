function d=Deriva(x,y,delta)
%  ��y���ݹ���x�󵼡�
%  ע������Ϊ�ȼ�����ݣ���x�໥���Ϊdelta��
%  ���ȶԱ������ݽ�������������ֵ��֮����ʱ���ڽ������Ĳ�֡�
%  ��������Ӧ���������Ư�ơ�����Ư�ơ�
n=length(x);
xx=[x(1):delta/2:x(n)+delta/2];
yy=interp1(x,y,xx,'*spline');
temp=2*(yy(2)-yy(1))/delta;
yy=yy(2:2:2*n)';
d=diff(yy)./delta;
d=[temp;d];