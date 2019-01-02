function t=TrapInt(y,delta)
%  对y进行梯形积分。
%  注意数据为等间隔数据，且x相互间隔为delta。
%  地震数据应先消除零点漂移、线性漂移。
n=length(y);
for i=1:n-1
    t(i)=delta*(y(i)+y(i+1))/2.0;
end
t(n)=delta*(y(1)+y(n))/2.0;
t=cumsum(t');