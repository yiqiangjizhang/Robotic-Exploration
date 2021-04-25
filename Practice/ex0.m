%% Voyager 1 and 2, with Sun as Observer
%
%-------------------------------------------------------------------------%
% Exercise: This code plots the position of Voyagers 1 and 2 with Sun as
% the observer
%-------------------------------------------------------------------------%

% Date: 23/04/2021
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
addpath 'C:\Users\yiqia\Documents\Spice_Doc\RESSlib'


% From kernels we get the desired data.
METAKR={'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls', ... % leap seconds
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/vgr1_jup230.bsp',... % kernel of voyager 1's flyby of Jupiter 
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/vgr2_jup230.bsp',... % kernel of voyager 2's flyby of Jupiter 
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/jup365.bsp' }; % Jupiter system

% Print RESSLIB version
v=initSPICEv(fullK(METAKR));
fprintf('RESSLIB version %s \n',v);

% Time parameters
utctime='1979-03-03 T00:00:00'; % 1979-03-03 T00:00:00
utctime2='1979-07-07 T00:00:00'; % 1979-07-07 T00:00:00
et0 = cspice_str2et(utctime); %converts time (which is a string) to a number
et02 = cspice_str2et(utctime2); %converts time (which is a string) to a number
NDAYS = 12; % study time
et1 = et0 + 24*3600*NDAYS; % end of query time
et12 = et02 + 24*3600*NDAYS; % end of query time

et=linspace(et0,et1,10000);
et2=linspace(et02,et12,10000);

LW=3; % LineWidth of the plots

frame = 'ECLIPJ2000';
abcorr = 'NONE';

%% Minimum distance trajectory computation

% The same but the observer now will be Jupiter barycenter
observer = '5'; % Jupiter barycenter (not Jupiter system barycenter)
scale = 66854; % Jupiter polar radius (km) 149597871; %

[djup,lt] = cspice_spkezr('599',et,frame,abcorr,observer); % jupiter 
[dio, lt] = cspice_spkezr('501',et2,frame,abcorr,observer); % io
[deu, lt] = cspice_spkezr('502',et2,frame,abcorr,observer); % europa
[dv1, lt] = cspice_spkezr('VG1',et,frame,abcorr,observer); % voyager1
[dv2, lt] = cspice_spkezr('VG2',et2,frame,abcorr,observer); % voyager2
[dsun, lt] = cspice_spkezr('10',et2,frame,abcorr,observer); % Sun

% Initialize vector
Pos1=zeros(1,3);
Pos2=zeros(1,3);
Dist1=zeros(1,length(et));
Dist2=zeros(1,length(et));

% Initial distance
Dist1(1,1)= sqrt(   (djup(1,1)-dv1(1,1))^2 + (djup(2,1)-dv1(2,1))^2 + (djup(3,1)-dv1(3,1))^2  ); 
Dist2(1,1)= sqrt(   (djup(1,1)-dv2(1,1))^2 + (djup(2,1)-dv2(2,1))^2 + (djup(3,1)-dv2(3,1))^2  );

% Loop through all the time step
for i=2:length(et)
    
   Dist1(1,i)= sqrt(   (djup(1,i)-dv1(1,i))^2 + (djup(2,i)-dv1(2,i))^2 + (djup(3,i)-dv1(3,i))^2  ); %Calculate distance V1-Jupiter
   Dist2(1,i)= sqrt(   (djup(1,i)-dv2(1,i))^2 + (djup(2,i)-dv2(2,i))^2 + (djup(3,i)-dv2(3,i))^2  ); %Calculate distance V2-Jupiter
   
   % VOYAGER 1
   if (Dist1(1,i) < Dist1(1,i-1)) % Check current distance with past value
    Pos1(1,1)=dv1(1,i); % If true, save position X Y Z of V1
    Pos1(1,2)=dv1(2,i);
    Pos1(1,3)=dv1(3,i);
    Min1=Dist1(1,i)/scale; % If true, save Distance between V1-JUP
    a=i; % If true, save column's index where condition is satisfied
   
   end
   
   % VOYAGER 2
   if (Dist2(1,i) < Dist2(1,i-1)) % Check current distance with past value
    Pos2(1,1)=dv2(1,i); % If true, save position X Y Z of V2
    Pos2(1,2)=dv2(2,i);
    Pos2(1,3)=dv2(3,i);
    Min2=Dist2(1,i)/scale; % If true, save Distance between V2-JUP
    b=i; % If true, save column's index where condition is satisfied
   end 
end

% Get UTC time
utcstrV1= cspice_et2utc( et(a), 'C', 5 ); % Convert ephemeris time into UTC format C calendar. Date of the closest position to saturn.v1
utcstrV2= cspice_et2utc( et2(b), 'C', 5 ); % Convert ephemeris time into UTC format C calendar. Date of the closest position to saturn.v2

plot_pdf = figure(1);
set(plot_pdf,'Position',[100 100 1000 700])
plot3(djup(1,:)/scale,djup(2,:)/scale,djup(3,:)/scale,'r','LineWidth',LW)
hold on
plot3(dio(1,:)/scale,dio(2,:)/scale,dio(3,:)/scale,'g','LineWidth',LW)
plot3(deu(1,:)/scale,deu(2,:)/scale,deu(3,:)/scale,'b','LineWidth',LW)
plot3(dv1(1,:)/scale,dv1(2,:)/scale,dv1(3,:)/scale,'k','LineWidth',LW)
plot3(dv2(1,:)/scale,dv2(2,:)/scale,dv2(3,:)/scale,'y','LineWidth',LW)
plot3(Pos1(1,1)/scale,Pos1(1,2)/scale,Pos1(1,3)/scale,'g*','LineWidth',6)
plot3(Pos2(1,1)/scale,Pos2(1,2)/scale,Pos2(1,3)/scale,'r*','LineWidth',6)

text(Pos1(1,1)/scale,-20,Pos1(1,3)/scale,'V1-JP = 5.2187 JR')
text(-10,-20,Pos1(1,3)/scale,'V1-JP 1979 MAR 05 12:04:32.18718')
text(-35,-25,Pos2(1,3)/scale,'V2-JP = 10.7919 JR')
text(-45,-25,Pos2(1,3)/scale,'V2-JP 1979 JUL 09 22:29:16.25571')

xlabel('JR');
ylabel('JR');
zlabel('JR');
axis('equal');
legend({'Jupiter','Io','E','V1','V2','Pos1','Pos2'});
title('\textbf{Jupiter Voyager 1 and 2 flyby. Obs: Jupiter barycenter}');
grid on
grid minor
% set(findall(gcf,'-property','FontSize'),'FontSize',18);


% % Save png
print(gcf,'jupiter_voyager12_flyby.png','-dpng','-r1000');

% Plot 2
plot_pdf2 = figure(2);
set(plot_pdf2,'Position',[200 100 800 500])
plot3(Pos1(1,1)/scale,Pos1(1,2)/scale,Pos1(1,3)/scale,'g*','LineWidth',6)
hold on
plot3(Pos2(1,1)/scale,Pos2(1,2)/scale,Pos2(1,3)/scale,'r*','LineWidth',6)
plot3(djup(1,:)/scale,djup(2,:)/scale,djup(3,:)/scale,'b*','LineWidth',LW)
% plot3(dsun(1,:)/scale,dsun(2,:)/scale,dsun(3,:)/scale,'p','LineWidth',LW)
xlabel('JR');
ylabel('JR');
zlabel('JR');
legend({'PosV1','PosV2','Jupiter','Sun'});
title('\textbf{Minimum position of Voyager 1 and 2 flyby across Jupiter. Obs: Jupiter barycenter}');
grid on
grid minor

% Save png
print(gcf,'minimum_pos_voyager12.png','-dpng','-r1000');

%% Maximum velocity computation

% Initialize vector
V1_max_vel = zeros(1,3); %(x,y,z)
V2_max_vel = zeros(1,3); %(x,y,z)
V1_pos_max_vel = zeros(1,3); %(x,y,z)
V2_pos_max_vel = zeros(1,3); %(x,y,z)
v_V1 = zeros(1,length(et)); 
v_V2 = zeros(1,length(et));

% Initial distance
% Velocity of Voyager 1 and Voyager 2
v_V1(1,1)= sqrt(   (dv1(4,1))^2 + (dv1(5,1))^2 + (dv1(6,1))^2  ); 
v_V2(1,1)= sqrt(   (dv2(4,1))^2 + (dv2(5,1))^2 + (dv2(6,1))^2  );

% Loop through all the time step
for i=2:length(et)
    
   v_V1(1,i)= sqrt(   (dv1(4,i))^2 + (dv1(5,i))^2 + (dv1(6,i))^2  ); %Calculate distance V1-Jupiter
   v_V2(1,i)= sqrt(   (dv2(4,i))^2 + (dv2(5,i))^2 + (dv2(6,i))^2  ); %Calculate distance V2-Jupiter
   
   % VOYAGER 1
   if (v_V1(1,i) > v_V1(1,i-1)) % Check current distance with past value
    V1_max_vel(1,1)=dv1(4,i); % If true, save position X Y Z of V1
    V1_max_vel(1,2)=dv1(5,i);
    V1_max_vel(1,3)=dv1(6,i);
    a=i; % If true, save column's index where condition is satisfied
   end
   
   % VOYAGER 2
   if (v_V2(1,i) < v_V2(1,i-1)) % Check current distance with past value
    V2_max_vel(1,1)=dv2(4,i); % If true, save position X Y Z of V1
    V2_max_vel(1,2)=dv2(5,i);
    V2_max_vel(1,3)=dv2(6,i);
    b=i; % If true, save column's index where condition is satisfied
   end 
end

% Get the position of the maximum velocities
V1_pos_max_vel(1,1) = dv1(1,a);
V1_pos_max_vel(1,2) = dv1(2,a);
V1_pos_max_vel(1,3) = dv1(3,a);

V2_pos_max_vel(1,1) = dv2(1,a);
V2_pos_max_vel(1,2) = dv2(2,a);
V2_pos_max_vel(1,3) = dv2(3,a);


plot_pdf3 = figure(3);
set(plot_pdf3,'Position',[200 100 800 500])
plot3(V1_pos_max_vel(1)/scale,V1_pos_max_vel(2)/scale,V1_pos_max_vel(3)/scale,'g*','LineWidth',6);
hold on
plot3(V2_pos_max_vel(1)/scale,V2_pos_max_vel(2)/scale,V2_pos_max_vel(3)/scale,'r*','LineWidth',6);
plot3(djup(1,:)/scale,djup(2,:)/scale,djup(3,:)/scale,'b*','LineWidth',LW)
grid on
grid minor
xlabel('JR');
ylabel('JR');
zlabel('JR');
legend({'V1','V2','Jupiter'});
title('\textbf{V1 and V2 maximum velocity position. Obs: Jupiter barycenter}');


% Save png
print(gcf,'maximum_velocity_pos_voyager12.png','-dpng','-r1000');


endSPICE