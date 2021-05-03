% Manel Soria - Image contrast

clear
close all
img=imread('low_contrast.jpg');

size(img) % we see it is a monochrome image stored as a RGB, to use JPG

img=img(:,:,1); % treat is as a true monochrome
imshow(img);
title('Original');
set(findall(gcf,'-property','FontSize'),'FontSize',18);

figure
myhist(img);
title('Original');
set(findall(gcf,'-property','FontSize'),'FontSize',18);

img2=adapthisteq(img); % much better algorithm .. from help:
%  adapthisteq Contrast-limited Adaptive Histogram Equalization (CLAHE).
%     adapthisteq enhances the contrast of images by transforming the
%     values in the intensity image I.  Unlike HISTEQ, it operates on small
%     data regions (tiles), rather than the entire image. Each tile's 
%     contrast is enhanced, so that the histogram of the output region
%     approximately matches the specified histogram. The neighboring tiles 
%     are then combined using bilinear interpolation in order to eliminate
%     artificially induced boundaries.  The contrast, especially
%     in homogeneous areas, can be limited in order to avoid amplifying the
%     noise which might be present in the image.
figure
imshow(img2);
title('adapthisteq');
set(findall(gcf,'-property','FontSize'),'FontSize',18);

figure

myhist(img2);
title('adapthisteq histogram');
set(findall(gcf,'-property','FontSize'),'FontSize',18);

% now we increase overall constrast
img3=imadjust(img2,[0.2 0.8],[0 1]);
% J = imadjust(I,[LOW_IN; HIGH_IN],[LOW_OUT; HIGH_OUT]) maps the values
%     in intensity image I to new values in J such that values between LOW_IN
%     and HIGH_IN map to values between LOW_OUT and HIGH_OUT. Values below
%     LOW_IN and above HIGH_IN are clipped; 
%     (Note that this is what we did in the previous example)
    
figure
imshow(img3);
title('adapthisteq+imadjust');
set(findall(gcf,'-property','FontSize'),'FontSize',18);

figure
myhist(img3);
title('adapthisteq+imadjust histogram');



