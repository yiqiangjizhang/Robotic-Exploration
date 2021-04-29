% Manel Soria July 2019
% Simple example to start with SPICE
% Plot the position of Jupiter, Io, Europa and VG1 during VG1 flyby
% Use ECLIPJ2000 and the SS barycenter as observer, then Jupiter barycenter
% as observer

close all; 
clc
clear all; 

% Recall that RESSlib should be in Matlab Path 
addpath('D:\HDD_Data\Iván\Workload\Q8-GRETA\Robotic_Exploration_of_the_Solar _System\RESSlib')

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
[dga, lt] = cspice_spkezr('503',et,frame,abcorr,observer); % ganymede
[dca, lt] = cspice_spkezr('504',et,frame,abcorr,observer); % callisto
[dam, lt] = cspice_spkezr('505',et,frame,abcorr,observer); % amalthea
[dth, lt] = cspice_spkezr('514',et,frame,abcorr,observer); % thebe
[dad, lt] = cspice_spkezr('515',et,frame,abcorr,observer); % adrastea
[dme, lt] = cspice_spkezr('516',et,frame,abcorr,observer); % metis
[dv1, lt] = cspice_spkezr('VG1',et,frame,abcorr,observer); % voyager1

% Minimum distance of Voyager1 to a body
min_dist_jupiter = 1;
min_dist_io = 1;
min_dist_europa = 1;
min_dist_ganymede = 1;
min_dist_callisto = 1;
min_dist_amalthea = 1;
min_dist_thebe = 1;
min_dist_adrastea = 1;
min_dist_metis = 1;
% pos = zeros(9,6);
for i =1:1:length(et)
    dist_jupiter = sqrt((dv1(1,i)-djup(1,i)).^2+(dv1(2,i)-djup(2,i)).^2+(dv1(3,i)-djup(3,i)).^2);
    dist_io = sqrt((dv1(1,i)-dio(1,i)).^2+(dv1(2,i)-dio(2,i)).^2+(dv1(3,i)-dio(3,i)).^2);
    dist_europa = sqrt((dv1(1,i)-deu(1,i)).^2+(dv1(2,i)-deu(2,i)).^2+(dv1(3,i)-deu(3,i)).^2);
    dist_ganymede = sqrt((dv1(1,i)-dga(1,i)).^2+(dv1(2,i)-dga(2,i)).^2+(dv1(3,i)-dga(3,i)).^2);
    dist_callisto = sqrt((dv1(1,i)-dca(1,i)).^2+(dv1(2,i)-dca(2,i)).^2+(dv1(3,i)-dca(3,i)).^2);
    dist_amalthea = sqrt((dv1(1,i)-dam(1,i)).^2+(dv1(2,i)-dam(2,i)).^2+(dv1(3,i)-dam(3,i)).^2);
    dist_thebe = sqrt((dv1(1,i)-dth(1,i)).^2+(dv1(2,i)-dth(2,i)).^2+(dv1(3,i)-dth(3,i)).^2);
    dist_adrastea = sqrt((dv1(1,i)-dad(1,i)).^2+(dv1(2,i)-dad(2,i)).^2+(dv1(3,i)-dad(3,i)).^2);
    dist_metis = sqrt((dv1(1,i)-dme(1,i)).^2+(dv1(2,i)-dme(2,i)).^2+(dv1(3,i)-dme(3,i)).^2);
    
    if ((dist_jupiter/scale)<(min_dist_jupiter))
        min_dist_jupiter = dist_jupiter/scale;
%         pos(1,1)=dv1(1,i)/scale;
%         pos(1,2)=dv1(2,i)/scale;
%         pos(1,3)=dv1(3,i)/scale;
%         pos(1,4)=djup(1,i)/scale;
%         pos(1,5)=djup(2,i)/scale;
%         pos(1,6)=djup(3,i)/scale;
    end 
    if ((dist_io/scale)<(min_dist_io))
        min_dist_io = dist_io/scale;
    end
    if ((dist_europa/scale)<(min_dist_europa))
        min_dist_europa = dist_europa/scale;
    end
    if ((dist_ganymede/scale)<(min_dist_ganymede))
        min_dist_ganymede = dist_ganymede/scale;
    end
    if ((dist_callisto/scale)<(min_dist_callisto))
        min_dist_callisto = dist_callisto/scale;
    end
    if ((dist_amalthea/scale)<(min_dist_amalthea))
        min_dist_amalthea = dist_amalthea/scale;
    end
    if ((dist_thebe/scale)<(min_dist_thebe))
        min_dist_thebe = dist_thebe/scale;
    end
    if ((dist_adrastea/scale)<(min_dist_adrastea))
        min_dist_adrastea = dist_adrastea/scale;
    end
    if ((dist_metis/scale)<(min_dist_metis))
        min_dist_metis = dist_metis/scale;
    end    
    
end


h1 = figure(1);
plot3(djup(1,:)/scale,djup(2,:)/scale,djup(3,:)/scale,'r','LineWidth',LW);
hold on
plot3(dio(1,:)/scale,dio(2,:)/scale,dio(3,:)/scale,'g','LineWidth',LW);
plot3(deu(1,:)/scale,deu(2,:)/scale,deu(3,:)/scale,'b','LineWidth',LW);
plot3(dga(1,:)/scale,dga(2,:)/scale,dga(3,:)/scale,'y','LineWidth',LW);
plot3(dca(1,:)/scale,dca(2,:)/scale,dca(3,:)/scale,'Color',[204/255 153/255 1],'LineWidth',LW);
plot3(dam(1,:)/scale,dam(2,:)/scale,dam(3,:)/scale,'Color',[0 1 1],'LineWidth',LW);
plot3(dth(1,:)/scale,dth(2,:)/scale,dth(3,:)/scale,'Color',[1 0 1],'LineWidth',LW);
plot3(dad(1,:)/scale,dad(2,:)/scale,dad(3,:)/scale,'Color',[102/255 102/255 0],'LineWidth',LW);
plot3(dme(1,:)/scale,dme(2,:)/scale,dme(3,:)/scale,'Color',[0 102/255 0],'LineWidth',LW);
plot3(dv1(1,:)/scale,dv1(2,:)/scale,dv1(3,:)/scale,'k','LineWidth',LW);
% plot3(pos(1,1),pos(1,2),pos(1,3),'o','MarkerSize',12);
% plot3(pos(1,4),pos(1,5),pos(1,6),'o','MarkerSize',12);

xlabel('AU');
ylabel('AU');
zlabel('AU');
axis('equal');
legend({'Jupiter','Io','Europa','Ganymede','Callisto','Amalthea','Thebe','Adrastea','Metis','V1'});
title('Jupiter Voyager 1 flyby (Major moons and asteroids). Obs: SS barycenter');
grid
set(findall(gcf,'-property','FontSize'),'FontSize',16);
h1.Position = [50 50 1600 900];

endSPICE