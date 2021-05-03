% Manel Soria - Process the image so that the snake nebula 
% (small in the image) becomes more visible

clear
close all
img=imread('darkhorse.tif');
%img=imresize(img,0.25);


figure;
q=gca; 
imshow(img);
title(q,'Original'); % sometimes just 'title' fails ..


% 1-Select one channel (all are equal) and convert to double (from 0 to 1)
img2=double(img(:,:,1));
img2=img2/double(max(img(:)));


% 2-Reduce haze
img3=imreducehaze(img2,0.3,'method','approxdcp'); 
% 0.2: conservative value, increase for more haze reduction


figure
q=gca; 
imshow(img3);
title(q,'imreducehaze');
drawnow;

%figure
%imhist(img3);



% 3-Adjust local contrast
% MORE LOCAL CONTRAST: More risk for posterization
img4=adapthisteq(img3, 'NumTiles',[16 16],'ClipLimit',0.01) ;

figure
q=gca; 
imshow(img4);
title(q,'imreducehaze+adapthisteq');
drawnow;

% 4-Adjust image limits (looseless)
img5=imadjust(img4,stretchlim(img4),[0 1]);


figure
imshow(img5);
title('imreducehaze+adapthisteq+imadjust');
drawnow;


% 5- Convert back to 16 bit and save

img5=uint16((2^16-1)*img5);
imwrite(img5,'out.tiff','tif');






