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

% Compute Rrs for L8 collection2 level2
Temp = C2L2scaledDN2T(b10) - 273.15; % deg
% Mask all the parts that are not water
Temp(~mask) = nan;


UL = [244500.000,-2281500.000]; % From metadata
LR = [473100.000,-2513100.000]; % From metadata
[X,Y] = computeXY(UL(1),UL(2),LR(1),LR(2));


figure(1)
imagesc(Temp);

% Project X,Y to lat,lon
info = georasterinfo(file_QA);
[lat,lon] = projinv(info.RasterReference.ProjectedCRS,X,Y);
% Show in a map
geoimg = geoshow(lat,lon,Temp,'DisplayType','texturemap');
% Set NaN data transparent
set(geoimg,'AlphaDataMapping','none','FaceAlpha', 'texturemap');
alpha(geoimg,double(~isnan(Temp)));
% Set limits and color
% axis([19.0,19.6,42.0,42.4]);
colormap('jet'); caxis([20,30]); colorbar;


