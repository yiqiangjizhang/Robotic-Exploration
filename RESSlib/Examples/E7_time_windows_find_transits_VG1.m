% purpose : find and diplay all the images obtained during certain
% geometric events of the voyager (1 or 2) jupiter encounter (and possibly
% others)

clear
close all


METAKR={'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls','naif0012.tls', ...
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/vgr1_jup230.bsp','vgr1_jup230.bsp',... % kernel of voyager 1's flyby of Jupiter 
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/voyager_1.ST+1991_a54418u.merged.bsp','voyager_1.ST+1991_a54418u.merged.bsp',... % +voyager 1 merged
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/vgr2_jup230.bsp','vgr2_jup230.bsp',... % kernel of voyager 2's flyby of Jupiter
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/Voyager_2.m05016u.merged.bsp','Voyager_2.m05016u.merged.bsp',...
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/planets/de430.bsp','de430.bsp' , ...
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/sat337.bsp','sat337.bsp' , ...
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/jup365.bsp','jup365.bsp',...
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/de-403-masses.tpc','de-403-masses.tpc', ... % GM of planets
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/moon_pa_de403_1950-2198.bpc','moon_pa_de403_1950-2198.bpc', ... % GM of moons ?
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/pck00010.tpc','pck00010.tpc', ... % Radii (among others)
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/Gravity.tpc','Gravity.tpc' }; % GM
    
initSPICEv(METAKR);


% Define period of study:
startTimeString='1979-01-01T00:00:00';
endTimeString='1979-06-01T00:00:00';

startTimeET=cspice_str2et(startTimeString);
endTimeET=cspice_str2et(endTimeString);
step=180; % seconds

% 1: Find all the intervals when Io was seen in front of Jupiter from VG1
occtyp='any';
front='io';
fshape='ellipsoid';
fframe='iau_io';

back='jupiter';
bshape='ellipsoid';
bframe='iau_jupiter';

observer='VG1';
abcorr='none';
MAXWIN  =  1000;

% Create a time window from time_start to time_end
cnfine = cspice_wninsd( startTimeET, endTimeET ); 

% cspice_gfoclt determines time intervals when an observer sees one target
%    body occulted by, or in transit across, another.
transitIO = cspice_gfoclt(occtyp, front, fshape, fframe, ...
                      back, bshape, bframe,          ...
                      abcorr, observer, step, cnfine,  ...
                      MAXWIN); 
                  
printTimeWindow('Transit IO seem from VG1',transitIO,0);

% 2: Find the same result for all Galilean satellites
blist={'io','europa','callisto','ganymede'};
transitB=[]; % this will contain a list with all the results
for i=1:numel(blist)
    front=blist{i};
    fframe=strcat('iau_',blist{i});
    % time window and all the other parameters are the same
    transitB{i} = cspice_gfoclt(occtyp, front, fshape, fframe, ...
                      back, bshape, bframe,          ...
                      abcorr, observer, step, cnfine,  ...
                      MAXWIN);
    printTimeWindow(sprintf('Transit %s seen from VG1',blist{i}),transitB{i},0);
    
end

% 3: Find the intersection of Io transit and all the other bodies (one by
% one). Print all the transit of Io and Europe in detail
transitIOandB=[];
for i=2:numel(blist)
    transitIOandB{i}=cspice_wnintd(transitB{1},transitB{i});
    detail=0;
    if i==2
        detail=1;
    end
    printTimeWindow(sprintf('Transit of IO and %s seen from VG1',blist{i}),transitIOandB{i},detail );
end


% 4: Find the intersection of Io transit, Europa transit and Ganymede
% transit
transitIoEuropeGanymede=cspice_wnintd(transitIOandB{2},transitIOandB{4});
printTimeWindow('Transit IO EUROPE GANYMEDE',transitIoEuropeGanymede,1);

function printTimeWindow(name,r,detail)
    fprintf('Time window <%s> contains %d intervals \n',name,numel(r)/2);
    if detail>0
        for i=1:numel(r)/2
            fprintf('From %s to %s: %.2f (s) \n',cspice_et2utc( r(2*i-1),'C',1), cspice_et2utc( r(2*i),'C',1) , r(2*i) -r(2*i-1)  );
        end
    end
end


