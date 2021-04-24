% Manel Soria July 2019
% Simple example to start with SPICE
% Plot the position of Jupiter, Io, Europa and VG1 during VG1 flyby
% Use ECLIPJ2000 and the SS barycenter as observer, then Jupiter barycenter
% as observer

close all; 

clear; 

% Recall that RESSlib should be in Matlab Path 


METAKR={'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls', ... % leap seconds
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/vgr1_jup230.bsp',... % kernel of voyager 1's flyby of Jupiter 
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/vgr2_jup230.bsp',... % kernel of voyager 2's flyby of Jupiter 
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/jup365.bsp' }; % Jupiter system

v=initSPICEv(fullK(METAKR));

fprintf('RESSLIB version %s \n',v);

utctime='1979-03-03 T00:00:00';

et0 = cspice_str2et ( utctime );

NDAYS = 6;

et1 = et0 + 24*3600*NDAYS; % end of query time
et=linspace(et0,et1,10000);

LW=3; % LineWidth of the plots

frame = 'ECLIPJ2000';
abcorr = 'NONE';

figure(1);

observer = '0'; % Solar System  barycenter
scale = 149597871 ; % AU (km) 

%https://nssdc.gsfc.nasa.gov/planetary/factsheet/jupiterfact.html

[djup,lt] = cspice_spkezr('599',et,frame,abcorr,observer); % jupiter 
[dio, lt] = cspice_spkezr('501',et,frame,abcorr,observer); % io
[deu, lt] = cspice_spkezr('502',et,frame,abcorr,observer); % europa
[dv1, lt] = cspice_spkezr('VG1',et,frame,abcorr,observer); % voyager1

plot3(djup(1,:)/scale,djup(2,:)/scale,djup(3,:)/scale,'r','LineWidth',LW)
hold on
plot3(dio(1,:)/scale,dio(2,:)/scale,dio(3,:)/scale,'g','LineWidth',LW)
plot3(deu(1,:)/scale,deu(2,:)/scale,deu(3,:)/scale,'b','LineWidth',LW)
plot3(dv1(1,:)/scale,dv1(2,:)/scale,dv1(3,:)/scale,'k','LineWidth',LW)
xlabel('AU');
ylabel('AU');
zlabel('AU');
axis('equal');
legend({'J','I','E','V1'});
title('Jupiter Voyager 1 flyby. Obs: SS barycenter');
grid
set(findall(gcf,'-property','FontSize'),'FontSize',18);

% The same but the observer now will be Jupiter barycenter
observer = '5'; % Jupiter barycenter (not Jupiter system barycenter)
scale = 66854; % Jupiter polar radius (km) 

[djup,lt] = cspice_spkezr('599',et,frame,abcorr,observer); % jupiter 
[dio, lt] = cspice_spkezr('501',et,frame,abcorr,observer); % io
[deu, lt] = cspice_spkezr('502',et,frame,abcorr,observer); % europa
[dv1, lt] = cspice_spkezr('VG1',et,frame,abcorr,observer); % voyager1

figure(2);

plot3(djup(1,:)/scale,djup(2,:)/scale,djup(3,:)/scale,'r','LineWidth',LW)
hold on
plot3(dio(1,:)/scale,dio(2,:)/scale,dio(3,:)/scale,'g','LineWidth',LW)
plot3(deu(1,:)/scale,deu(2,:)/scale,deu(3,:)/scale,'b','LineWidth',LW)
plot3(dv1(1,:)/scale,dv1(2,:)/scale,dv1(3,:)/scale,'k','LineWidth',LW)
xlabel('JR');
ylabel('JR');
zlabel('JR');
axis('equal');
legend({'J','I','E','V1'});
title('Jupiter Voyager 1 flyby. Obs: Jupiter barycenter');
grid
set(findall(gcf,'-property','FontSize'),'FontSize',18);

endSPICE