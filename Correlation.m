function [c,cmax,cmin]=Correlation(EWdata,NSdata,ds,dsl,df,t1,t2,t3)
n=length(EWdata);
c=[];
cmax=[];
cmin=[];
for i=ds:dsl:df
    x=i*pi/180;
    %  ��ת�Ƕ�x��2�в���ת���ֵΪqs1��qs2��
    qs1=NSdata*sin(x)+EWdata*cos(x);
    qs2=NSdata*cos(x)-EWdata*sin(x);
    %  �����һ�����ֵ
    q=xcorr(qs1,qs2,'coeff');
    q=q(n+t1:t3:n+t2);
    c=[c,q];
    %  �ҳ�ÿ����ת�Ƕȵ������С���ֵ��
    cmax=[cmax,max(q)];
    cmin=[cmin,min(q)];
end