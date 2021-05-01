%% New
%
%-------------------------------------------------------------------------%
% This code
%
%-------------------------------------------------------------------------%

% Date: 30/04/2021
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


% Kernels
METAKR={'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls','naif0012.tls', ...
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/vgr1_jup230.bsp','vgr1_jup230.bsp',... % kernel of voyager 1's flyby of Jupiter 
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/voyager_1.ST+1991_a54418u.merged.bsp','voyager_1.ST+1991_a54418u.merged.bsp',... % +voyager 1 merged
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/vgr2_jup230.bsp','vgr2_jup230.bsp',... % kernel of voyager 2's flyby of Jupiter
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/Voyager_2.m05016u.merged.bsp','Voyager_2.m05016u.merged.bsp',...
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/planets/de430.bsp','de430.bsp' , ...
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/sat337.bsp','sat337.bsp' , ...
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/jup365.bsp','jup365.bsp',...
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/de-403-masses.tpc','de-403-masses.tpc', ... % GM of planets
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/moon_pa_de403_1950-2198.bpc','moon_pa_de403_1950-2198.bpc', ... % GM of moons ?
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/pck00010.tpc','pck00010.tpc', ... % Radii (among others)
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/Gravity.tpc','Gravity.tpc' }; % GM

    % Initiate SPICE
initSPICEv(METAKR);

% Define period of study:
startTimeString='1979-01-01T00:00:00';
endTimeString='1979-06-01T00:00:00';
% convert string to et
startTimeET=cspice_str2et(startTimeString);
endTimeET=cspice_str2et(endTimeString);

% Accuracy for the calculations
step=180; % seconds

MAXWIN  =  1000; % malloc for 1000 numbers 




