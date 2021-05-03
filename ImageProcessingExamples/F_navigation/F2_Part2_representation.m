% Teresa Peña Mercadé
% April 2021

% This code allows to map a planet or moon based on a range of latitude and
% longitude determined by the user. It is first necessary to obtain the
% data of the image and the body from the code Limb_lon_lat.

clear
close all
addpath('../')

load('coor_lon_lat.mat'); 

%% INPUTS 

lon_range=[180 270]; % Rhea 180 270 // -30 30  1511700504
lat_range=[-30 30]; % Mimas 90 140 // 0 60  1501645889

% Separation between values in the axes
axes_lon=30;
axes_lat=10;

% Increments in the lon and lat range
d=0.1;

%% DATA VECTORS

lon_vector=lon_range(1):d:lon_range(2);
lat_vector=lat_range(1):d:lat_range(2);

%% INTERPOLATION 

% From the values obtanied in Limb_lot_lat, the data needed to perform
% interpolations is obtained through the function scatteredInterpolant

interp_val=scatteredInterpolant(S.lonmat(:),S.latmat(:),double(S.img(:)));

[lon_matrix,lat_matrix]=meshgrid(lon_vector,lat_vector);

img2_data=interp_val(lon_matrix,lat_matrix);

%% REPRESENTATION

% Normalization of the values of the image

img2_data_norm=img2_data/max(img2_data,[],'all');
img2_data_sharpen=imsharpen(img2_data_norm);


% Representation of part of the image determined by lon and lat

%imshow(img2_data_norm, 'XData', lon_vector, 'YData', lat_vector.');

imshow(img2_data_sharpen, 'XData', lon_vector, 'YData', lat_vector.');
set(gca,'YDIR','normal') % Reverse the y axis
axis on
grid on
set(gca,'TickLabelInterpreter','latex')
set(gca,'XColor',[0,0,0])
set(gca,'YColor',[0,0,0])
% set(gca,'FontSize','20')
xticks([lon_range(1):axes_lon:lon_range(2)]) 
yticks([lat_range(1):axes_lat:lat_range(2)])
a=get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',18)
a=get(gca,'YTickLabel');  
set(gca,'YTickLabel',a,'fontsize',18)%'Interpreter','latex',
ax = gca;
xtickformat('{ %.0f}')
ytickformat('%.0f')
ax.XTickLabel = strcat(ax.XTickLabel, '$^{\circ}$E');
ax.YTickLabel = strcat(ax.YTickLabel, '$^{\circ}$N');



