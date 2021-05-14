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
file_b1 = 'LC08_L2SP_091075_20210314_20210328_02_T1_SR_B1.tif'; b1 = imread(file_b1);
% Compute Rrs for L8 collection2 level2
Rrs = C2L2scaledDN2Rrs(b1);
% Show image
plot_pdf2 = figure(2);
imagesc(Rrs); % To make sure that the range is properly displayed
% Pad a back range to deal with NaNs
colormap([0 0 0; turbo(256)]);
colorbar;


% %  Save pdf
% set(plot_pdf2, 'Units', 'Centimeters');
% pos = get(plot_pdf2, 'Position');
% set(plot_pdf2, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
%     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf2, 'Rrs_index.pdf', '-dpdf', '-r100');
% 
% % Save png
% print(gcf,'Rrs_index.png','-dpng','-r1000');

