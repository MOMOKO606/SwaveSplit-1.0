function t=TrapInt(y,delta)
%  ��y�������λ��֡�
%  ע������Ϊ�ȼ�����ݣ���x�໥���Ϊdelta��
%  ��������Ӧ���������Ư�ơ�����Ư�ơ�
n=length(y);
for i=1:n-1
    t(i)=delta*(y(i)+y(i+1))/2.0;
end
t(n)=delta*(y(1)+y(n))/2.0;
t=cumsum(t');