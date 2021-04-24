function  v=initSPICEv(METAKR,forceDownload)

% Manel Soria December 2019 
% initSPICEv will:
% 1-Setup the appropriate path to mice code so that you can call it 
% 2-Download the kernels that are not already in the local disk
% 3-Charge the list of kernels to memory
% 
% METAKR is a list of strings, two for each kernel
%   the first string is the web address to download the kernel
%   the second is the name of the kernel file
% e.g., 
%    METAKR={'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls','naif0012.tls', ...
%            'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/vgr1_jup230.bsp','vgr1_jup230.bsp'}
% this function needs the auxiliary osi.m function
% returns the current version as a string

v='1.02';

if nargin==1
    forceDownload=0;
end

HOMESPICE=getHomeSpice;

addpath(osi(strcat(HOMESPICE,'mice/src/mice/')))
addpath(osi(strcat(HOMESPICE,'mice/lib')))


if compareKernels(METAKR)~=1 || forceDownload==1 % all the kernels already loaded !!
    fprintf('A new or different set of kernels has been requested, all them will be reloaded\n');

    endSPICE;

    for i=1:length(METAKR)
        if mod(i,2)==1
            url=METAKR{i};
            continue;
        end
        kfile=osi(sprintf('%s/kernels/%s',HOMESPICE,METAKR{i}));
        if exist(kfile,'file')~=2 || forceDownload==1
            fprintf('downloading %s to %s \n',url,kfile);
            websave(kfile,url);
        end
        fprintf('cspice_furnsh(''%s'')\n',kfile);
        cspice_furnsh(kfile);
    end

else
    
    fprintf('Already got all the kernels requested in memory !\n');
end


end

