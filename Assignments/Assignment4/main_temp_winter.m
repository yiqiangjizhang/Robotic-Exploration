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
file_b10 = 'LC08_L2SP_091075_20200701_20200913_02_T1_ST_B10.tif'; b10 = imread(file_b10);
% Compute Rrs for L8 collection2 level2
Temp = C2L2scaledDN2T(b10) - 273.15; % deg
% Show image
plot_pdf2 = figure(2);
imagesc(Temp); % To make sure that the range is properly displayed
% Pad a back range to deal with NaNs
colormap([0 0 0; jet(256)]);
caxis([20,30]);
colorbar;


% %  Save pdf
% set(plot_pdf2, 'Units', 'Centimeters');
% pos = get(plot_pdf2, 'Position');
% set(plot_pdf2, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
%     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf2, 'temp_winter_index.pdf', '-dpdf', '-r100');
% 
% % Save png
% print(gcf,'temp_winter_index.png','-dpng','-r1000');

