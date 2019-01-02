function [c,cmax,cmin]=Correlation(EWdata,NSdata,ds,dsl,df,t1,t2,t3)
n=length(EWdata);
c=[];
cmax=[];
cmin=[];
for i=ds:dsl:df
    x=i*pi/180;
    %  旋转角度x，2列波旋转后的值为qs1、qs2。
    qs1=NSdata*sin(x)+EWdata*cos(x);
    qs2=NSdata*cos(x)-EWdata*sin(x);
    %  计算归一化相关值
    q=xcorr(qs1,qs2,'coeff');
    q=q(n+t1:t3:n+t2);
    c=[c,q];
    %  找出每个旋转角度的最大、最小相关值。
    cmax=[cmax,max(q)];
    cmin=[cmin,min(q)];
end