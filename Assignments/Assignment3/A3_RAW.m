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
%addpath('D:\HDD_Data\Iván\Workload\Q8-GRETA\Robotic_Exploration_of_the_Solar_System\RESSlib')
% % Addpath Èric
%  addpath('F:\RESSoptativa\Resslib')
% % Addpath Rita
% addpath('C:\Users\Rita Fardilha\Desktop\RESSlib/');

%Check if the image is availabe on current folder. If not, download it.
if (~isfile('C1648109_RAW.IMG'))
    url = 'https://pds-rings.seti.org/holdings/volumes/VGISS_5xxx/VGISS_5118/DATA/C16481XX/C1648109_RAW.IMG';
    filename = 'C1648109_RAW.IMG';
    outfilename = websave(filename,url);
end

% 0 Read the image from binari format 
 img =3*vicarread5('C1648109_RAW.IMG'); %Multiply the image by 3

% 1 improve contrast 
imgd=double(img); %treat the image as a double (from 0 to 1)
m=min(imgd(:));   %min 
M=max(imgd(:));   %max 
imgd=(imgd-m)/(M-m); 
 
% 2 how can increase brighten
img1 = imlocalbrighten(imgd,1);

% 3 Adjust local contrast
img2= adapthisteq(img1, 'NumTiles',[2 2],'clipLimit',0.00006,'Distribution','rayleigh');

% 4 Adjust overall contrast (discarding some blacks and some whites)
imgd3=imadjust(img2,[0.03 0.85],[0 1]); % this is, below 0.45 will be 0

% 5 Increase exposure dark areas
imgd4=imgd3.^(6.5);

% Final Image processed
imgd5=uint16((2^16-1)*imgd4);
figure
imshow(imgd5);

% Draw circle on potential stars
hold on

C = [633 709] ;
C1 = [432 736] ;
% C2 = [598 274] ;
R = 60 ;   

th = linspace(0,2*pi) ;
xc = C(1)+R*cos(th) ;
yc = C(2)+R*sin(th) ;
plot(xc,yc,'r') ;

th = linspace(0,2*pi) ;
xc1 = C1(1)+R*cos(th) ;
yc1 = C1(2)+R*sin(th) ;
plot(xc1,yc1,'r') ;

% th = linspace(0,2*pi) ;
% xc2 = C2(1)+R*cos(th) ;
% yc2 = C2(2)+R*sin(th) ;
% plot(xc2,yc2,'r') ;