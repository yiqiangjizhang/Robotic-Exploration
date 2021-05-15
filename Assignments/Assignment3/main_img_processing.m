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
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaulttextinterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

% % Recall that RESSlib should be in Matlab Path
% % Addpath Yi Qiang
% addpath 'C:\Users\yiqia\Documents\Spice_Doc\RESSlib'
% % Addpath Iván
% addpath('D:\HDD_Data\Iván\Workload\Q8-GRETA\Robotic_Exploration_of_the_Solar_System\RESSlib')
% % Addpath Èric
% addpath('F:\RESSoptativa\Resslib')
% % Addpath Rita
% addpath('C:\Users\Rita Fardilha\Desktop\RESSlib/');

if (~isfile('C1648109_RAW.IMG'))
    url = 'https://pds-rings.seti.org/holdings/volumes/VGISS_5xxx/VGISS_5118/DATA/C16481XX/C1648109_RAW.IMG';
    filename = 'C1648109_RAW.IMG';
    outfilename = websave(filename, url);
end

img = vicarread5('C1648109_RAW.IMG');
imshow(img);

class(img) % data type
size(img) % size (TY,TX, number of channels)
% Matlab can manipulate images based on different data types
% The most usual are:
% uint8: 8 bits (0 to 255)
% uint16: 16 bits (0 to 65535)
% single, double: floating point images (0 to 1)


img = vicarread5('C1648109_RAW.IMG');
figure(1);
imshow(img);
title('Original')


img1 = imlocalbrighten(img);
figure(2);
imshow(img1);
title('LocalBrighten')



%% GROUP 1 APPROACH. Two Different contrasts, upper and lower part of a image.
imgd2=double(img1);
m=min(imgd2(:));
M=max(imgd2(:));
for j=1:800
    for i=1:800
         %% UPPER PART
        if i<=380  %define where to end upper part
         % experiment with different values  %%  UPPER  %%
         m2=m+0.45*(M-m); % force m2 and below to be black 
         M2=M-0.53*(M-m); % force M2 and above to be white
         imgd2(i,j)=(imgd2(i,j)-m2)/(M2-m2);
%          if imgd2(i,j)<0% force 
%           imgd2(i,j)=0;
%          elseif imgd2(i,j)>1   % force 
%           imgd2(i,j)=1;
%          end
        elseif i>485 && i<=800       
         m2=m+0.44*(M-m); % force m2 and below to be black 
         M2=M-0.39*(M-m); % force M2 and above to be white
         imgd2(i,j)=(imgd2(i,j)-m2)/(M2-m2);
%         if imgd2(i,j)<0% force 
%          imgd2(i,j)=0;
%         elseif imgd2(i,j)>1   % force 
%         imgd2(i,j)=1;
%        end
        else
          %% Middle PART
          % experiment with different values   %%  LOWER  %%
          m2=m+0.3*(M-m); % force m2 and below to be black 
          M2=M-0.17*(M-m); % force M2 and above to be white
          imgd2(i,j)=(imgd2(i,j)-m2)/(M2-m2);
%           if imgd2(i,j)<0% force 
%           imgd2(i,j)=0;
%           elseif imgd2(i,j)>1   % force 
%           imgd2(i,j)=1;
%           end   
        end
    end
end

img2=uint8(255*imgd2); % this is to convert it back to 8 bits
figure(3);
imshow(img2)
title('Discarded blacks and whites From LocalBrighten - imreducehaze');


%% GROUP 1 APPROACH. Two Different contrasts, upper and lower part of a image.
imgd3=double(img1);
m=min(imgd3(:));
M=max(imgd3(:));

for j=1:800
    for i=1:800
         %% UPPER PART
        
          %% Middle PART
          % experiment with different values   %%  LOWER  %%
          m2=m+0.3*(M-m); % force m2 and below to be black 
          M2=M-0.17*(M-m); % force M2 and above to be white
          imgd3(i,j)=(imgd3(i,j)-m2)/(M2-m2);
%           if imgd2(i,j)<0% force 
%           imgd2(i,j)=0;
%           elseif imgd2(i,j)>1   % force 
%           imgd2(i,j)=1;
%           end  
    end
end

img3=uint8(255*imgd3); % this is to convert it back to 8 bits
figure(4);
imshow(img3)



