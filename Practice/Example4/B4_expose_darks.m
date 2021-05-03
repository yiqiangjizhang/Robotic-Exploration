% Manel Soria 2021 - Exposure darks without loosing whites in a Lansat
% image (single band) of the Elephant Island 
% UPC - ESEIAAT

clear
close all
img=imread('expose_darks_monochrome.tiff');
imshow(img);
title('Original image');

figure
imhist(img);
title('Original image histogram');

% 1-Convert to double (from 0 to 1)
img2=double(img);
img2=img2/double(max(img(:)));


% 2-What if the image was in color ? 
% Convert from RGB to hsv
% hsv=rgb2hsv(imgd);
% and then, adjust contrast of the 3th channel hsv(:,:,3) 
% finally, convert the image back to RGB
% BUT: be aware that color images are more difficult to handle

% 3-Adjust local contrast
% Contrast-limited adaptive histogram equalization (CLAHE)
% MORE LOCAL CONTRAST: More risk for posterization
% WARNING: NON-UNIFORM TREATMENT, PHOTOMETRIC INFO IS LOST
%img3=adapthisteq(img2, 'NumTiles',[16 16],'ClipLimit',0.025) ;

% This is more conservative
img3=adapthisteq(img2, 'NumTiles',[16 16],'ClipLimit',0.01) ; 

figure
imshow(img3);
title('adapthisteq');

% 4-Increase exposure dark areas
% This is homogeneous (in all image) 
% An easy way that rise darks is to use functions y=x.^p; with p<1

imgd4=img3.^0.25;

figure
imshow(imgd4);
title('adapthisteq + ^1/4 ');

% 5-Adjust overall contrast (discarding some blacks and some whites)

% First we check the histogram to select the values 
figure
imhist(imgd4);
title('adapthisteq + ^1/4 Histogram');

imgd5=imadjust(imgd4,[0.45 0.99],[0 1]); % this is, below 0.45 will be 0
figure
imshow(imgd5);
title('adapthisteq + ^1/4 + imadjust');

% show the final histogram .. be careful with posterization
figure
imhist(imgd5);
title('Final histogram');

% 6- Convert back to 16 bit and save
img6=uint16((2^16-1)*imgd5);
imwrite(img6,'out.tiff','tif');


