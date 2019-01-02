function [xmin,xmax,ymin,ymax]=Boundary(reptdata1)
%  输入参数为reptdata1，利用其中的台站和地震经纬度数据。
%  输出参数为台站地震位置分布图的坐标范围。

%  计算台站坐标与地震坐标的差值：
temp1=[reptdata1(1,:),reptdata1(3,:)];  %  将所有的经度数据放入temp1
temp2=[reptdata1(2,:),reptdata1(4,:)];  %  将所有的纬度数据放入temp2
maxlong=max(temp1);
minlong=min(temp1);
maxlati=max(temp2);
minlati=min(temp2);
x=abs(maxlong-minlong);  %  最大经度差
y=abs(maxlati-minlati);  %  最大纬度差
if ((x/y < 2)&&(x/y > 0.5))
    % 当经度差与纬度差在2倍以内时，将台站与地震放在图的最中间。
    %  横轴范围为台站与地震经度差的2倍；
    %  纵轴范围为台站与地震纬度差的2倍。
    xmin=minlong-0.5*x;
    xmax=maxlong+0.5*x;
    ymin=minlati-0.5*y;
    ymax=maxlati+0.5*y;
elseif (x/y >= 2)
    %  当经度差大于纬度差2倍以上时：
    %  横轴范围为台站与地震经度差的2倍；
    %  纵轴长度与横轴长度一致。
    xmin=minlong-0.5*x;
    xmax=maxlong+0.5*x;
    ymin=(minlati+maxlati-x*2)/2;
    ymax=(minlati+maxlati+x*2)/2;
elseif (x/y <= 0.5)
    %  当纬度差大于经度差2倍以上时：
    %  纵轴范围为台站与地震纬度差的2倍；
    %  横轴长度与纵轴长度一致。
    ymin=minlati-y;
    ymax=maxlati+y;
    xmin=(minlong+maxlong-y*2)/2;
    xmax=(minlong+minlong+y*2)/2;
end
    
