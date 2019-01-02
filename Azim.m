function deg=Azim(STLO,STLA,EVLO,EVLA)
%  Azim����ͨ������γ�ȷ�������̨վ��������еķ�λ��deg(��)��
%  STLO,STLA,EVLO,EVLA�ֱ�Ϊ̨վ��γ�ȣ����о�γ�ȡ�

slo=STLO*pi/180;  %  ̨վ���ȣ�ת��Ϊ���ȣ�
sla=LatiTrans(STLA);  %  ̨վ������γ��
elo=EVLO*pi/180;  %  ���о��ȣ�ת��Ϊ���ȣ�
ela=LatiTrans(EVLA);  %  ���е�����γ��
t1=cos(ela)*cos(sla)+sin(ela)*sin(sla)*cos(elo-slo);
t2=sqrt(1-t1^2);
CosValue=(cos(sla)-cos(ela)*t1)/(t2*sin(ela));
SinValue=-sin(sla)*sin(elo-slo)/t2;
deg=InveTrig(SinValue,CosValue);