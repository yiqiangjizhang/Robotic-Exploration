% EXAMPLE 1 Basic image manipulation with Matlab
% Manel Soria ESEIAAT - 2021

clear
close

img=imread('PIA24571.tif'); % reads image (most formats)
imshow(img); % displays image
figure
imshow(img(:,:,1)); % displays image, only red channel
title('Only red');
set(findall(gcf,'-property','FontSize'),'FontSize',18)

class(img) % data type 

% Matlab can manipulate images based on different data types
% The most usual are:
% uint8: 8 bits (0 to 255)
% uint16: 16 bits (0 to 65535)
% single, double: floating point images (0 to 1)

size(img) % size (TY,TX, number of channels)

small=imresize(img,0.5); % half size image

figure
imshow(small); 
title('Original');
set(findall(gcf,'-property','FontSize'),'FontSize',18)

r=small(:,:,1); % extract red channel
g=small(:,:,2); % green
b=small(:,:,3); % blue

r=r*2; % duplicate signal of one channel / image

img2=cat(3,r,g,b); % concatenate three channels to form 

figure
imshow(img2);
title('Double red');
set(findall(gcf,'-property','FontSize'),'FontSize',18)


r=small(:,:,1); % extract red channel
g=small(:,:,2); % green
b=small(:,:,3); % blue
b =b*2;
img3=cat(3,r,g,b); % concatenate three channels to form 
figure
imshow(img3);
title('Double blue');
set(findall(gcf,'-property','FontSize'),'FontSize',18)
