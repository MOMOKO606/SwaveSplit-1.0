function deg=InveTrig(SinValue,CosValue)
%  反正弦函数（asin）的值域是[-π/2,π/2]；
%  反余弦函数(acos)的值域是[0，π]；
%  InveTrig函数通过一个正弦函数值SinValue，和一个余弦函数值CosValue来确定一个[0，2π]
%  范围内的角度值deg(°)。
if (SinValue >= 0 && SinValue <= 1)
    deg=acos(CosValue)*180/pi;
elseif (SinValue >= -1 && SinValue < 0)
    deg=360-acos(CosValue)*180/pi;
end