function y=RemvTransf(ResFile,delta,sdata)
%  读参数
fid=fopen(ResFile);
nz=fscanf(fid,'%d',1);
for i=1:nz
    x=fscanf(fid,'%g %g',2);
    zero(i)=complex(x(1),x(2));
end
np=fscanf(fid,'%d',1);
for i=1:np
    x=fscanf(fid,'%g %g',2);
    pole(i)=complex(x(1),x(2));
end
a0=fscanf(fid,'%f',1);
gain=fscanf(fid,'%f',1);
%  频率  
fs=1/delta;
n=length(sdata);
nn=2^nextpow2(n);
f=[0:nn-1]*(fs/nn)*2*pi;
%  系统函数
h=freqs(zero,pole,f')*a0*gain;
%  去除系统函数
y=real(ifft(fft(sdata,nn)./h));
y=y(1:n);

