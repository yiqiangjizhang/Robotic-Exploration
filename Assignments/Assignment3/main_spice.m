%-------------------------------------------------------------------------------------------------------%
% Assignment 3: Spacecraft trajectory queries.
% Plot the position of Jupiter, Io, Europa and VG1 during VG1 flyby
% Use ECLIPJ2000 and the SS barycenter as observer, then Jupiter barycenter
% as observer
%-------------------------------------------------------------------------------------------------------%

% Date: 17/05/2021
% Author/s: Group 1
%   Rita Fardilha
%   Yi Qiang Ji
%   Èric Montserrat
%   Iván Sermanoukian

% Subject: Robotic Exploration of the Solar System
% Professor: Manel Soria & Arnau Miro

% Clear workspace, command window and close windows
clear;
close all;
clc;

% Set interpreter to latex
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaulttextinterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

% % Recall that RESSlib should be in Matlab Path
% % Addpath Yi Qiang
% addpath 'C:\Users\yiqia\Documents\Spice_Doc\RESSlib'
% % Addpath Iván
% addpath('D:\HDD_Data\Iván\Workload\Q8-GRETA\Robotic_Exploration_of_the_Solar_System\RESSlib')
% % Addpath Èric
% addpath('F:\RESSoptativa\Resslib')
% % Addpath Rita
% addpath('C:\Users\Rita Fardilha\Desktop\RESSlib/');

% Addpath Manel Soria
% addpath('');

% From kernels we get the desired data.
METAKR = {
    % Leap Seconds Kernels file
    'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls', ...
    % Kernel of voyager 1's flyby of Jupiter from (1979-02-01) to (1979-03-19)
    'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/vgr1_jup230.bsp',...
    % Kernel of voyager 1's from (1979-01-14) to (1979-04-24)
    'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/voyager_1.ST+1991_a54418u.merged.bsp',...
    % Jupiter System data from (1799-12-27) to (2200-01-05)
    'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/jup365.bsp'
    };

% Print RESSLIB version
v = initSPICEv(fullK(METAKR));
fprintf('RESSLIB version %s \n', v);

%% Jupiter flyby (March 1979)

% Time parameters                     _J designation for Jupiter
utctimeJ = '1979-03-01 T00:00:00'; % Start time
et0J = cspice_str2et(utctimeJ); % Converts time (which is a string) to a number
NDAYSJ = 20; % Study time
et1J = et0J + 24 * 3600 * NDAYSJ; % End of query time
etJ = linspace(et0J, et1J, 10000); % Time interval


% Frame
frame = 'ECLIPJ2000';
abcorr = 'NONE';

% Observer will be Pluto barycenter
observer = '5'; % JUPITER BARYCENTER (5)
scale = 66854; % Jupiter's polar radius (km)

% Ephemeris data
[dv1, lt] = cspice_spkezr('VG1',etJ,frame,abcorr,observer); % voyager1
[djup, lt] = cspice_spkezr('599', etJ, frame, abcorr, observer); % Jupiter
[dio, lt] = cspice_spkezr('501', etJ, frame, abcorr, observer); % Io
[deur, lt] = cspice_spkezr('502', etJ, frame, abcorr, observer); % Europa
[dgan, lt] = cspice_spkezr('503', etJ, frame, abcorr, observer); % Ganymede
[dcal, lt] = cspice_spkezr('504', etJ, frame, abcorr, observer); % Callisto

[dsun, lt] = cspice_spkezr('10', etJ, frame, abcorr, observer); % Sun



LW = 1;
plot_pdf = figure(1);
set(plot_pdf,'Position',[100 100 1000 700])
plot3(dv1(1,:)/scale,dv1(2,:)/scale,dv1(3,:)/scale,'k','LineWidth',LW)
hold on
plot3(djup(1,:)/scale,djup(2,:)/scale,djup(3,:)/scale,'r*','LineWidth',LW)
plot3(dio(1,:)/scale,dio(2,:)/scale,dio(3,:)/scale,'g','LineWidth',LW)
plot3(deur(1,:)/scale,deur(2,:)/scale,deur(3,:)/scale,'b','LineWidth',LW)
plot3(dgan(1,:)/scale,dgan(2,:)/scale,dgan(3,:)/scale,'c','LineWidth',LW)
plot3(dcal(1,:)/scale,dcal(2,:)/scale,dcal(3,:)/scale,'m','LineWidth',LW)

% SUN (To see where the Sun is located)

% plot3(dsun(1, :) / scale, dsun(2, :) / scale, dsun(3, :) / scale, 'y.', 'LineWidth', 5); % Sun position respect Jupiter's barycenter when NewHorizons is closest to Jupiter.

% % Distance vector between Jupiter and Sun
% Mean distance between Sun and Jupiter
dist = linspace(etJ(end/2), etJ(end/2), 1);

% Sun's position in mean dist
[dsun_t, lt] = cspice_spkezr('10', dist, frame, abcorr, observer);

% Distance vector between Jupiter and Sun
v1 = [dsun_t(1, 1) / scale dsun_t(2, 1) / scale dsun_t(3, 1) / scale];
v2 = [djup(1, end/2) / scale djup(2, end/2) / scale djup(3, end/2) / scale];
v = [v2; v1];
D = v2 - v1;

% plot3(v(:, 1), v(:, 2), v(:, 3), 'y')
quiver3(v1(1) / 100, v1(2) / 100, v1(3) / 100, D(1) / 100, D(2) / 100, D(3) / 100, 0, 'Color', [255 165 0]/255);

% March 8 photo
utctimeJ_photo = '1979-03-08 T00:00:00'; % Start time
et0J_photo = cspice_str2et(utctimeJ_photo); % Converts time (which is a string) to a number
NDAYSJ_photo = 1; % Study time
et1J_photo = et0J_photo + 24 * 3600 * NDAYSJ_photo; % End of query time
etJ_photo = linspace(et0J_photo, et1J_photo, 1); % Time interval

% Ephemeris data
[dv1_photo, lt] = cspice_spkezr('VG1',etJ_photo,frame,abcorr,observer); % voyager1
[dio_photo, lt] = cspice_spkezr('501', etJ_photo, frame, abcorr, observer); % Io

plot3(dv1_photo(1,:)/scale,dv1_photo(2,:)/scale,dv1_photo(3,:)/scale,'k*','LineWidth',LW)
plot3(dio_photo(1,:)/scale,dio_photo(2,:)/scale,dio_photo(3,:)/scale,'g*','LineWidth',LW)

xlim([-90 40])
ylim([-80 40])
zlim([-2 6])

xlabel('X JR');
ylabel('Y JR');
zlabel('Z JR');
axis('equal');
legend({'Voyager 1', 'Jupiter', 'Io', 'Europa', 'Ganymede', 'Calisto', 'Sun rays'});
title('\textbf{Jupiter Voyager 1. Obs: Jupiter barycenter}');
grid on
grid minor

% View from top
% az = 0;
% el = 90;
% view(az, el);



% % Figure 1
% set(plot_pdf, 'Units', 'Centimeters');
% pos = get(plot_pdf, 'Position');
% set(plot_pdf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
%         'PaperSize', [pos(3), pos(4)]);
% print(plot_pdf, 'figure1_v2.pdf', '-dpdf', '-r1500');
% 
% print(gcf,'figure1_v2.png','-dpng','-r1000');


endSPICE






