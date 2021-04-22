% Find, download and display all VG1 images taken in a given time interval
% (one of the double Io - Europa transits in this case)

clear
close all
L=getAllLists('VOYAGER1','JUPITER'); % get summary files
% Get ephemeris time of all the images
et=[];
for i=1:L.nd
    et(i)=cspice_str2et(L.timestr{i});
end

startT=cspice_str2et('1979 FEB 02 14:33:58.6');
endT  =cspice_str2et('1979 FEB 02 14:57:35.3');

cnfine = cspice_wninsd( startT, endT ); % time window of interest

for i=1:L.nd    
    if cspice_wnelmd(et(i),cnfine)
        fprintf('%s \n',L.timestr{i});
        a=getVoyagerCassiniImage(L,i,'GEOMED');
        imshow(double(a)/double(max(a(:))));
        drawnow
        pause(10);
    end
end
