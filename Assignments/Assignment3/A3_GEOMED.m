%-------------------------------------------------------------------------------------------------------%
% Assignment 3: Image Processing
%-------------------------------------------------------------------------------------------------------%

% Date: 15/05/2021
% Author/s: Group 1
%   Rita Fardilha
%   Yi Qiang Ji
%   Èric Montserrat 
%   Iván Sermanoukian

% Subject: Robotic Exploration of the Solar System
% Professor: Manel Soria & Arnau Miro

% Clear workspace, command window and close windows
clear all;
close all;
clc;

% Set interpreter to latex
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

% % Recall that RESSlib should be in Matlab Path 
% % Addpath Yi Qiang
% addpath 'C:\Users\yiqia\Documents\Spice_Doc\RESSlib'
% % Addpath Iván
% addpath('D:\HDD_Data\Iván\Workload\Q8-GRETA\Robotic_Exploration_of_the_Solar_System\RESSlib')
% % Addpath Èric
%  addpath('F:\RESSoptativa\Resslib')
% % Addpath Rita
% addpath('C:\Users\Rita Fardilha\Desktop\RESSlib/');

%Check if the image is availabe on current folder. If not, download it.
if (~isfile('C1648109_GEOMED.IMG'))
    url = 'https://pds-rings.seti.org/holdings/volumes/VGISS_5xxx/VGISS_5118/DATA/C16481XX/C1648109_GEOMED.IMG';
    filename = 'C1648109_GEOMED.IMG';
    outfilename = websave(filename,url);
end

% 0 Read the image from binari format 
img = 5*vicarread5('C1648109_GEOMED.IMG'); %Multiply the image by 5

% 1 improve contrast 
imgd=double(img); %treat the image as a double (from 0 to 1)
m=min(imgd(:));   %min 
M=max(imgd(:));   %max 
imgd=(imgd-m)/(M-m); 

% 2 increase brighten
img1 = imlocalbrighten(imgd,0.1);

% 3 Adjust local contrast 
img3= adapthisteq(img1, 'NumTiles',[16 16],'clipLimit',0.02,'Distribution','rayleigh');

% 4 Increase exposure dark areas
imgd4=img3.^(1.1);

% 5 Adjust overall contrast (discarding some blacks and some whites)
imgd5=imadjust(imgd4,[0.03 0.93],[0 1]); % this is, below 0.45 will be 0

% 6 Sharpening
imgd6 = imsharpen(imgd5,'Radius',0.2,'Amount',0.8);

% Final Image processed
imgd7=uint16((2^16-1)*imgd6);
figure
imshow(imgd7);




