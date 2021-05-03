clear
close all

% Binarize the image and erase the satellite not above Jupiter
img1=imread('R1.tiff');
img1=img1*8; % increase exposure
imshow(img1);
title('Original image');

figure
imhist(img1);
title('Original image histogram');

BW=img1>10000; % select above threshold

figure
imshow(BW);
title('Binary image');

CC = bwconncomp(BW); % Find connected components in binary image
S = regionprops(CC, 'Area'); % Find area of each component
L = labelmatrix(CC); % Create label matrix from BWCONNCOMP structure
BW2 = ismember(L, find([S.Area] >= 2000)); % Select components of size>2000
img=img1; % prepare output image to be of the same class as original image

img(BW2==0)=0; % set to zero BW2 part (satellite hopefully)

figure
imshow(img);
title('Final image');