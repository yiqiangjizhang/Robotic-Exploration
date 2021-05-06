%% Pluto plot
%
%-------------------------------------------------------------------------%
% Exercise: This code plots the position of Pluto's moon with relation to
% Pluto's trajectory and Plutos barycenter
%-------------------------------------------------------------------------%

% Date: 06/05/2021
% Author/s: Group 1
% Subject: Robotic Exploration of the Solar System
% Professor: Manel Soria & Arnau Miro

% Clear workspace, command window and close windows
clear;
close all;
clc;

% Set interpreter to latex
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');


% Recall that RESSlib should be in Matlab Path 
% Addpath Yi Qiang
addpath('C:\Users\yiqia\Documents\Spice_Doc\RESSlib')
% % Addpath Iván
% addpath('D:\HDD_Data\Iván\Workload\Q8-GRETA\Robotic_Exploration_of_the_Solar_System\RESSlib')
% % Addpath Èric
% addpath('F:\RESSoptativa\Resslib')
% % Addpath Rita
% addpath('C:\Users\Rita Fardilha\Desktop\RESSlib/');

%% Using nh_plu017.bps

% From kernels we get the desired data.
METAKR={'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls', ...
    %'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/plu055.bsp', ...
    'https://naif.jpl.nasa.gov/pub/naif/pds/data/nh-j_p_ss-spice-6-v1.0/nhsp_1000/data/spk/nh_plu017.bsp'
    %'https://naif.jpl.nasa.gov/pub/naif/pds/data/nh-j_p_ss-spice-6-v1.0/nhsp_1000/data/spk/nh_plu047_od122.bsp', ...
    %'https://naif.jpl.nasa.gov/pub/naif/pds/data/nh-j_p_ss-spice-6-v1.0/nhsp_1000/data/spk/nh_recon_arrokoth_od147_v01.bsp', ...
    %'https://naif.jpl.nasa.gov/pub/naif/pds/data/nh-j_p_ss-spice-6-v1.0/nhsp_1000/data/spk/nh_recon_pluto_od122_v01.bsp'
    }; % Pluto system


% Print RESSLIB version
v=initSPICEv(fullK(METAKR));
fprintf('RESSLIB version %s \n',v);

% Time parameters
% utctime='1900-01-08 T00:00:41.184'; % 1979-03-03 T00:00:00
% et0 = cspice_str2et(utctime); %converts time (which is a string) to a number
% NDAYS = 10*365; % study time
% et1 = et0 + 24*3600*NDAYS; % end of query time
% et=linspace(et0,et1,10000);

utctime='1965-04-25 T23:59:19'; % 1979-03-03 T00:00:00
et0 = cspice_str2et(utctime); % converts time (which is a string) to a number
NDAYS = 50; % study time
et1 = et0 + 24*3600*NDAYS; % end of query time
et=linspace(et0,et1,10000);

% Frame
frame = 'ECLIPJ2000';
abcorr = 'NONE';


% Observer will be Pluto barycenter
observer = '9'; % PLUTO BARYCENTER (9)
scale = 1188.3; % Pluto's radius (km)

[dplu,lt] = cspice_spkezr('999',et,frame,abcorr,observer); % pluto 
[dchar,lt] = cspice_spkezr('901',et,frame,abcorr,observer); % pluto 
[dnix,lt] = cspice_spkezr('902',et,frame,abcorr,observer); % pluto 
[dhydr,lt] = cspice_spkezr('903',et,frame,abcorr,observer); % pluto 

LW = 0.5;
plot_pdf = figure(1);
plot3(dplu(1,:)/scale,dplu(2,:)/scale,dplu(3,:)/scale,'r','LineWidth',LW)
hold on
plot3(dchar(1,:)/scale,dchar(2,:)/scale,dchar(3,:)/scale,'b','LineWidth',LW)
plot3(dnix(1,:)/scale,dnix(2,:)/scale,dnix(3,:)/scale,'g','LineWidth',LW)   
plot3(dhydr(1,:)/scale,dhydr(2,:)/scale,dhydr(3,:)/scale,'c','LineWidth',LW)

% The same but the observer now will be Pluto
observer = '999'; % PLUTO (999)
scale = 1188.3; % Pluto's radius (km)

[dplu,lt] = cspice_spkezr('999',et,frame,abcorr,observer); % pluto 
[dchar,lt] = cspice_spkezr('901',et,frame,abcorr,observer); % pluto 
[dnix,lt] = cspice_spkezr('902',et,frame,abcorr,observer); % pluto 
[dhydr,lt] = cspice_spkezr('903',et,frame,abcorr,observer); % pluto 

LW = 0.5;
plot_pdf = figure(1);
set(plot_pdf,'Position',[475 250 800 500])
plot3(dplu(1,:)/scale,dplu(2,:)/scale,dplu(3,:)/scale,'r--','LineWidth',LW)
plot3(dchar(1,:)/scale,dchar(2,:)/scale,dchar(3,:)/scale,'b--','LineWidth',2)
plot3(dnix(1,:)/scale,dnix(2,:)/scale,dnix(3,:)/scale,'g--','LineWidth',LW)   
plot3(dhydr(1,:)/scale,dhydr(2,:)/scale,dhydr(3,:)/scale,'c--','LineWidth',LW)
% hold off
legend('Pluto', 'Charon', 'Nix', 'Hydra','Pluto', 'Charon', 'Nix', 'Hydra');
xlabel('x PR');
ylabel('y PR');
zlabel('z PR');
title("\textbf{Pluto's moons trajectories. Obs: Pluto and Pluto's barycenter}");
grid on
grid minor

annotation('textbox', [0.8, 0.35, .19, .1], 'string', "- wrt Pluto's barycenter -- wrt Pluto")

% view(90,0)

% p1 = [-1.70453,26.496,45.7425];
% p2 = [30.3903,4.87227,-45.0984];
% p3 = [-34.6471,-42.0259, -7.48276];
% normal = cross(p1 - p2, p1 - p3);
% d = p1(1)*normal(1) + p1(2)*normal(2) + p1(3)*normal(3);
% d = -d;
% x = -100:100; y = -100:100;
% [X,Y] = meshgrid(x,y);
% Z = (-d - (normal(1)*X) - (normal(2)*Y))/normal(3);
% mesh(X,Y,Z)


A = - 5.073662414290200e+03;
B = 4.700788378518801e+03;
C = - 2.911539970963100e+03;
D = - 19.181550484606309;

view([-5.073662414290200 +4.700788378518801 -2.911539970963100]);


% Save pdf
% set(plot_pdf, 'Units', 'Centimeters');
% pos = get(plot_pdf, 'Position');
% set(plot_pdf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
%     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf, 'pluto_trajectory_and_moons.pdf', '-dpdf', '-r0');
% 
% % Save png
% print(gcf,'pluto_trajectory_and_moons.png','-dpng','-r1000');


endSPICE
