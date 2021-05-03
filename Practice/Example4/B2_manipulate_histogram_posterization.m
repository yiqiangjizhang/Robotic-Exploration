% Manel Soria - Image contrast

clear
close all
img=imread('low_contrast.jpg');

size(img) % we see it is a monochrome image stored as a RGB, to use JPG

img=img(:,:,1); % treat is as a true monochrome
imshow(img);
title('Original image');

figure
myhist(img); % we use our histogram function
title('Original Image histogram');


% how can we improve contrast ?
imgd=double(img); % we will treat the image as a double (from 0 to 1)
m=min(imgd(:)); % min 
M=max(imgd(:)); % max 
imgd=(imgd-m)/(M-m); % force min to be 0, max 1
img2=uint8(255*imgd); % convert it to 8 bit again

figure
imshow(img2);
title('Forced to 0:255');
set(findall(gcf,'-property','FontSize'),'FontSize',18);

figure
myhist(img2);
title('Forced to 0:255 histogram');
set(findall(gcf,'-property','FontSize'),'FontSize',18);



% if we examine the histogram, we see that at both ends there is very 
% little number of pixels, maybe we can force them to be 0 or 1, 
% increasing even more the difference between the intermediate values

imgd=double(img);
m=min(imgd(:));
M=max(imgd(:));
% experiment with different values instead of 0.2 and 0.3
m2=m+0.2*(M-m); % force m2 and below to be black 
M2=M-0.3*(M-m); % force M2 and above to be white
imgd=(imgd-m2)/(M2-m2);
imgd(imgd<0)=0; % force 
imgd(imgd>1)=1; % force
img3=uint8(255*imgd); % this is to convert it back to 8 bits

figure
imshow(img3)
title('Discarded blacks and whites');
set(findall(gcf,'-property','FontSize'),'FontSize',18);

figure
myhist(img3)
title('Discarded blacks and whites histogram');
set(findall(gcf,'-property','FontSize'),'FontSize',18);



