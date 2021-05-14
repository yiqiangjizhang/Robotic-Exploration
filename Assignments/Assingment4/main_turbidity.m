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


% Example turbidity
% Arnau Miro, Elena Terzic
clear; close; clc;
% Open bands
file_b4 = 'LC08_L2SP_091075_20210314_20210328_02_T1_SR_B4.tif'; b4 = imread(file_b4);
file_b5 = 'LC08_L2SP_091075_20210314_20210328_02_T1_SR_B5.tif'; b5 = imread(file_b5);
file_QA = 'LC08_L2SP_091075_20210314_20210328_02_T1_QA_PIXEL.tif'; QA = imread(file_QA);
% Read bands
rho665 = C2L2scaledDN2Rrs(b4);
rho865 = C2L2scaledDN2Rrs(b5);
mask = QA2Mask(QA,'water');
% Mask all the parts that are not water
rho665(~mask) = nan;
rho865(~mask) = nan;
% Compute turbidity - either one of them
turb1 = TurbidityVantrepotte(rho665);
turb2 = TurbidityDogliotti(rho665,rho865);



UL = [244500.000,-2281500.000]; % From metadata
LR = [473100.000,-2513100.000]; % From metadata
[X,Y] = computeXY(UL(1),UL(2),LR(1),LR(2));

plot_pdf = figure(1);

% Project X,Y to lat,lon
info = georasterinfo(file_QA);
[lat,lon] = projinv(info.RasterReference.ProjectedCRS,X,Y);
% Show in a map
geoimg = geoshow(lat,lon,turb1,'DisplayType','texturemap');
% Set NaN data transparent
set(geoimg,'AlphaDataMapping','none','FaceAlpha', 'texturemap');
alpha(geoimg,double(~isnan(turb1)));
% Set limits and color
% axis([19.0,19.6,42.0,42.4]);
colormap(flipud(autumn));
caxis([0 10])
colorbar;


% %  Save pdf
% set(plot_pdf, 'Units', 'Centimeters');
% pos = get(plot_pdf, 'Position');
% set(plot_pdf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
%     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf, 'turb1.pdf', '-dpdf', '-r1000');
% 
% % Save png
% print(gcf,'turb1.png','-dpng','-r1000');



plot_pdf2 = figure(2);

% Project X,Y to lat,lon
info = georasterinfo(file_QA);
[lat,lon] = projinv(info.RasterReference.ProjectedCRS,X,Y);
% Show in a map
geoimg = geoshow(lat,lon,turb2,'DisplayType','texturemap');
% Set NaN data transparent
set(geoimg,'AlphaDataMapping','none','FaceAlpha', 'texturemap');
alpha(geoimg,double(~isnan(turb2)));
% Set limits and color
% axis([19.0,19.6,42.0,42.4]);
colormap(flipud(autumn));
caxis([0 10])
colorbar;


% %  Save pdf
% set(plot_pdf2, 'Units', 'Centimeters');
% pos = get(plot_pdf2, 'Position');
% set(plot_pdf2, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
%     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf2, 'turb2.pdf', '-dpdf', '-r1000');
% 
% % Save png
% print(gcf,'turb2.png','-dpng','-r1000');
