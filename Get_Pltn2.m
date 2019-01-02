function [inputfile,pltn2,pltn3]=Get_Pltn2(handles,pltn1,PathName,FileName)
%  函数功能：
%  1、计算pltn2和pltn3。
%  2、生成存放输入文件名的cell矩阵，并且将ASCII码形式存储的数据的文件名更改为每列的变量名。
%  例如，输入文件名为Test.dat;bin.SAC,
%  结果inputfile为Test2(Test2中存储Test.dat中的第2列数据);Test1(Test1中存储Test.dat中的第1列数据);bin.SAC。

file=cellstr(strcat(PathName,FileName));  %  当file只包含一个字符串时，file为字符串数组，所以需要cellstr函数将其先转换为cell。
FileName=cellstr(FileName);
%  给pltn2和inputfile赋初值。
pltn2=0;
inputfile=[];
%  计算pltn2并生成inputfile。
for i=1:length(file);
    sac_index=strcmpi(file{1,i}(end-3:end),'.SAC');
    if (sac_index == 1)
        pltn2=pltn2+sac_index;
        inputfile=strvcat(inputfile,file{1,i});  
    else
        temp=importdata(file{1,i});
        [m,asc_index]=size(temp);
        pltn2=pltn2+asc_index;
        for j=asc_index:-1:1
            str=['s',FileName{1,i}(1:end-4),num2str(j)];  %  开头加s字符是为了防止文件名开头为数字的情况
            x=temp(:,j);
            x=x(~isnan(x));  %  删除数组中的NaN
            setappdata(handles.Open,str,x);  %  将数组存为全局变量，变量名为str所代表的字符串。
            inputfile=strvcat(inputfile,str);
        end
    end
end
inputfile=cellstr(inputfile);  
inputfile=inputfile';
%  计算pltn3。
pltn3=pltn1+pltn2;