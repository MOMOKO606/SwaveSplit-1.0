function y=RemvTransf(ResFile,delta,sdata)
%  ������
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
%  Ƶ��  
fs=1/delta;
n=length(sdata);
nn=2^nextpow2(n);
f=[0:nn-1]*(fs/nn)*2*pi;
%  ϵͳ����
h=freqs(zero,pole,f')*a0*gain;
%  ȥ��ϵͳ����
y=real(ifft(fft(sdata,nn)./h));
y=y(1:n);

