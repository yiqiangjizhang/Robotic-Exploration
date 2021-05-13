%-------------------------------------------------------------------------------------------------------%
% Assignment 4: Landsat Coral reef
%-------------------------------------------------------------------------------------------------------%

% Date: 13/05/2021
% Author/s: Group 1
%   Rita Fardilha
%   Yi Qiang Ji
%   Èric Montserrat
%   Iván Sermanoukian

% Subject: Robotic Exploration of the Solar Systemw
% Professor: Manel Soria & Arnau Miro & Elena Terzic

% Clear workspace, command window and close windows
clear;
close all;
clc;

% Set interpreter to latex
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaulttextinterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

% Open bands
file_b4 = 'LC08_L2SP_091075_20210314_20210328_02_T1_SR_B4.tif'; b4 = imread(file_b4);
file_b5 = 'LC08_L2SP_091075_20210314_20210328_02_T1_SR_B5.tif'; b5 = imread(file_b5);
% Compute NDVI
ndvi = NDVI(b4,b5);
% Show image
% Make sure that the range is properly displayed
imagesc(ndvi);
% Pad a back range to deal with NaNs
colormap([0 0 0; parula(256)]);
colorbar;



