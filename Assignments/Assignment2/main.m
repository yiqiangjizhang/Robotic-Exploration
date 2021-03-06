%-------------------------------------------------------------------------------------------------------%
% Assignment 2: Spacecraft trajectory queries. For instance, plotting the trajectory during a flyby and
% finding the minimum distance from the spacecraft to each of the bodies.
%-------------------------------------------------------------------------------------------------------%

% Date: 06/05/2021
% Author/s: Group 1
%   Rita Fardilha
%   Yi Qiang Ji
%   Èric Montserrat
%   Iván Sermanoukian

% Subject: Robotic Exploration of the Solar System
% Professor: Manel Soria & Arnau Miro

%% R E A D M E
%{

This code studies New Horizons trajectory and flyby across Jupiter and Pluto.

Figure 1 .- Plot of the trajectories of Jupiter's moons + New Horizons flyby on Jupiter.
Furthermore, it is represented with dots the positions of minimum distance between NewHorizons and each body.
Figure 2 .- Video animation of New Horizons flyby on Jupiter.

Figure 3 .- New Horizons flyby on Jupiter. It is marked the point for minimum distance and a line that links that point with Jupiter barycenter.

Figure 4 .- Same as figure 3 but in 2D.

Figure 5 .- Plot of the trajectories of Pluto, Charon and New Horizons flyby on Pluto.
Also, it is represented with dots the positions of minimum distance between NewHorizons with Pluto and Charon.

Figure 6 .- Animation of the trajectories of Pluto, Charon and New Horizons flyby on Pluto.

R E S U L T S V A L I D A T I O N

Pluto information from July 14, 2015 (Image)
https: // skyandtelescope.org / astronomy - news / new - horizons - navigating - to - pluto - 040320154 /

Pluto at the given date has the image distance and velocity.

Jupiter flyby date and distances
https: // www.planetary.org / articles / jupiter_timeline

Jupiter flyby date coincides with the web page.

%}

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
    % Reconstructed trajectory data for the New Horizons spacecraft covering launch (2006-01-19) through (2007-03-19)
    'https://naif.jpl.nasa.gov/pub/naif/pds/data/nh-j_p_ss-spice-6-v1.0/nhsp_1000/data/spk/nh_recon_e2j_v1.bsp', ...
    % Preliminary reconstructed trajectory data for the New Horizons spacecraft from (2007-03-19) to (2007-09-07)
    'https://naif.jpl.nasa.gov/pub/naif/pds/data/nh-j_p_ss-spice-6-v1.0/nhsp_1000/data/spk/nh_recon_j2sep07_prelimv1.bsp', ...
    % Pluto approach, encounter and departure trajectory data
    'https://naif.jpl.nasa.gov/pub/naif/pds/data/nh-j_p_ss-spice-6-v1.0/nhsp_1000/data/spk/nh_recon_pluto_od122_v01.bsp', ...
    % Jupiter's system ephemeris data from (1924-12-28) to (2023-10-30)
% 'https://naif.jpl.nasa.gov/pub/naif/pds/data/nh-j_p_ss-spice-6-v1.0/nhsp_1000/data/spk/jup260.bsp', ...
    % Pluto ephemeris data from  (1900-01-08) to (2100-01-01)
    'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/plu055.bsp', ...
    % Jupiter System data from (1799-12-27) to (2200-01-05)
    'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/jup365.bsp'
    };

% Print RESSLIB version
v = initSPICEv(fullK(METAKR));
fprintf('RESSLIB version %s \n', v);

%% Jupiter flyby (Feb 2007)

% Time parameters                     _J designation for Jupiter
utctimeJ = '2007-02-07 T19:50:13'; % Start time
et0J = cspice_str2et(utctimeJ); % Converts time (which is a string) to a number
NDAYSJ = 30; % Study time
et1J = et0J + 24 * 3600 * NDAYSJ; % End of query time
etJ = linspace(et0J, et1J, 10000); % Time interval

% Frame
frame = 'ECLIPJ2000';
abcorr = 'NONE';

% Observer will be Pluto barycenter
observer = '5'; % JUPITER BARYCENTER (5)
scale = 66854; % Jupiter's polar radius (km)

% Ephemeris data
[dnh, lt] = cspice_spkezr('NEW HORIZONS', etJ, frame, abcorr, observer); % New Horizons
[djup, lt] = cspice_spkezr('599', etJ, frame, abcorr, observer); % Jupiter
[dio, lt] = cspice_spkezr('501', etJ, frame, abcorr, observer); % Io
[deur, lt] = cspice_spkezr('502', etJ, frame, abcorr, observer); % Europa
[dgan, lt] = cspice_spkezr('503', etJ, frame, abcorr, observer); % Ganymede
[dcal, lt] = cspice_spkezr('504', etJ, frame, abcorr, observer); % Callisto

[dsun, lt] = cspice_spkezr('10', etJ, frame, abcorr, observer); % Sun

% Minimum Distance from New Horizons to: Jupiter, Io, Europa, Ganymede, Callisto

% Create vectors to log the position of mininum distance from New Horizons to each body.
PosMin_NhJup = zeros(1, 3);
PosMin_NhIo = zeros(1, 3);
PosMin_NhEuropa = zeros(1, 3);
PosMin_NhGanymede = zeros(1, 3);
PosMin_NhCallisto = zeros(1, 3);

% Create vectors to log data for each distance
Dist_NhJup = zeros(1, 10000);
Dist_NhIo = zeros(1, 10000);
Dist_NhEuropa = zeros(1, 10000);
Dist_NhGanymede = zeros(1, 10000);
Dist_NhCallisto = zeros(1, 10000);

% Calculate the first distance between Spacecraft (New Horizons) and the other bodies
Dist_NhJup(1, 1) = sqrt((djup(1, 1) - dnh(1, 1))^2 + (djup(2, 1) - dnh(2, 1))^2 + (djup(3, 1) - dnh(3, 1))^2);
Dist_NhIo(1, 1) = sqrt((dio(1, 1) - dnh(1, 1))^2 + (dio(2, 1) - dnh(2, 1))^2 + (dio(3, 1) - dnh(3, 1))^2);
Dist_NhEuropa(1, 1) = sqrt((deur(1, 1) - dnh(1, 1))^2 + (deur(2, 1) - dnh(2, 1))^2 + (deur(3, 1) - dnh(3, 1))^2);
Dist_NhGanymede(1, 1) = sqrt((dgan(1, 1) - dnh(1, 1))^2 + (dgan(2, 1) - dnh(2, 1))^2 + (dgan(3, 1) - dnh(3, 1))^2);
Dist_NhCallisto(1, 1) = sqrt((dcal(1, 1) - dnh(1, 1))^2 + (dcal(2, 1) - dnh(2, 1))^2 + (dcal(3, 1) - dnh(3, 1))^2);

for i = 2:10000

    Dist_NhJup(1, i) = sqrt((djup(1, i) - dnh(1, i))^2 + (djup(2, i) - dnh(2, i))^2 + (djup(3, i) - dnh(3, i))^2); %Calculate distance NH-Jupiter
    Dist_NhIo(1, i) = sqrt((dio(1, i) -dnh(1, i))^2 + (dio(2, i) - dnh(2, i))^2 + (dio(3, i) - dnh(3, i))^2); %Calculate distance NH-Io
    Dist_NhEuropa(1, i) = sqrt((deur(1, i) - dnh(1, i))^2 + (deur(2, i) - dnh(2, i))^2 + (deur(3, i) - dnh(3, i))^2); %Calculate distance NH-Europa
    Dist_NhGanymede(1, i) = sqrt((dgan(1, i) - dnh(1, i))^2 + (dgan(2, i) - dnh(2, i))^2 + (dgan(3, i) - dnh(3, i))^2); %Calculate distance NH-Ganymede
    Dist_NhCallisto(1, i) = sqrt((dcal(1, i) - dnh(1, i))^2 + (dcal(2, i) - dnh(2, i))^2 + (dcal(3, i) - dnh(3, i))^2); %Calculate distance NH-Callisto

    % Check current distance Nh-Jupiter, with prior value
    if (Dist_NhJup(1, i) < Dist_NhJup(1, i - 1))
        PosMin_NhJup(1, 1) = dnh(1, i); %If true, save position X Y Z of NewHorizons
        PosMin_NhJup(1, 2) = dnh(2, i);
        PosMin_NhJup(1, 3) = dnh(3, i);
        MinNhJup = Dist_NhJup(1, i) / scale; %If true, save Distance between Nh-Jupiter
        J = i; %If true, save coluwmn's index where condition is satisfied
    end

    % Check current distance Nh-Io, with prior value
    if (Dist_NhIo(1, i) < Dist_NhIo(1, i - 1))
        PosMin_NhIo(1, 1) = dnh(1, i); %If true, save position X Y Z of NewHorizons
        PosMin_NhIo(1, 2) = dnh(2, i);
        PosMin_NhIo(1, 3) = dnh(3, i);
        MinNhIo = Dist_NhIo(1, i) / scale; %If true, save Distance between Nh-Io
        I = i; %If true, save coluwmn's index where condition is satisfied
    end

    % Check current distance Nh-Europa, with prior value
    if (Dist_NhEuropa(1, i) < Dist_NhEuropa(1, i - 1))
        PosMin_NhEuropa(1, 1) = dnh(1, i); %If true, save position X Y Z of NewHorizons
        PosMin_NhEuropa(1, 2) = dnh(2, i);
        PosMin_NhEuropa(1, 3) = dnh(3, i);
        MinNhEuropa = Dist_NhEuropa(1, i) / scale; %If true, save Distance between Nh-Europa
        E = i; %If true, save coluwmn's index where condition is satisfied
    end

    % Check current distance Nh-Ganymede, with prior value
    if (Dist_NhGanymede(1, i) < Dist_NhGanymede(1, i - 1))
        PosMin_NhGanymede(1, 1) = dnh(1, i); %If true, save position X Y Z of NewHorizons
        PosMin_NhGanymede(1, 2) = dnh(2, i);
        PosMin_NhGanymede(1, 3) = dnh(3, i);
        MinNhGanymede = Dist_NhCallisto(1, i) / scale; %If true, save Distance between Nh-Ganymede
        G = i; %If true, save coluwmn's index where condition is satisfied
    end

    %Check current distance Nh-Callisto, with prior value
    if (Dist_NhCallisto(1, i) < Dist_NhCallisto(1, i - 1))
        PosMin_NhCallisto(1, 1) = dnh(1, i); %If true, save position X Y Z of NewHorizons
        PosMin_NhCallisto(1, 2) = dnh(2, i);
        PosMin_NhCallisto(1, 3) = dnh(3, i);
        MinNhCallisto = Dist_NhJup(1, i) / scale; %If true, save Distance between NH-Callisto
        C = i; %If true, save coluwmn's index where condition is satisfied
    end

end

% Take the Date of the event of Minimum distance Nh-body %
utcstrNhJup = cspice_et2utc(etJ(J), 'C', 5); %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Jupiter
utcstrNhIo = cspice_et2utc(etJ(I), 'C', 5); %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Io
utcstrNhEuropa = cspice_et2utc(etJ(E), 'C', 5); %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Europa
utcstrNhGanymede = cspice_et2utc(etJ(G), 'C', 5); %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Ganymede
utcstrNhCallisto = cspice_et2utc(etJ(C), 'C', 5); %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Callisto

% Plot New Horizons Flyby on Jupiter with the Io, Europa,Ganymede and Calllisto orbits %
LW = 1; % LineWidth specification
plot_pdf1 = figure(1);
set(plot_pdf1, 'Position', [5 50 1000 600])
plot3(djup(1, :) / scale, djup(2, :) / scale, djup(3, :) / scale, 'k.', 'LineWidth', LW);
hold on;
plot3(dnh(1, :) / scale, dnh(2, :) / scale, dnh(3, :) / scale, 'g', 'LineWidth', LW);
plot3(dio(1, :) / scale, dio(2, :) / scale, dio(3, :) / scale, 'b', 'LineWidth', LW);
plot3(dgan(1, :) / scale, dgan(2, :) / scale, dgan(3, :) / scale, 'm', 'LineWidth', LW);
plot3(deur(1, :) / scale, deur(2, :) / scale, deur(3, :) / scale, 'r', 'LineWidth', LW);
plot3(dcal(1, :) / scale, dcal(2, :) / scale, dcal(3, :) / scale, 'c', 'LineWidth', LW);

% Add the points of minimum distance between New Horizons and each body %
plot3(PosMin_NhJup(1, 1) / scale, PosMin_NhJup(1, 2) / scale, PosMin_NhJup(1, 3) / scale, 'r*', 'LineWidth', 1)
plot3(PosMin_NhIo(1, 1) / scale, PosMin_NhIo(1, 2) / scale, PosMin_NhIo(1, 3) / scale, 'b*', 'LineWidth', 1)
plot3(PosMin_NhEuropa(1, 1) / scale, PosMin_NhEuropa(1, 2) / scale, PosMin_NhEuropa(1, 3) / scale, 'r*', 'LineWidth', 1)
plot3(PosMin_NhGanymede(1, 1) / scale, PosMin_NhGanymede(1, 2) / scale, PosMin_NhGanymede(1, 3) / scale, 'm*', 'LineWidth', 1)
plot3(PosMin_NhCallisto(1, 1) / scale, PosMin_NhCallisto(1, 2) / scale, PosMin_NhCallisto(1, 3) / scale, 'c*', 'LineWidth', 1)

% % Distance vector between IO and New Horizons
% Minimum distance date between IO and New Horizons
min_dist_time_NHIO = linspace(etJ(I), etJ(I), 1);
[dio_t, lt] = cspice_spkezr('501', min_dist_time_NHIO, frame, abcorr, observer);

v1 = [PosMin_NhIo(1, 1) / scale PosMin_NhIo(1, 2) / scale PosMin_NhIo(1, 3) / scale];
v2 = [dio_t(1, 1) / scale dio_t(2, 1) / scale dio_t(3, 1) / scale];
v = [v2; v1];
D = v2 - v1;

plot3(dio_t(1, 1) / scale, dio_t(2, 1) / scale, dio_t(3, 1) / scale, 'b*', 'LineWidth', 1);
plot3(v(:, 1), v(:, 2), v(:, 3), 'r')
quiver3(v1(1), v1(2), v1(3), D(1), D(2), D(3), 0, 'Color', [0 0 0]);

% % Distance vector between Ganymede and New Horizons
% Minimum distance date between Ganymede and New Horizons
min_dist_time_NHG = linspace(etJ(G), etJ(G), 1);

% Ganymede's position in minimum distance date
[dgan_t, lt] = cspice_spkezr('503', min_dist_time_NHG, frame, abcorr, observer);

% Distance vector between Ganymede and New Horizons
v1 = [PosMin_NhGanymede(1, 1) / scale PosMin_NhGanymede(1, 2) / scale PosMin_NhGanymede(1, 3) / scale];
v2 = [dgan_t(1, 1) / scale dgan_t(2, 1) / scale dgan_t(3, 1) / scale];
v = [v2; v1];
D = v2 - v1;

plot3(dgan_t(1, 1) / scale, dgan_t(2, 1) / scale, dgan_t(3, 1) / scale, 'm*', 'LineWidth', 1);
plot3(v(:, 1), v(:, 2), v(:, 3), 'r')
quiver3(v1(1), v1(2), v1(3), D(1), D(2), D(3), 0, 'Color', [0 0 0]);

% Minimum distance date between Europe and New Horizons
min_dist_time_NHEU = linspace(etJ(E), etJ(E), 1);

% % Distance vector between Ganymede and New Horizons
% Europe's position in minimum distance date
[deur_t, ~] = cspice_spkezr('502', min_dist_time_NHEU, frame, abcorr, observer);

% % Distance vector between Europa and New Horizons
% Distance vector between Europa and New Horizons
v1 = [PosMin_NhEuropa(1, 1) / scale PosMin_NhEuropa(1, 2) / scale PosMin_NhEuropa(1, 3) / scale];
v2 = [deur_t(1, 1) / scale deur_t(2, 1) / scale deur_t(3, 1) / scale];
v = [v2; v1];
D = v2 - v1;

plot3(deur_t(1, 1) / scale, deur_t(2, 1) / scale, deur_t(3, 1) / scale, 'r*', 'LineWidth', 1);
plot3(v(:, 1), v(:, 2), v(:, 3), 'r*')
quiver3(v1(1), v1(2), v1(3), D(1), D(2), D(3), 0, 'Color', [0 0 0]);

% % Distance vector between Callisto and New Horizons
% Minimum distance date between Callisto and New Horizons
min_dist_time_NHC = linspace(etJ(C), etJ(C), 1);

% Callisto's position in minimum distance date
[dcal_t, lt] = cspice_spkezr('504', min_dist_time_NHC, frame, abcorr, observer);

% Distance vector between Callisto and New Horizons
v1 = [PosMin_NhCallisto(1, 1) / scale PosMin_NhCallisto(1, 2) / scale PosMin_NhCallisto(1, 3) / scale];
v2 = [dcal_t(1, 1) / scale dcal_t(2, 1) / scale dcal_t(3, 1) / scale];
v = [v2; v1];
D = v2 - v1;

plot3(PosMin_NhCallisto(1, 1) / scale, PosMin_NhCallisto(1, 2) / scale, PosMin_NhCallisto(1, 3) / scale, 'c*', 'LineWidth', 1)
plot3(dcal_t(1, 1) / scale, dcal_t(2, 1) / scale, dcal_t(3, 1) / scale, 'c*', 'LineWidth', 3);
plot3(v(:, 1), v(:, 2), v(:, 3), 'r')
quiver3(v1(1), v1(2), v1(3), D(1), D(2), D(3), 0, 'Color', [0 0 0]);

% % Distance vector between Jupiter and New Horizons
% Minimum distance date between Jupiter and New Horizons
min_dist_time_NHJ = linspace(etJ(J), etJ(J), 1);

% Jupiter's position in minimum distance date
[djup_t, lt] = cspice_spkezr('599', min_dist_time_NHG, frame, abcorr, observer);

% Distance vector between Jupiter and New Horizons
v1 = [PosMin_NhJup(1, 1) / scale PosMin_NhJup(1, 2) / scale PosMin_NhJup(1, 3) / scale];
v2 = [djup_t(1, 1) / scale djup_t(2, 1) / scale djup_t(3, 1) / scale];
v = [v2; v1];
D = v2 - v1;

plot3(djup_t(1, 1) / scale, djup_t(2, 1) / scale, djup_t(3, 1) / scale, 'k*', 'LineWidth', 1);
plot3(v(:, 1), v(:, 2), v(:, 3), 'r')
quiver3(v1(1), v1(2), v1(3), D(1), D(2), D(3), 0, 'Color', [0 0 0]);


%% SUN (To see where the Sun is located)

% plot3(dsun(1, J) / scale, dsun(2, J) / scale, dsun(3, J) / scale, 'k.', 'LineWidth', 5); % Sun position respect Jupiter's barycenter when NewHorizons is closest to Jupiter.

% % % Distance vector between Jupiter and Sun
% % Minimum distance date between Jupiter and New Horizons
% min_dist_time_JS = linspace(etJ(J), etJ(J), 1);
% 
% % Sun's position in minimum distance date
% [dsun_t, lt] = cspice_spkezr('10', min_dist_time_JS, frame, abcorr, observer);
% 
% % Distance vector between Jupiter and Sun
% v1 = [dsun_t(1, 1) / scale dsun_t(2, 1) / scale dsun_t(3, 1) / scale];
% v2 = [djup(1, J) / scale djup(2, J) / scale djup(3, J) / scale];
% v = [v2; v1];
% D = v2 - v1;
% 
% plot3(v(:, 1), v(:, 2), v(:, 3), 'k')
% quiver3(v1(1) / 100, v1(2) / 100, v1(3) / 100, D(1) / 100, D(2) / 100, D(3) / 100, 0, 'Color', [0 0 0]);
% 
xlim([-100 50])
ylim([-100 100])
zlim([-7 4])
% axis equal
title('\textbf{New Horizons flyby across Jupiter system. Observer: Jupiter barycenter}');
legend('Jupiter Position', 'New Horizons', 'Io', 'Ganymede', 'Europa', 'Calisto');
xlabel('x JR');
ylabel('y JR');
zlabel('z JR');
grid on;
grid minor;

annotation('textbox', [0.76, 0.64, .11, .12], 'string', sprintf('Min dist NH-Jup: %.4f [km]', MinNhJup))
annotation('textbox', [0.87, 0.64, .12, .12], 'string', sprintf('Date: %s', convertCharsToStrings(utcstrNhJup)))

annotation('textbox', [0.76, 0.52, .11, .12], 'string', sprintf('Min dist NH-Io: %.4f [km]', MinNhIo))
annotation('textbox', [0.87, 0.52, .12, .12], 'string', sprintf('Date: %s', convertCharsToStrings(utcstrNhIo)))

annotation('textbox', [0.76, 0.40, .11, .12], 'string', sprintf('Min dist NH-Europa: %.4f [km]', MinNhEuropa))
annotation('textbox', [0.87, 0.40, .12, .12], 'string', sprintf('Date: %s', convertCharsToStrings(utcstrNhEuropa)))

annotation('textbox', [0.76, 0.28, .11, .12], 'string', sprintf('Min dist NH-Ganymede: %.4f [km]', MinNhGanymede))
annotation('textbox', [0.87, 0.28, .12, .12], 'string', sprintf('Date: %s', convertCharsToStrings(utcstrNhGanymede)))

annotation('textbox', [0.76, 0.16, .11, .12], 'string', sprintf('Min dist NH-Callisto: %.4f [km]', MinNhCallisto))
annotation('textbox', [0.87, 0.16, .12, .12], 'string', sprintf('Date: %s', convertCharsToStrings(utcstrNhCallisto)))

view([-996.6413 -119.6652 61.3856]);

% View from top
% az = 0;
% el = 90;
% view(az, el);
 
 
% New Horizons flyby animation
% To save the video uncomment lines 366-368,395-396 and 402

% Initialise video
% myVideo = VideoWriter('NewHorizonsFlyby'); %open video file
% myVideo.FrameRate = 30;
% open(myVideo)

plot_pdf2 = figure(2);
set(plot_pdf2, 'Position', [1000 50 920 600])
xlabel('x JR');
ylabel('y JR');
zlabel('z JR');
title("\textbf{New Horizons' flyby across Jupiter (Time step:)}");
grid on;
grid minor;

% Jupiter
curve1 = animatedline('Marker', 'o', 'MaximumNumPoints', 1, 'Color', 'b', 'MarkerSize', 4, 'LineWidth', 1, 'MaximumNumPoints', 100);
% New Horizons
curve2 = animatedline('Marker', 'o', 'MaximumNumPoints', 1, 'Color', 'r', 'MarkerSize', 1, 'LineWidth', 1, 'MaximumNumPoints', 10000);

curve = [curve1 curve2];

set(gca, 'XLim', [-500 500], 'YLim', [-500 500]);

for i = 1:100:(size(djup, 2))
    addpoints(curve(1), djup(1, i) / scale, djup(2, i + 1) / scale, djup(3, i) / scale);
    drawnow;
    hold on;
    addpoints(curve(2), dnh(1, i) / scale, dnh(2, i + 1) / scale, dnh(3, i) / scale);
    drawnow;
    hold on;
%     frame = getframe(gcf); %get frame
%     writeVideo(myVideo, frame);
    date = datestr(datetime(2000, 1, 1) + seconds(etJ(i)));
    date_string = strcat('New Horizons. Date: ', date);
    legend('Jupiter', date_string, 'location', 'southeast');
end

% close(myVideo);

% Minimum distance date between Jupiter and New Horizons
min_dist_time_NHJup = linspace(etJ(J), etJ(J), 1);

% Jupiter's position in minimum distance date
[djup_t, lt] = cspice_spkezr('599', min_dist_time_NHJup, frame, abcorr, observer);

% Distance vector between Jupiter and New Horizons
v1 = [PosMin_NhJup(1, 1) / scale PosMin_NhJup(1, 2) / scale PosMin_NhJup(1, 3) / scale];
v2 = [djup_t(1, 1) / scale djup_t(2, 1) / scale djup_t(3, 1) / scale];
v = [v2; v1];
D = v2 - v1;

% Plot New Horizons Flyby on Jupiter
LW = 1; % LineWidth specification
plot_pdf3 = figure(3);
set(plot_pdf3, 'Position', [5 500 800 500])
plot3(dnh(1, :) / scale, dnh(2, :) / scale, dnh(3, :) / scale, 'g', 'LineWidth', LW);
hold on;
plot3(PosMin_NhJup(1, 1) / scale, PosMin_NhJup(1, 2) / scale, PosMin_NhJup(1, 3) / scale, 'b*', 'LineWidth', 6)
plot3(djup_t(1, 1) / scale, djup_t(2, 1) / scale, djup_t(3, 1) / scale, 'm*', 'LineWidth', 3);
plot3(v(:, 1), v(:, 2), v(:, 3), 'r')
quiver3(v1(1), v1(2), v1(3), D(1), D(2), D(3), 0, 'Color', [0 0 0]);

annotation('textbox', [0.75, 0.35, .19, .1], 'string', sprintf('Min dist NH-Jup: %.4f [km]', MinNhJup))
annotation('textbox', [0.75, 0.25, .19, .1], 'string', sprintf('Date: %s', convertCharsToStrings(utcstrNhJup)))

legend('New Horizons', 'Minimum Distance Position', 'Jupiter', 'Minimum Distance');
xlabel('x JR');
ylabel('y JR');
zlabel('z JR');
axis equal;
title("\textbf{New Horizons' flyby across Jupiter. Observer: Jupiter barycenter}");
grid on;
grid minor;

% 2D plot of New Horizons Flyby on Jupiter
LW = 1; % LineWidth specification
plot_pdf4 = figure(4);
set(plot_pdf4, 'Position', [805 500 800 500])
plot(dnh(1, :) / scale, dnh(2, :) / scale, 'g', 'LineWidth', LW);
hold on;
plot(PosMin_NhJup(1, 1) / scale, PosMin_NhJup(1, 2) / scale, 'b*', 'LineWidth', 6)
plot(djup_t(1, 1) / scale, djup_t(2, 1) / scale, 'm*', 'LineWidth', 3);
plot(v(:, 1), v(:, 2), 'r')
D = v2 - v1;
quiver(v1(1), v1(2), D(1), D(2), 0, 'Color', [0 0 0]);
legend('New Horizons', 'Minimum Distance Position', 'Jupiter', ...
    sprintf('Min dist NH-Jup: %.4f [km]', MinNhJup), 'location', 'southeast');
xlabel('x JR');
ylabel('y JR');
axis equal;
title('\textbf{2D plot of New Horizons flyby across Jupiter. Observer: Jupiter barycenter}');
grid on;
grid minor;

%% Pluto flyby (July 2015) %

% Time parameters                       _P designation for Pluto
utctimeP = '2015-07-10 T19:50:13';      % Start time
et0P     = cspice_str2et(utctimeP);     % Converts time (which is a string) to a number
NDAYSP   = 7;                          % Study time
et1P     = et0P + 24*3600*NDAYSP;       % End of query time
etP      = linspace(et0P,et1P,10000);   % Time interval

% Frame
frame  = 'ECLIPJ2000';
abcorr = 'NONE';

observer = '9';     % PLUTO BARYCENTER (9)
scale    = 1188.3;  % Pluto's radius (km)

[dplu,lt] = cspice_spkezr('999',etP,frame,abcorr,observer);           % Pluto
[dnh,lt]  = cspice_spkezr('NEW HORIZONS',etP,frame,abcorr,observer);  % New Horizons 
[dchar,lt]  = cspice_spkezr('901',etP,frame,abcorr,observer);         % Charon
[dsunP,lt] = cspice_spkezr('10',etP,frame,abcorr,observer);           % Sun

%[dnix,lt]  = cspice_spkezr('902',etP,frame,abcorr,observer); % Nix
%[dhydr,lt] = cspice_spkezr('903',etP,frame,abcorr,observer); % Hydra 

% Minimum Distance from New Horizons to: PLuto and Charon

% Create vectors to log the position of mininum distance from New Horizons to each body.
PosMin_NhPlu     = zeros(1,3);
PosMin_NhPCharon = zeros(1,3);

% Create vectors to log data for each distance
Dist_NhPlu    = zeros(1,10000);
Dist_NhCharon = zeros(1,10000);

% Calculate the first distance between Spacecraft (New Horizons) and the other bodies
Dist_NhPlu(1,1)    = sqrt( (dplu(1,1)-dnh(1,1))^2  + (dplu(2,1)-dnh(2,1))^2   + (dplu(3,1)-dnh(3,1))^2  ); 
Dist_NhCharon(1,1) = sqrt( (dchar(1,1)-dnh(1,1))^2 + (dchar(2,1)-dnh(2,1))^2  + (dchar(3,1)-dnh(3,1))^2 ); 

for i=2:10000
    
   Dist_NhPlu(1,i)    = sqrt( (dplu(1,i)-dnh(1,i))^2 + (dplu(2,i)-dnh(2,i))^2  + (dplu(3,i)-dnh(3,i))^2 );    % Calculate distance NH-Pluto
   Dist_NhCharon(1,i) = sqrt( (dchar(1,i)-dnh(1,i))^2 + (dchar(2,i)-dnh(2,i))^2  + (dchar(3,i)-dnh(3,i))^2 ); % Calculate distance NH-Pluto
   %Check current distance Nh-Pluto, with prior value 
   if (Dist_NhPlu(1,i) < Dist_NhPlu(1,i-1)) 
    PosMin_NhPlu(1,1) = dnh(1,i);           %If true, save position X Y Z of NewHorizons
    PosMin_NhPlu(1,2) = dnh(2,i);
    PosMin_NhPlu(1,3) = dnh(3,i);  
    MinNhPlu = Dist_NhPlu(1,i)/scale;       %If true, save Distance between Nh-Jupiter
    P=i;                                    %If true, save coluwmn's index where condition is satisfie
   end
   % Check current distance Nh-Charon, with prior value 
   if (Dist_NhCharon(1,i) < Dist_NhCharon(1,i-1)) 
    PosMin_NhPCharon(1,1) = dnh(1,i);       %If true, save position X Y Z of NewHorizons
    PosMin_NhPCharon(1,2) = dnh(2,i);
    PosMin_NhPCharon(1,3) = dnh(3,i);  
    MinNhCharon = Dist_NhCharon(1,i)/scale; %If true, save Distance between Nh-Charon
    Ch=i;                                   %If true, save coluwmn's index where condition is satisfied
   end
end
% Take the Date of the event of Minimum distance Nh-body %
utcstrNhPlu   = cspice_et2utc( etP(P), 'C', 5 );     %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Pluto
utcstrNhCharon = cspice_et2utc( etP(Ch), 'C', 5 );    %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Charon
% Plot New Horizons Flyby on Jupiter
LW = 1; % LineWidth specification
plot_pdf5 = figure(5);
set(plot_pdf5,'Position',[5 50 1000 600])
plot3(dplu(1,:)/scale,dplu(2,:)/scale,dplu(3,:)/scale,'r','LineWidth',LW);
hold on;
plot3(dnh(1,:)/scale,dnh(2,:)/scale,dnh(3,:)/scale,'b','LineWidth',LW);
plot3(dchar(1,:)/scale,dchar(2,:)/scale,dchar(3,:)/scale,'g','LineWidth',LW);
% Add the points of minimum distance between New Horizons and each body %
plot3(PosMin_NhPlu(1,1)/scale,PosMin_NhPlu(1,2)/scale,PosMin_NhPlu(1,3)/scale,'r*','LineWidth',2)
plot3(PosMin_NhPCharon(1,1)/scale,PosMin_NhPCharon(1,2)/scale,PosMin_NhPCharon(1,3)/scale,'g*','LineWidth',2)


% % Distance vector between Pluto and New Horizons
% Minimum distance date between Pluto and New Horizons 
min_dist_time_NHP = linspace(etP(P),etP(P),1);

% Pluto's position in minimum distance date. Not necessary since it's the
% observer though.
[dpluto_t,lt] = cspice_spkezr('999',min_dist_time_NHP,frame,abcorr,observer);

% Distance vector between Callisto and New Horizons
v1 = [PosMin_NhPlu(1,1)/scale PosMin_NhPlu(1,2)/scale PosMin_NhPlu(1,3)/scale];
v2 = [dpluto_t(1,1)/scale dpluto_t(2,1)/scale dpluto_t(3,1)/scale];
v  = [v2;v1];
D  = v2 - v1;

plot3(dpluto_t(1,1)/scale,dpluto_t(2,1)/scale,dpluto_t(3,1)/scale,'r*','LineWidth',3);
plot3(v(:,1),v(:,2),v(:,3),'k')
quiver3( v1(1), v1(2),v1(3), D(1), D(2),D(3),0, 'Color',[0 0 0]);


% % Distance vector between Charon and New Horizons
% Minimum distance date between Charon and New Horizons 
min_dist_time_NHCH = linspace(etP(Ch),etP(Ch),1);

% Pluto's position in minimum distance date. Not necessary since it's the
% observer though.
[dch_t,lt] = cspice_spkezr('901',min_dist_time_NHCH,frame,abcorr,observer);

% Distance vector between Callisto and New Horizons
v1 = [PosMin_NhPCharon(1,1)/scale PosMin_NhPCharon(1,2)/scale PosMin_NhPCharon(1,3)/scale];
v2 = [dch_t(1,1)/scale dch_t(2,1)/scale dch_t(3,1)/scale];
v  = [v2;v1];
D  = v2 - v1;

plot3(dch_t(1,1)/scale,dch_t(2,1)/scale,dch_t(3,1)/scale,'g*','LineWidth',2);
plot3(v(:,1),v(:,2),v(:,3),'k')
quiver3( v1(1), v1(2),v1(3), D(1), D(2),D(3),0, 'Color',[0 0 0]);

% %% SUN
% plot3(dsunP(1,P)/scale,dsunP(2,P)/scale,dsunP(3,P)/scale,'k','LineWidth',5); % Sun position respect Jupiter's barycenter when NewHorizons is closest to Jupiter.
% % % Distance vector between Pluto and Sun
% % Minimum distance date between Pluto and New Horizons 
% 
% min_dist_time_PS = linspace(etP(P),etP(P),1);
% 
% % Sun's position in minimum distance date
% [dsunP_t,lt] = cspice_spkezr('10',min_dist_time_PS,frame,abcorr,observer);
% 
% % Distance vector between Pluto and Sun
% v1 = [dsunP_t(1,1)/scale dsunP_t(2,1)/scale dsunP_t(3,1)/scale];
% v2 = [dplu(1,P)/scale dplu(2,P)/scale dplu(3,P)/scale];
% v  = [v2;v1];
% D  = v2 - v1;
% plot3(dsunP(1,P)/scale,dsunP(2,P)/scale,dsunP(3,P)/scale,'k.','LineWidth',900); % Sun position respect Jupiter's barycenter when NewHorizons is closest to Jupiter.
% plot3(v(:,1),v(:,2),v(:,3),'k')
% quiver3( v1(1), v1(2),v1(3), D(1), D(2),D(3),0, 'Color',[0 0 0]);


xlim([-20 20])
ylim([-500 500])
zlim([-50 50])

legend('Pluto','New Horizons','Charon');
title('\textbf{New Horizons flyby. Observer: Pluto Barycenter}');
xlabel('x PR');
ylabel('y PR');
zlabel('z PR');
grid on;
grid minor;

annotation('textbox', [0.77, 0.62, .10, .12], 'string', sprintf('Min dist NH-Charon %.4f [km]',MinNhCharon))
annotation('textbox', [0.87, 0.62, .12, .12], 'string', sprintf('Date: %s',convertCharsToStrings(utcstrNhCharon)))

annotation('textbox', [0.77, 0.50, .10, .12], 'string', sprintf('Min dist NH-Pluto: %.4f [km]', MinNhPlu))
annotation('textbox', [0.87, 0.50, .12, .12], 'string', sprintf('Date: %s',convertCharsToStrings(utcstrNhPlu)))

view([-0.0178    8.4399    0.0568])

% New Horizons flyby animation
% To save the video uncomment lines 615-616,649-650 and 656

% Initialise video
% myVideo = VideoWriter('NewHorizonsFlybyPluto'); %open video file
% myVideo.FrameRate = 30;
% open(myVideo)

plot_pdf6 = figure(6);
set(plot_pdf6, 'Position', [1000 50 920 600])
xlabel('x PR');
ylabel('y PR');
zlabel('z PR');
title("\textbf{New Horizons' flyby across Pluto}");
grid on;
grid minor;

% Pluto
curve1 = animatedline('Marker', 'o', 'MaximumNumPoints', 1, 'Color', 'b', 'MarkerSize', 4, 'LineWidth', 1, 'MaximumNumPoints', 1);
% New Horizons
curve2 = animatedline('Marker', 'o', 'MaximumNumPoints', 1, 'Color', 'r', 'MarkerSize', 1, 'LineWidth', 1, 'MaximumNumPoints', 10000);
% Charon
curve3 = animatedline('Marker', 'o', 'MaximumNumPoints', 1, 'Color', 'k', 'MarkerSize', 4, 'LineWidth', 1, 'MaximumNumPoints', 1);

curve = [curve1 curve2 curve3];

set(gca, 'XLim', [-40 60], 'YLim', [-4000 4000]);

for i = 1:100:(size(dplu, 2))
    addpoints(curve(1), dplu(1, i) / scale, dplu(2, i + 1) / scale, dplu(3, i) / scale);
    drawnow;
    hold on;
    addpoints(curve(2), dnh(1, i) / scale, dnh(2, i + 1) / scale, dnh(3, i) / scale);
    drawnow;
    hold on;
    addpoints(curve(3), dchar(1, i) / scale, dchar(2, i + 1) / scale, dchar(3, i) / scale);
    drawnow;
    hold on;
%     frame = getframe(gcf); %get frame
%     writeVideo(myVideo, frame);
    date = datestr(datetime(2000, 1, 1) + seconds(etP(i)));
    date_string = strcat('New Horizons. Date: ', date);
    legend('Pluto', date_string, 'Charon', 'location', 'northwest');
end

% close(myVideo);

%% Save figures

% Figure 1
% set(plot_pdf1, 'Units', 'Centimeters');
% pos = get(plot_pdf1, 'Position');
% set(plot_pdf1, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
    %     'PaperSize', [pos(3), pos(4)]);
% print(plot_pdf1, 'figure1.pdf', '-dpdf', '-r1500');
%
% % Figure 2
% set(plot_pdf2, 'Units', 'Centimeters');
% pos = get(plot_pdf2, 'Position');
% set(plot_pdf2, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
    %     'PaperSize', [pos(3), pos(4)]);
% print(plot_pdf2, 'figure2.pdf', '-dpdf', '-r1500');
%
% % Figure 3
% set(plot_pdf3, 'Units', 'Centimeters');
% pos = get(plot_pdf3, 'Position');
% set(plot_pdf3, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
    %     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf3, 'figure3.pdf', '-dpdf', '-r1500');
%
% % Figure 4
% set(plot_pdf4, 'Units', 'Centimeters');
% pos = get(plot_pdf4, 'Position');
% set(plot_pdf4, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
    %     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf4, 'figure4.pdf', '-dpdf', '-r0');
%
% % Figure 5
% set(plot_pdf5, 'Units', 'Centimeters');
% pos = get(plot_pdf5, 'Position');
% set(plot_pdf5, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
    %     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf5, 'figure5.pdf', '-dpdf', '-r1500');
%
% % Figure 6
% set(plot_pdf6, 'Units', 'Centimeters');
% pos = get(plot_pdf6, 'Position');
% set(plot_pdf6, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
    %     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf6, 'figure6.pdf', '-dpdf', '-r1500');
