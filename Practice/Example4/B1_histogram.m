clear
close all
img=imread('low_contrast.jpeg');

size(img) % we see it is a monochrome image stored as a RGB, to use JPG

img=img(:,:,1); % treat is as a true monochrome
imshow(img);

% find histogram (our own code)
figure

tic % just to measure computing time
n=zeros(256,1);
for c=0:255 % for every possible gray value
    n(c+1)=sum(img(:)==c); % count the number of pixels of that value
end
plot(n)
title('Image histogram "manual" ');
set(findall(gcf,'-property','FontSize'),'FontSize',18);
toc


figure

% find histogram (Matlab)
tic
imhist(img);
title('Image histogram with imhist');
set(findall(gcf,'-property','FontSize'),'FontSize',18);
toc


