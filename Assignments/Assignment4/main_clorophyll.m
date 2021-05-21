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
file_b1 = 'LC08_L2SP_091075_20210314_20210328_02_T1_SR_B1.tif'; b1 = imread(file_b1);
file_b2 = 'LC08_L2SP_091075_20210314_20210328_02_T1_SR_B2.tif'; b2 = imread(file_b2);
file_b3 = 'LC08_L2SP_091075_20210314_20210328_02_T1_SR_B3.tif'; b3 = imread(file_b3);
file_QA = 'LC08_L2SP_091075_20210314_20210328_02_T1_QA_PIXEL.tif'; QA = imread(file_QA);
% Read bands
rho443 = C2L2scaledDN2Rrs(b1);
rho483 = C2L2scaledDN2Rrs(b2);
rho561 = C2L2scaledDN2Rrs(b3);
mask = QA2Mask(QA,'water');
% Mask all the parts that are not water
rho443(~mask) = nan;
rho483(~mask) = nan;
rho561(~mask) = nan;
% Compute chlorophyll
chl = chl_oc3(rho443,rho483,rho561);
% Same code as the turbidity example for plotting

UL = [244500.000,-2281500.000]; % From metadata
LR = [473100.000,-2513100.000]; % From metadata
[X,Y] = computeXY(UL(1),UL(2),LR(1),LR(2));

plot_pdf = figure(1);

% Project X,Y to lat,lon
info = georasterinfo(file_QA);
[lat,lon] = projinv(info.RasterReference.ProjectedCRS,X,Y);
% Show in a map
geoimg = geoshow(lat,lon,chl,'DisplayType','texturemap');
% Set NaN data transparent
set(geoimg,'AlphaDataMapping','none','FaceAlpha', 'texturemap');
alpha(geoimg,double(~isnan(chl)));
% Set limits and color
% axis([19.0,19.6,42.0,42.4]);
colormap(flipud(winter));
caxis([0 5])
colorbar;


% %  Save pdf
% set(plot_pdf, 'Units', 'Centimeters');
% pos = get(plot_pdf, 'Position');
% set(plot_pdf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
%     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf, 'clorophyll.pdf', '-dpdf', '-r1000');
% 
% % Save png
% print(gcf,'clorophyll.png','-dpng','-r1000');

