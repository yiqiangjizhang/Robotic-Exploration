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

% Open and show Landsat band

%file = 'LC08_L2SP_094072_20210216_20210301_02_T2_SR_B3.tif' % Here goes your filename

% Open bands
file_b2 = 'LC08_L2SP_091075_20210314_20210328_02_T1_SR_B2.tif'; b2 = imread(file_b2); % Blue band
file_b3 = 'LC08_L2SP_091075_20210314_20210328_02_T1_SR_B3.tif'; b3 = imread(file_b3); % Greenband
file_b4 = 'LC08_L2SP_091075_20210314_20210328_02_T1_SR_B4.tif'; b4 = imread(file_b4); % Red band

% Create RGB image
rgb = cat(3, b4, b3, b2);
% Show image
plot_pdf = figure(1);
imshow(rgb);


% %  Save pdf
% set(plot_pdf, 'Units', 'Centimeters');
% pos = get(plot_pdf, 'Position');
% set(plot_pdf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
%     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf, 'original_photo.pdf', '-dpdf', '-r100');
% 
% % Save png
% print(gcf,'original_photo.png','-dpng','-r1000');



% Added on top of the previous example
% Convert to double
img = double(rgb) ./ double(max(rgb, [], [1, 2]));
% Fix whitebalance
img = whitebalance(img, 'patch', [4108, 1582], [2, 2]);
%img = whitebalance(img, 'patch', [2055, 6063], [100, 100]);
% Curve editing
img = curve(img, 'rgb', ...
    [0.01, 0.25, 0.45, 0.55, 0.6, 0.7, 1.], ...
    [0., 0.2, 0.4, 0.8, 0.9, 0.95, 1.]);
% Brightness and contrast
img = brightness(img, 1.);
% Reconvert to uint16
rgb = uint16(img * (2^16 - 1));

plot_pdf2 = figure(2);
imshow(rgb);


% %  Save pdf
% set(plot_pdf2, 'Units', 'Centimeters');
% pos = get(plot_pdf2, 'Position');
% set(plot_pdf2, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Centimeters', ...
%     'PaperSize',[pos(3), pos(4)]);
% print(plot_pdf2, 'natural_color.pdf', '-dpdf', '-r100');
% 
% % Save png
% print(gcf,'natural_color.png','-dpng','-r1000');
