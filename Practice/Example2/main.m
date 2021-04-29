%% Pluto plot
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

%% 

% The same but the observer now will be Jupiter barycenter
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
grid on
grid minor













endSPICE
