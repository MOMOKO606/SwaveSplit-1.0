function [StartData,StartTime]=SacTime(ST)
%  SacTime reads time corresponding to reference (zero) time in SAC file.
%  判断闰年的方法：符合以下条件之一的年份即为闰年，1、能被4整除而不能被100整除。
%  2、能被400整除。
year=ST(1,1);
x=ST(2,1);
feb=28;
if (mod(year,400)==0||(mod(year,4)==0 && mod(year,100)~=100))
    feb=29;
end
n=31+feb;
if (1<=x && x<=31)
    month=1;
    day=x;
elseif (31<x && x<=n)
    month=2;
    day=x-31;
elseif (n<x && x<=n+31)
    month=3;
    day=x-n;
elseif (n+31<x && x<=n+61)
    month=4;
    day=x-n-31;
elseif (n+61<x && x<=n+92)
    month=5;
    day=x-n-61;
elseif (n+92<x && x<=n+122)
    month=6;
    day=x-n-92;
elseif (n+122<x && x<=n+153)
    month=7;
    day=x-n-122;
elseif (n+153<x && x<=n+184)
    month=8;
    day=x-n-153;
elseif (n+184<x && x<=n+214)
    month=9;
    day=x-n-184;
elseif (n+214<x && x<=n+245)
    month=10;
    day=x-n-214;
elseif (n+245<x && x<=n+275)
    month=11;
    day=x-n-245;
elseif (n+275<x && x<=n+306)
    month=12;
    day=x-n-275;
end
hour=ST(3,1);
min=ST(4,1);
sec=ST(5,1)+ST(6,1)/1000;
StartData=strcat(num2str(year),'-',num2str(month),'-',num2str(day));
StartTime=strcat(num2str(hour),'h',num2str(min),'m',num2str(sec),'s');



