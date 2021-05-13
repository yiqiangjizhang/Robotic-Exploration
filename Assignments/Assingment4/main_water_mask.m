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


% Open bands
file_b10 = 'LC08_L2SP_091075_20210314_20210328_02_T1_ST_B10.tif'; b10 = imread(file_b10);
file_QA = 'LC08_L2SP_091075_20210314_20210328_02_T1_QA_PIXEL.tif'; QA = imread(file_QA);
% Compute Rrs for L8 collection2 level2
mask = QA2Mask(QA,'water');
% Show image
figure(1)
imagesc(~mask); % To make sure that the range is properly displayed
% Pad a back range to deal with NaNs
colormap('parula');


% Compute Rrs for L8 collection2 level2
mask = QA2Mask(QA,'water');
% Compute Rrs for L8 collection2 level2
Temp = C2L2scaledDN2T(b10) - 273.15; % deg
% Mask all the parts that are not water
Temp(~mask) = nan;
% Show image
figure(2)
imagesc(Temp);
% Pad a back range to deal with NaNs
colormap([0 0 0; jet(256)]); caxis([0,30]); colorbar;

% Compute Rrs for L8 collection2 level2
mask = QA2Mask(QA,'water');
% Compute Rrs for L8 collection2 level2
Temp = C2L2scaledDN2T(b10) - 273.15; % deg
% Mask all the parts that are not water
Temp(mask) = nan;
% Show image
figure(6)
imagesc(Temp);
% Pad a back range to deal with NaNs
colormap([0 0 0; jet(256)]); caxis([0,30]); colorbar;






