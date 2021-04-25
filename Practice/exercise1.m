%% Voyager 1 and 2, with Sun as Observer
%
%-------------------------------------------------------------------------%
% Example 2: This code plots the position of Voyagers 1 and 2 with Sun as
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


%% Code

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

% The same but the observer now will be Jupiter barycenter
observer = '599'; % Jupiter barycenter (not Jupiter system barycenter)
scale = 149597871; % Jupiter polar radius (km) 

% Get the position and velocity
[djup,lt] = cspice_spkezr('599',et,frame,abcorr,observer); % Jupiter 
[dio, lt] = cspice_spkezr('501',et,frame,abcorr,observer); % Io
[deu, lt] = cspice_spkezr('502',et,frame,abcorr,observer); % Europa
[dv1, lt] = cspice_spkezr('VG1',et,frame,abcorr,observer); % Voyager1
[dv2, lt] = cspice_spkezr('VG2',et2,frame,abcorr,observer); % Voyager2
[dsun, lt] = cspice_spkezr('10',et2,frame,abcorr,observer); % Sun


%% Minimum distance position computatation

% Initialize vector
Pos1=zeros(1,3);
Pos2=zeros(1,3);
Dist1=zeros(1,10000);
Dist2=zeros(1,10000);

% Initial distance
Dist1(1,1)= sqrt(   (djup(1,1)-dv1(1,1))^2 + (djup(2,1)-dv1(2,1))^2 + (djup(3,1)-dv1(3,1))^2  ); 
Dist2(1,1)= sqrt(   (djup(1,1)-dv2(1,1))^2 + (djup(2,1)-dv2(2,1))^2 + (djup(3,1)-dv2(3,1))^2  );

% Loop through all the time step
for i=2:length(et)
    
   Dist1(1,i)= sqrt(   (djup(1,i)-dv1(1,i))^2 + (djup(2,i)-dv1(2,i))^2 + (djup(3,i)-dv1(3,i))^2  );
   Dist2(1,i)= sqrt(   (djup(1,i)-dv2(1,i))^2 + (djup(2,i)-dv2(2,i))^2 + (djup(3,i)-dv2(3,i))^2  );
   
   % VOYAGER 1
   if (Dist1(1,i) < Dist1(1,i-1))
    Pos1(1,1)=dv1(1,i);
    Pos1(1,2)=dv1(2,i);
    Pos1(1,3)=dv1(3,i);
    a=i;
   else
   end
   
   % VOYAGER 2
   if (Dist2(1,i) < Dist2(1,i-1))
    Pos2(1,1)=dv2(1,i);
    Pos2(1,2)=dv2(2,i);
    Pos2(1,3)=dv2(3,i);
    b=i;
   else
   end
   
   % Minimum distance
   Min1= sqrt(   (djup(1,i)-Pos1(1,1))^2 + (djup(2,i)-Pos1(1,2))^2 + (djup(3,i)-Pos1(1,3))^2  );
   Min2= sqrt(   (djup(1,i)-Pos2(1,1))^2 + (djup(2,i)-Pos2(1,2))^2 + (djup(3,i)-Pos2(1,3))^2  );
end


%% Maximum velocity computation

% Maximum velocity in x,y,z direction
% Initialize vector
voy1_max_v = zeros(3);
voy2_max_v = zeros(3);
voy1_max_v_pos = zeros(3);
voy2_max_v_pos = zeros(3);

% Voyager 1
voy1_max_v(1) = max(dv1(4,:));
voy1_max_v(2) = max(dv1(5,:));
voy1_max_v(3) = max(dv1(6,:));



% Voyager 2
voy2_max_v(1) = max(dv2(4,:));
voy2_max_v(2) = max(dv2(5,:));
voy2_max_v(3) = max(dv2(6,:));

% Position when maximum velocity in x,y,z direction
voy1_max_v_pos(1) = find(dv1(4,:) == voy1_max_v(1));
voy1_max_v_pos(2) = find(dv1(5,:) == voy1_max_v(2));
voy1_max_v_pos(3) = find(dv1(6,:) == voy1_max_v(3));

voy2_max_v_pos(1) = find(dv2(4,:) == voy2_max_v(1));
voy2_max_v_pos(2) = find(dv2(5,:) == voy2_max_v(2));
voy2_max_v_pos(3) = find(dv2(6,:) == voy2_max_v(3));


%% Plots

% Plot 1
figure(1);
plot3(Pos1(1,1)/scale,Pos1(1,2)/scale,Pos1(1,3)/scale,'g*','LineWidth',6)
hold on
plot3(Pos2(1,1)/scale,Pos2(1,2)/scale,Pos2(1,3)/scale,'r*','LineWidth',6)
% plot3(dsun(1,:)/scale,dsun(2,:)/scale,dsun(3,:)/scale,'p','LineWidth',LW)
plot3(djup(1,:)/scale,djup(2,:)/scale,djup(3,:)/scale,'b*','LineWidth',LW)
xlabel('AU');
ylabel('AU');
zlabel('AU');
% xlim([-4 4])
% ylim([-4 6])
% axis('equal');
legend({'PosV1','PosV2','Jupiter','Jupiter'});
title('\textbf{Minimum position of Voyager 1 and 2 flyby across Jupiter. Obs: Jupiter}');
grid on
grid minor
% set(findall(gcf,'-property','FontSize'),'FontSize',18);


% Plot 2
[djup,lt] = cspice_spkezr('599',et,frame,abcorr,'599'); % Jupiter 
[dv1, lt] = cspice_spkezr('VG1',et,frame,abcorr,'599'); % Voyager1
[dv2, lt] = cspice_spkezr('VG2',et2,frame,abcorr,'599'); % Voyager2

figure(2)
plot3(voy1_max_v_pos(1)/scale,voy1_max_v_pos(2)/scale,voy1_max_v_pos(3)/scale,'g*','LineWidth',6);
hold on
plot3(voy2_max_v_pos(1)/scale,voy2_max_v_pos(2)/scale,voy2_max_v_pos(3)/scale,'r*','LineWidth',6);
plot3(djup(1,:)/scale,djup(2,:)/scale,djup(3,:)/scale,'b*','LineWidth',LW)
grid on
grid minor
xlabel('AU');
ylabel('AU');
zlabel('AU');
legend({'V1','V2','Jupiter'});
title('\textbf{V1 and V2 maximum velocity position. Obs: Jupiter}');

endSPICE