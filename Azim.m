function deg=Azim(STLO,STLA,EVLO,EVLA)
%  Azim函数通过地心纬度法，计算台站相对于震中的方位角deg(°)。
%  STLO,STLA,EVLO,EVLA分别为台站经纬度，震中经纬度。

slo=STLO*pi/180;  %  台站经度（转换为弧度）
sla=LatiTrans(STLA);  %  台站地心余纬度
elo=EVLO*pi/180;  %  震中经度（转换为弧度）
ela=LatiTrans(EVLA);  %  震中地心余纬度
t1=cos(ela)*cos(sla)+sin(ela)*sin(sla)*cos(elo-slo);
t2=sqrt(1-t1^2);
CosValue=(cos(sla)-cos(ela)*t1)/(t2*sin(ela));
SinValue=-sin(sla)*sin(elo-slo)/t2;
deg=InveTrig(SinValue,CosValue);