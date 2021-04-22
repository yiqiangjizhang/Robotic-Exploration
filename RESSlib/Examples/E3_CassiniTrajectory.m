close all; 

% Recall that RESSlib should be in Matlab Path 

% TODO: improve pictures quality

% First we download a list of ALL Cassini spk kernels, if it is not
% available
if ~isfile('CassiniAll.mat')
    % This code fragment downloads a list of all R_SCPSE Cassini kernels
    % and saves it in CassiniMat.mat file
    % aareadme.txt contains a description of the kernels 
    host='naif.jpl.nasa.gov'; % host
    homekernels='/pub/naif/CASSINI/kernels/spk/'; % folder
    ftpobj = ftp(host); % open server
    cd(ftpobj,homekernels); % go to folder
    allk=dir(ftpobj); % ls
    MK={};
    for i=1:length(allk)
        if contains(allk(i).name,'R_SCPSE') % R: Reconstructed 
            fprintf('%s  \n',allk(i).name );
            MK{end+1}=sprintf('https://%s%s%s',host,homekernels,allk(i).name);
        end
    end

    save('CassiniAll.mat','MK');
else % otherwise, load it
    load('CassiniAll.mat');
end


% Add additional kernels also needed

MK{end+1}='https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls';


for i=1:numel(MK)
    fprintf('\"%s\", \n',MK{i});
end


initSPICEv(fullK(MK)); % fullK forms the full list needed by initSPICEv

 
%% 1-plot all the trajectory available of these bodies respect to observer
if 1
    figure(1);
    OB={'CASSINI','EARTH','JUPITER','SATURN','VENUS','TITAN','IO','MOON'};
      %'cejsvtio'
    co='kbmgrrrr';

    frame = 'ECLIPJ2000';
    abcorr = 'NONE';
    observer='SUN';

    for b=1:numel(OB)
        sc=OB{b};
        tw  =coverageKernels('SPK',sc);          % coverage of the body
        two =coverageKernels('SPK',observer);  % coverage of the observer
        twi =cspice_wnintd(tw,two); % intersection of both
        for i=1:2:numel(twi)
            fprintf('<%s> and <%s> From %s to %s \n',sc,observer,cspice_et2utc(twi(i),'C',1),cspice_et2utc(twi(i+1),'C',1));
            et=linspace(twi(i),twi(i+1),8000);
            [d,lt]=cspice_spkezr(sc,et,frame,abcorr,observer);
            plot3(d(1,:),d(2,:),d(3,:),strcat('-',co(b)) );
            hold on
        end
    end
end

%% 2-plot the distance between Cassini and Saturn in all the available range
if 1
    figure(2);
    sr=58300; % km, mean(radii)
    tw1  =coverageKernels('SPK','CASSINI');         
    tw2  =coverageKernels('SPK','SATURN');         
    twi =cspice_wnintd(tw1,tw2); % intersection of both
    frame = 'ECLIPJ2000';
    abcorr = 'NONE';
    observer='SUN';
    for i=1:2:numel(twi)
        et=linspace(twi(i),twi(i+1),8000);
        [d1,lt]=cspice_spkezr('CASSINI',et,frame,abcorr,observer);
        [d2,lt]=cspice_spkezr('SATURN',et,frame,abcorr,observer);
        d=d1-d2;
        d=d(1:3,:);
        nd=vecnorm(d);
        semilogy(et,nd/sr);
        hold on
        mm=min(nd);
        if i==1
           Gmin=mm;
        else
           Gmin=min([Gmin mm]);
        end
    end
    fprintf('Minimum Saturn - Cassini distance Gmin=%e in Saturn Radius (%e km)\n',Gmin/sr,sr);
end