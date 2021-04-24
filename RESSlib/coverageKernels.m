function twall=coverageKernels(qt,qobj)
% Manel Soria - Roger Sala - Dec 2019 - UPC
% checkKernels(qt,qobj)
%returns full coverage for kernels qt (SPK or CK) and object obj (string)

info=0;

if strcmp(qt,'SPK')~=1 && strcmp(qt,'CK')~=1
    error('Only SPK and CK kernels supported');
end

if strcmp(qt,'CK')==1
    error('CK not implemented yet (Roger is to blame :) ');
end

count = cspice_ktotal( 'ALL' );

nk=0; % number of kernels covering our target

for i = 1:count
 
[ file, type, source, handle, found ] = cspice_kdata( i, 'ALL');

%fprintf('%d %s %s %\n',i,file,type,source),

    if ( ~found )
        error('uhhh ?');
    end

    if strcmp(type,'SPK')==1 % SPK kernel
        objs=cspice_spkobj(file,1000); % get list of objects
        for b=1:numel(objs)
            if strcmp(cspice_bodc2n(objs(b)),qobj)==1 % our target is covered by this kernel
                nk=nk+1; % we have one kernel more
                tw=cspice_spkcov(file,objs(b),1000); % get the time window covered by this kernel
                if nk>1 
                    twall = cspice_wnunid( twall, tw ); % not the first, call union
                else
                    twall = tw; % the first, initialize
                end
                if info==1
                    for k=1:2:numel(tw)
                        fprintf('%d tw    %s %s to %s \n',numel(tw)   ,cspice_bodc2n(objs(b)),cspice_et2utc(tw(k),'C',0),cspice_et2utc(tw(k+1),'C',0));
                    end
                    for k=1:2:numel(twall)
                        fprintf('%d twall %s %s to %s \n',numel(twall),cspice_bodc2n(objs(b)),cspice_et2utc(twall(k),'C',0),cspice_et2utc(twall(k+1),'C',0));
                    end
                end
            end
        end
    end
 

    if nk==0
        twall=[];
    end

end
