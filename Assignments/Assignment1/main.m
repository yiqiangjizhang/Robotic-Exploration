%-------------------------------------------------------------------------%
% Assignment 2: Spacecraft trajectory queries. For instance, plotting the trajectory during a flyby and
% finding the minimum distance from the spacecraft to each of the bodies
%-------------------------------------------------------------------------%

% Date: 06/05/2021
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
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

% Recall that RESSlib should be in Matlab Path 
% Addpath Yi Qiang
addpath 'C:\Users\yiqia\Documents\Spice_Doc\RESSlib'
% Addpath Iván
addpath('D:\HDD_Data\Iván\Workload\Q8-GRETA\Robotic_Exploration_of_the_Solar_System\RESSlib')
% Addpath Èric
addpath('F:\RESSoptativa\Resslib')
% Addpath Rita
addpath('C:\Users\Rita Fardilha\Desktop\RESSlib/');

% Addpath Manel Soria
% addpath('');

% From kernels we get the desired data.
    METAKR={
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
    
    
    %'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/plu055.bsp', ...
    %'https://naif.jpl.nasa.gov/pub/naif/pds/data/nh-j_p_ss-spice-6-v1.0/nhsp_1000/data/spk/nh_plu017.bsp'
    %'https://naif.jpl.nasa.gov/pub/naif/pds/data/nh-j_p_ss-spice-6-v1.0/nhsp_1000/data/spk/nh_plu047_od122.bsp', ...
    %'https://naif.jpl.nasa.gov/pub/naif/pds/data/nh-j_p_ss-spice-6-v1.0/nhsp_1000/data/spk/nh_recon_arrokoth_od147_v01.bsp', ...
    %'https://naif.jpl.nasa.gov/pub/naif/pds/data/nh-j_p_ss-spice-6-v1.0/nhsp_1000/data/spk/nh_recon_pluto_od122_v01.bsp'
    

% Print RESSLIB version
v=initSPICEv(fullK(METAKR));
fprintf('RESSLIB version %s \n',v);


%% Jupiter flyby (Feb 2007)

% Time parameters                    _J designation for Jupiter
utctimeJ='2007-02-01 T19:50:13';     % Start time
et0J = cspice_str2et(utctimeJ);      % Converts time (which is a string) to a number
NDAYSJ = 30;                        % Study time
et1J = et0J + 24*3600*NDAYSJ;        % End of query time
etJ = linspace(et0J,et1J,10000);     % Time interval

% Frame
frame = 'ECLIPJ2000';
abcorr = 'NONE';

% Observer will be Pluto barycenter
observer = '5'; % JUPITER BARYCENTER (5)
scale = 66854;  % Jupiter's polar radius (km)

% Ephemeris data
[dnh,lt]  = cspice_spkezr('NEW HORIZONS',etJ,frame,abcorr,observer); % New Horizons
[djup,lt] = cspice_spkezr('599',etJ,frame,abcorr,observer);          % Jupiter 
[dio,lt]  = cspice_spkezr('501',etJ,frame,abcorr,observer);          % Io
[deur,lt] = cspice_spkezr('502',etJ,frame,abcorr,observer);          % Europa
[dgan,lt] = cspice_spkezr('503',etJ,frame,abcorr,observer);          % Ganymede 
[dcal,lt] = cspice_spkezr('504',etJ,frame,abcorr,observer);          % Callisto


% Minimum Distance from New Horizons to: Jupiter, Io, Europa, Ganymede, Callisto

% Create vectors to log the position of mininum distance from New Horizons to each body.
PosMin_NhJup=zeros(1,3);
PosMin_NhIo=zeros(1,3);
PosMin_NhEuropa=zeros(1,3);
PosMin_NhGanymede=zeros(1,3);
PosMin_NhCallisto=zeros(1,3);

% Create vectors to log data for each distance
Dist_NhJup=zeros(1,10000);
Dist_NhIo=zeros(1,10000);
Dist_NhEuropa=zeros(1,10000);
Dist_NhGanymede=zeros(1,10000);
Dist_NhCallisto=zeros(1,10000);

% Calculate the first distance between Spacecraft (New Horizons) and the other bodies
Dist_NhJup(1,1)      = sqrt(   (djup(1,1)-dnh(1,1))^2 + (djup(2,1)-dnh(2,1))^2  + (djup(3,1)-dnh(3,1))^2  ); 
Dist_NhIo(1,1)       = sqrt(   (dio(1,1)-dnh(1,1))^2  + (dio(2,1)-dnh(2,1))^2   + (dio(3,1)-dnh(3,1))^2   ); 
Dist_NhEuropa(1,1)   = sqrt(   (deur(1,1)-dnh(1,1))^2 + (deur(2,1)-dnh(2,1))^2  + (deur(3,1)-dnh(3,1))^2  ); 
Dist_NhGanymede(1,1) = sqrt(   (dgan(1,1)-dnh(1,1))^2 + (dgan(2,1)-dnh(2,1))^2  + (dgan(3,1)-dnh(3,1))^2  ); 
Dist_NhCallisto(1,1) = sqrt(   (dcal(1,1)-dnh(1,1))^2 + (dcal(2,1)-dnh(2,1))^2  + (dcal(3,1)-dnh(3,1))^2  ); 

for i=2:10000
    
   Dist_NhJup(1,i)      = sqrt(   (djup(1,i)-dnh(1,i))^2 + (djup(2,i)-dnh(2,i))^2  + (djup(3,i)-dnh(3,i))^2  ); %Calculate distance NH-Jupiter
   Dist_NhIo(1,i)       = sqrt(   (dio(1,i)-dnh(1,i))^2  + (dio(2,i)-dnh(2,i))^2   + (dio(3,i)-dnh(3,i))^2   ); %Calculate distance NH-Io
   Dist_NhEuropa(1,i)   = sqrt(   (deur(1,i)-dnh(1,i))^2 + (deur(2,i)-dnh(2,i))^2  + (deur(3,i)-dnh(3,i))^2  ); %Calculate distance NH-Europa
   Dist_NhGanymede(1,i) = sqrt(   (dgan(1,i)-dnh(1,i))^2 + (dgan(2,i)-dnh(2,i))^2  + (dgan(3,i)-dnh(3,i))^2  ); %Calculate distance NH-Ganymede
   Dist_NhCallisto(1,i) = sqrt(   (dcal(1,i)-dnh(1,i))^2 + (dcal(2,i)-dnh(2,i))^2  + (dcal(3,i)-dnh(3,i))^2  ); %Calculate distance NH-Callisto

   %Check current distance Nh-Jupiter, with prior value 
   if (Dist_NhJup(1,i) < Dist_NhJup(1,i-1)) 
    PosMin_NhJup(1,1)=dnh(1,i);           %If true, save position X Y Z of NewHorizons
    PosMin_NhJup(1,2)=dnh(2,i);
    PosMin_NhJup(1,3)=dnh(3,i);  
    MinNhJup=Dist_NhJup(1,i)/scale;       %If true, save Distance between Nh-Jupiter
    J=i;                                  %If true, save coluwmn's index where condition is satisfied
   end
   %Check current distance Nh-Io, with prior value 
   if (Dist_NhIo(1,i) < Dist_NhIo(1,i-1)) 
    PosMin_NhIo(1,1)=dnh(1,i);            %If true, save position X Y Z of NewHorizons
    PosMin_NhIo(1,2)=dnh(2,i);
    PosMin_NhIo(1,3)=dnh(3,i);
    MinNhIo=Dist_NhIo(1,i)/scale;          %If true, save Distance between Nh-Io
    I=i;                                   %If true, save coluwmn's index where condition is satisfied
   end
   %Check current distance Nh-Europa, with prior value 
   if (Dist_NhEuropa(1,i) < Dist_NhEuropa(1,i-1)) 
    PosMin_NhEuropa(1,1)=dnh(1,i);          %If true, save position X Y Z of NewHorizons
    PosMin_NhEuropa(1,2)=dnh(2,i);
    PosMin_NhEuropa(1,3)=dnh(3,i);
    MinNhEuropa=Dist_NhEuropa(1,i)/scale;   %If true, save Distance between Nh-Europa
    E=i;                                    %If true, save coluwmn's index where condition is satisfied
   end
   %Check current distance Nh-Ganymede, with prior value 
   if (Dist_NhGanymede(1,i) < Dist_NhGanymede(1,i-1))
    PosMin_NhGanymede(1,1)=dnh(1,i);          %If true, save position X Y Z of NewHorizons
    PosMin_NhGanymede(1,2)=dnh(2,i);
    PosMin_NhGanymede(1,3)=dnh(3,i);
    MinNhGanymede=Dist_NhCallisto(1,i)/scale;  %If true, save Distance between Nh-Ganymede
    G=i;                                       %If true, save coluwmn's index where condition is satisfied
   end
   %Check current distance Nh-Callisto, with prior value 
   if (Dist_NhCallisto(1,i) < Dist_NhCallisto(1,i-1)) 
    PosMin_NhCallisto(1,1)=dnh(1,i);        %If true, save position X Y Z of NewHorizons
    PosMin_NhCallisto(1,2)=dnh(2,i);
    PosMin_NhCallisto(1,3)=dnh(3,i);
    MinNhCallisto=Dist_NhJup(1,i)/scale;    %If true, save Distance between NH-Callisto
    C=i;                                    %If true, save coluwmn's index where condition is satisfied
   end

end
% Take the Date of the event of Minimum distance Nh-body %
utcstrNhJup= cspice_et2utc( etJ(J), 'C', 5 );      %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Jupiter
utcstrNhIo= cspice_et2utc( etJ(I), 'C', 5 );       %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Io
utcstrNhEuropa= cspice_et2utc( etJ(E), 'C', 5 );   %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Europa
utcstrNhGanymede= cspice_et2utc( etJ(G), 'C', 5 ); %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Ganymede
utcstrNhCallisto= cspice_et2utc( etJ(C), 'C', 5 ); %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Callisto


% Plot New Horizons Flyby on Jupiter with the Io, Europa,Ganymede and Calllisto orbits %
LW = 1; % LineWidth specification
plot_pdf1 = figure(1);
set(plot_pdf1,'Position',[475 250 800 500])
plot3(djup(1,:)/scale,djup(2,:)/scale,djup(3,:)/scale,'r','LineWidth',LW);
hold on;
plot3(dnh(1,:)/scale,dnh(2,:)/scale,dnh(3,:)/scale,'g','LineWidth',LW);
plot3(dio(1,:)/scale,dio(2,:)/scale,dio(3,:)/scale,'b','LineWidth',LW);
plot3(deur(1,:)/scale,deur(2,:)/scale,deur(3,:)/scale,'y','LineWidth',LW);
plot3(dcal(1,:)/scale,dcal(2,:)/scale,dcal(3,:)/scale,'c','LineWidth',LW);

% Add the points of minimum distance between New Horizons and each body %
plot3(PosMin_NhJup(1,1)/scale,PosMin_NhJup(1,2)/scale,PosMin_NhJup(1,3)/scale,'r*','LineWidth',6)
plot3(PosMin_NhIo(1,1)/scale,PosMin_NhIo(1,2)/scale,PosMin_NhIo(1,3)/scale,'g*','LineWidth',6)
plot3(PosMin_NhEuropa(1,1)/scale,PosMin_NhEuropa(1,2)/scale,PosMin_NhEuropa(1,3)/scale,'b*','LineWidth',6)
plot3(PosMin_NhGanymede(1,1)/scale,PosMin_NhGanymede(1,2)/scale,PosMin_NhGanymede(1,3)/scale,'y*','LineWidth',6)
plot3(PosMin_NhCallisto(1,1)/scale,PosMin_NhCallisto(1,2)/scale,PosMin_NhCallisto(1,3)/scale,'c*','LineWidth',6)

% Initialise video
% myVideo = VideoWriter('NewHorizonsFlyby'); %open video file
% myVideo.FrameRate = 30;  
% open(myVideo)

plot_pdf = figure(5);
% Jupiter
curve1 = animatedline('Marker','o','MaximumNumPoints',1,'Color','b','MarkerSize',4,'LineWidth',1,'MaximumNumPoints',100);
% New Horizons
curve2 = animatedline('Marker','o','MaximumNumPoints', 1,'Color','r','MarkerSize',1,'LineWidth',1,'MaximumNumPoints',10000);

curve = [curve1 curve2];

set(gca, 'XLim', [-500 500], 'YLim', [-500 500]);

for i=1:100:(size(djup,2))
    addpoints(curve(1),djup(1,i)/scale,djup(2,i+1)/scale,djup(3,i)/scale);
    drawnow;
    hold on;
    addpoints(curve(2),dnh(1,i)/scale,dnh(2,i+1)/scale,dnh(3,i)/scale);
    drawnow;
    hold on;
    % frame = getframe(gcf); %get frame
    % writeVideo(myVideo, frame);
    date = datetime(2000,1,1) + seconds(etJ(i));
    legend(datestr(date),'location','southeast');
end

% close(myVideo);

% Minimum distance date between Jupiter and New Horizons 
min_dist_time_NHJup = linspace(etJ(J),etJ(J),1);

% Jupiter's position in minimum distance date
[djup_t,lt] = cspice_spkezr('599',min_dist_time_NHJup,frame,abcorr,observer);

% Distance vector between Jupiter and New Horizons
v1=[PosMin_NhJup(1,1)/scale PosMin_NhJup(1,2)/scale PosMin_NhJup(1,3)/scale];
v2=[djup_t(1,1)/scale djup_t(2,1)/scale djup_t(3,1)/scale];
v=[v2;v1];
D = v2 - v1;


% Plot New Horizons Flyby on Jupiter
LW = 1; % LineWidth specification
plot_pdf2 = figure(2);
set(plot_pdf2,'Position',[475 250 900 510])
plot3(dnh(1,:)/scale,dnh(2,:)/scale,dnh(3,:)/scale,'g','LineWidth',LW);
hold on;
plot3(PosMin_NhJup(1,1)/scale,PosMin_NhJup(1,2)/scale,PosMin_NhJup(1,3)/scale,'b*','LineWidth',6)
plot3(djup_t(1,1)/scale,djup_t(2,1)/scale,djup_t(3,1)/scale,'m*','LineWidth',3);
plot3(v(:,1),v(:,2),v(:,3),'r')
quiver3( v1(1), v1(2), v1(3), D(1), D(2), D(3), 0, 'Color',[0 0 0]);

annotation('textbox', [0.75, 0.35, .19, .1], 'string', sprintf('Min dist NH-Jup: %.4f [km]',MinNhJup))
annotation('textbox', [0.75, 0.25, .19, .1], 'string', sprintf('Date: %s',convertCharsToStrings(utcstrNhJup)))

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
plot_pdf3 = figure(3);
set(plot_pdf3,'Position',[475 250 800 500])
plot(dnh(1,:)/scale,dnh(2,:)/scale,'g','LineWidth',LW);
hold on;
plot(PosMin_NhJup(1,1)/scale,PosMin_NhJup(1,2)/scale,'b*','LineWidth',6)
plot(djup_t(1,1)/scale,djup_t(2,1)/scale,'m*','LineWidth',3);
plot(v(:,1),v(:,2),'r')
D = v2 - v1;
quiver( v1(1), v1(2), D(1), D(2), 0, 'Color', [0 0 0]);
legend('New Horizons', 'Minimum Distance Position', 'Jupiter', ...
    sprintf('Min dist NH-Jup: %.4f [km]',MinNhJup), 'location','southeast');
xlabel('x JR');
ylabel('y JR');
axis equal;
title('\textbf{2D plot of New Horizons flyby across Jupiter. Observer: Jupiter barycenter}');
grid on;
grid minor;



%% Pluto flyby (July 2015) %

% Time parameters                   _P designation for Pluto
utctimeP='2015-06-01 T19:50:13';    % Start time
et0P = cspice_str2et(utctimeP);     % Converts time (which is a string) to a number
NDAYSP = 10;                        % Study time
et1P = et0P + 24*3600*NDAYSP;       % End of query time
etP=linspace(et0P,et1P,10000);      % Time interval


observer = '9'; % PLUTO BARYCENTER (9)
scale = 1188.3 ; % Pluto's radius (km)

[dplu,lt] = cspice_spkezr('999',etP,frame,abcorr,observer);         % Pluto
[dnh,lt] = cspice_spkezr('NEW HORIZONS',etP,frame,abcorr,observer); % New Horizons 

[dnh,lt] = cspice_spkezr('NEW HORIZONS',etP,frame,abcorr,observer); % New Horizons
[djup,lt] = cspice_spkezr('599',etP,frame,abcorr,observer);         % Jupiter 

[dchar,lt] = cspice_spkezr('901',etP,frame,abcorr,observer); % Charon
%[dnix,lt] = cspice_spkezr('902',etP,frame,abcorr,observer); % Nix
%[dhydr,lt] = cspice_spkezr('903',etP,frame,abcorr,observer); % Hydra 

% Minimum Distance from New Horizons to: PLuto and Charon

% Create vectors to log the position of mininum distance from New Horizons to each body.
PosMin_NhPlu=zeros(1,3);
PosMin_NhPCharon=zeros(1,3);

% Create vectors to log data for each distance
Dist_NhPlu=zeros(1,10000);
Dist_NhCharon=zeros(1,10000);

% Calculate the first distance between Spacecraft (New Horizons) and the other bodies
Dist_NhPlu(1,1)    = sqrt( (dplu(1,1)-dnh(1,1))^2  + (dplu(2,1)-dnh(2,1))^2   + (dplu(3,1)-dnh(3,1))^2  ); 
Dist_NhCharon(1,1) = sqrt( (dchar(1,1)-dnh(1,1))^2 + (dchar(2,1)-dnh(2,1))^2  + (dchar(3,1)-dnh(3,1))^2 ); 

for i=2:10000
    
   Dist_NhPlu(1,i) = sqrt( (djup(1,i)-dnh(1,i))^2 + (djup(2,i)-dnh(2,i))^2  + (djup(3,i)-dnh(3,i))^2 ); %Calculate distance NH-Pluto
   Dist_NhCharon(1,i) = sqrt( (dchar(1,i)-dnh(1,i))^2 + (dchar(2,i)-dnh(2,i))^2  + (dchar(3,i)-dnh(3,i))^2 ); %Calculate distance NH-Pluto
   %Check current distance Nh-Pluto, with prior value 
   if (Dist_NhPlu(1,i) < Dist_NhPlu(1,i-1)) 
    PosMin_NhPlu(1,1)=dnh(1,i);           %If true, save position X Y Z of NewHorizons
    PosMin_NhPlu(1,2)=dnh(2,i);
    PosMin_NhPlu(1,3)=dnh(3,i);  
    MinNhPlu=Dist_NhPlu(1,i)/scale;       %If true, save Distance between Nh-Jupiter
    P=i;                                  %If true, save coluwmn's index where condition is satisfied
   else P=1;
   end
   %Check current distance Nh-Charon, with prior value 
   if (Dist_NhCharon(1,i) < Dist_NhCharon(1,i-1)) 
    PosMin_NhPCharon(1,1)=dnh(1,i);       %If true, save position X Y Z of NewHorizons
    PosMin_NhPCharon(1,2)=dnh(2,i);
    PosMin_NhPCharon(1,3)=dnh(3,i);  
    MinNhCharon=Dist_NhCharon(1,i)/scale; %If true, save Distance between Nh-Charon
    Ch=i;                                 %If true, save coluwmn's index where condition is satisfied
   end
end
% Take the Date of the event of Minimum distance Nh-body %
%utcstrNhPlu= cspice_et2utc( etP(P), 'C', 5 );      %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Pluto
utcstrNhCharon= cspice_et2utc( etP(Ch), 'C', 5 );      %Convert ephemeris time into UTC format C calendar. Date of Minimum distance between NewHorizons and Charon
% Plot New Horizons Flyby on Jupiter
LW = 1; % LineWidth specification
plot_pdf4 = figure(4);
plot3(dplu(1,:)/scale,dplu(2,:)/scale,dplu(3,:)/scale,'r','LineWidth',LW);
hold on;
plot3(dnh(1,:)/scale,dnh(2,:)/scale,dnh(3,:)/scale,'b','LineWidth',LW);
plot3(dchar(1,:)/scale,dchar(2,:)/scale,dchar(3,:)/scale,'g','LineWidth',LW);
legend('Pluto','New Horizons','Charon');