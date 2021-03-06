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
plot_pdf = figure(1);
imagesc(~mask); % To make sure that the range is properly displayed
% Pad a back range to deal with NaNs
colormap('parula');

% %  Save pdf
% set(plot_pdf, 'Units', 'Centimeters');
% pos = get(plot_pdf, 'Position');
% set(plot_pdf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
%     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf, 'water_mask.pdf', '-dpdf', '-r100');
% 
% % Save png
% print(gcf,'water_mask.png','-dpng','-r1000');

% Open bands
file_b10 = 'LC08_L2SP_091075_20210314_20210328_02_T1_ST_B10.tif'; b10 = imread(file_b10);
file_QA = 'LC08_L2SP_091075_20210314_20210328_02_T1_QA_PIXEL.tif'; QA = imread(file_QA);
% Compute Rrs for L8 collection2 level2
mask = QA2Mask(QA,'cloud');
% Show image
plot_pdf2 = figure(2);
imagesc(~mask); % To make sure that the range is properly displayed
% Pad a back range to deal with NaNs
colormap('parula');


% %  Save pdf
% set(plot_pdf2, 'Units', 'Centimeters');
% pos = get(plot_pdf2, 'Position');
% set(plot_pdf2, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
%     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf2, 'cloud_mask.pdf', '-dpdf', '-r100');
% 
% % Save png
% print(gcf,'cloud_mask.png','-dpng','-r1000');


