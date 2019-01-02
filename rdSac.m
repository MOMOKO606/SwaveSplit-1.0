function [hd,stime,sdata]=rdSac(SACfile)
%  rdSac(SACfile) reads both binary and alphanumeric formats of SAC(seismic
%  analysis code) data files.
%  The byte order of the SAC data files could be both big-endian and
%  little-endian.
%  Read header variables in hd matrix.
%  Read amplitude values in sdata array.
%  Read time values in stime array.
%  By BianLong(2012)    0618bianlong@gmail.com
form='binary';
endian='ieee-be';
fid=fopen(SACfile,'r');
if fid<0
    error('Can not open the SACfile!')
end
for i=1:77
    nvhdr=fread(fid,1,'int32',endian);
end
fclose(fid);
%  Check the storage format and header version of the SAC file then read the npts.
%  if the nvhdr==538976288 then the SAC file is likely stored in ASCII format.
%  if the header version is not nvhdr==6 then the SAC file is likely of the opposite
%  byte order(default byte order is big-endian).  This would make nvhdr ridiculously 
%  large or small.nvhdr can also be 4 or 5.  In this case it is an old SAC file and
%  rdSac(SACfile) cannot read this file in.  
if (nvhdr == 4 || nvhdr == 5)
    message=strcat(SACfile,'may be from an old version of SAC.');
    error(message)
elseif (nvhdr == 538976288)
    form='ASCII';
elseif (nvhdr ~= 6 && nvhdr ~= 538976288)
    endian='ieee-le';
end
switch form
    case('binary')
        fid=fopen(SACfile,'r',endian);
        temp=fread(fid,70,'float32');
        temp(71:110)=fread(fid,40,'int32');
        str=fread(fid,[8,24],'char');
        sdata=fread(fid,inf,'float32');
        fclose(fid);
        str=char(str');
        hd(1,1)={temp};
        for i=1:24
            hd(i+1,1)={str(i,:)};
        end
    case('ASCII')
        hd=importdata(SACfile);
        hd=hd';
        hd=hd(:);
        [a,b,c]=textread(SACfile,'%s %s %s',8,'headerlines',22);
        temp=[a,b,c];
        temp=reshape(temp',[],1);
        hd=[hd;temp];
        fid=fopen(SACfile','r');
        for i=1:30
            tline=fgetl(fid);
        end
        sdata=fscanf(fid,'%f');
        fclose(fid);
end
delta=hd{1,1}(1,1);
npts=hd{1,1}(80,1);
stime=[0:delta:delta*(npts-1)]';



        


