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
METAKR={'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/'}; % Pluto system

% Print RESSLIB version
v=initSPICEv(fullK(METAKR));
fprintf('RESSLIB version %s \n',v);

% Time parameters
utctime='1900-01-08 T00:00:41.184'; % 1979-03-03 T00:00:00
et0 = cspice_str2et(utctime); %converts time (which is a string) to a number
NDAYS = 12; % study time
et1 = et0 + 24*3600*NDAYS; % end of query time
et=linspace(et0,et1,10000);

% Frame
frame = 'ECLIPJ2000';
abcorr = 'NONE';

%% 

% The same but the observer now will be Jupiter barycenter
observer = '9'; % PLUTO BARYCENTER (9)
scale = 1188.3; % Pluto's radius (km)

[dplu,lt] = cspice_spkezr('9',et,frame,abcorr,observer); % jupiter 

plot_pdf = figure(1);
plot3(dplu(1,:)/scale,dplu(2,:)/scale,dplu(3,:)/scale,'r','LineWidth',LW)













endSPICE
