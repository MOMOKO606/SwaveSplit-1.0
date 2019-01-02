function [inputfile,pltn2,pltn3]=Get_Pltn2(handles,pltn1,PathName,FileName)
%  �������ܣ�
%  1������pltn2��pltn3��
%  2�����ɴ�������ļ�����cell���󣬲��ҽ�ASCII����ʽ�洢�����ݵ��ļ�������Ϊÿ�еı�������
%  ���磬�����ļ���ΪTest.dat;bin.SAC,
%  ���inputfileΪTest2(Test2�д洢Test.dat�еĵ�2������);Test1(Test1�д洢Test.dat�еĵ�1������);bin.SAC��

file=cellstr(strcat(PathName,FileName));  %  ��fileֻ����һ���ַ���ʱ��fileΪ�ַ������飬������Ҫcellstr����������ת��Ϊcell��
FileName=cellstr(FileName);
%  ��pltn2��inputfile����ֵ��
pltn2=0;
inputfile=[];
%  ����pltn2������inputfile��
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
            str=['s',FileName{1,i}(1:end-4),num2str(j)];  %  ��ͷ��s�ַ���Ϊ�˷�ֹ�ļ�����ͷΪ���ֵ����
            x=temp(:,j);
            x=x(~isnan(x));  %  ɾ�������е�NaN
            setappdata(handles.Open,str,x);  %  �������Ϊȫ�ֱ�����������Ϊstr��������ַ�����
            inputfile=strvcat(inputfile,str);
        end
    end
end
inputfile=cellstr(inputfile);  
inputfile=inputfile';
%  ����pltn3��
pltn3=pltn1+pltn2;