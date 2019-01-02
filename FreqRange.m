function answer=FreqRange
%  载入hd得到截止频率。
hd=getappdata(gca,'hd');
sps=1/hd{1,1}(1,1);
f=num2str(sps/2);
%  判断常见仪器类型并给出相应的频率范围默认值:
%  B表示宽频带；L表示长周期；S表示短周期。
str=hd{22,1}(1,1);
switch str
    case 'B'
        defAns={num2str(0.0083),f};
    case 'L'
        defAns={num2str(0.03),f};
    case 'S'
        defAns={num2str(0.3),f};
    otherwise
        defAns={'',''};
end
%  创建输入对话框，结果返回answer中。   
prompt={'起始频率(Hz)：','截止频率(Hz)：'};
dlg_title='滤波器通带范围';
answer=inputdlg_fix(prompt,dlg_title,1,defAns,'on');
