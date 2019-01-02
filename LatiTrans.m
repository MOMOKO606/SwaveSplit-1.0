function y=LatiTrans(x)
%  纬度转换函数：
%  输入参数x为地理纬度(角度单位)，输出参数y为地心余纬度（弧度单位）。
%  x为正表示北纬，x为负表示南纬。

%  赋值地球扁率。
oblat=1/298.25;  %  oblateness of the earth
x=x*pi/180;  %  转换为弧度
t=atan(tan(x)*(1-oblat)^2);  %  将地理纬度转换为地心纬度
%  转换为地心余纬度。
y=pi/2-t;