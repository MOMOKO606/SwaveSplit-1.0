function deg=InveTrig(SinValue,CosValue)
%  �����Һ�����asin����ֵ����[-��/2,��/2]��
%  �����Һ���(acos)��ֵ����[0����]��
%  InveTrig����ͨ��һ�����Һ���ֵSinValue����һ�����Һ���ֵCosValue��ȷ��һ��[0��2��]
%  ��Χ�ڵĽǶ�ֵdeg(��)��
if (SinValue >= 0 && SinValue <= 1)
    deg=acos(CosValue)*180/pi;
elseif (SinValue >= -1 && SinValue < 0)
    deg=360-acos(CosValue)*180/pi;
end