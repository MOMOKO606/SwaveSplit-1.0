function d=Deriva(x,y,delta)
%  对y数据关于x求导。
%  注意数据为等间隔数据，且x相互间隔为delta。
%  首先对被求导数据进行三次样条插值，之后在时域内进行中心差分。
%  地震数据应先消除零点漂移、线性漂移。
n=length(x);
xx=[x(1):delta/2:x(n)+delta/2];
yy=interp1(x,y,xx,'*spline');
temp=2*(yy(2)-yy(1))/delta;
yy=yy(2:2:2*n)';
d=diff(yy)./delta;
d=[temp;d];