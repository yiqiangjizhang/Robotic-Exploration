% EXAMPLE 2 Testing jpg image quality with Matlab
% Manel Soria ESEIAAT - 2021

clear
close all 

img=uint8(zeros(200,200,3)); % black image, uint8 (0 to 255)
% img=uint8(ones(200,200,3)*255); % white image, uint8 (0 to 255)

% draw red vertical band
img(1:200,30:40,1)=255;
img(1:200,30:40,2:3)=0;

img(1:200,60:70,2)=255; % green
img(1:200,60:70,1)=0;
img(1:200,60:70,3)=0;

img(1:200,90:100,3)=255; % blue
img(1:200,90:100,1:2)=0; % blue


imwrite(img,'test.png');

set(gca,'DefaultTextFontSize',24)
imshow(imresize(img,2));
title('Original');
set(findall(gcf,'-property','FontSize'),'FontSize',18)


q=80;
imwrite(img,'test.jpg','Quality',q);
img2=imread('test.jpg');
set(findall(gcf,'-property','FontSize'),'FontSize',18)

figure
imshow(imresize(img,2));
title(sprintf('JPG quality %d',q));
set(findall(gcf,'-property','FontSize'),'FontSize',18)

figure

plot(img(100,:,1));
hold on
plot(img2(100,:,1));
legend({'Original','Compressed'})
title(sprintf('Horizontal cut red channel, quality=%d',q));

set(findall(gcf,'-property','FontSize'),'FontSize',18)

