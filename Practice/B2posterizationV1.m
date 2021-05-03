% Manel Soria - Image contrast
%% GROUP 1 MODIFICATION
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close all
img=imread('lowc.jpeg');

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
%% Manel approach
% m2=m+0.2*(M-m); % force m2 and below to be black 
% M2=M-0.9*(M-m); % force M2 and above to be white
% imgd=(imgd-m2)/(M2-m2);
% imgd (imgd<0)=0;% force 
% imgd (imgd>1)=1;% force 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% GROUP 1 APPROACH. Two Different contrasts, upper and lower part of a image.
for i=1:683
   for j=1:1024
%% UPPER PART
    if i<341 %define where to end upper part
        % experiment with different values  %%  UPPER  %%
      m2=m+0.6*(M-m); % force m2 and below to be black 
      M2=M-0.4*(M-m); % force M2 and above to be white
      imgd(i,j)=(imgd(i,j)-m2)/(M2-m2);
      if imgd(i,j)<0% force 
          imgd(i,j)=0;
      elseif imgd(i,j)>1   % force 
          imgd(i,j)=1;
      end
    else
%% LOWER PART
      % experiment with different values   %%  LOWER  %%
      m2=m+0.1*(M-m); % force m2 and below to be black 
      M2=M-0.1*(M-m); % force M2 and above to be white
      imgd(i,j)=(imgd(i,j)-m2)/(M2-m2);
      if imgd(i,j)<0% force 
          imgd(i,j)=0;
      elseif imgd(i,j)>1   % force 
          imgd(i,j)=1;
      end   
    end    
   end
end
img3=uint8(255*imgd); % this is to convert it back to 8 bits

figure
imshow(img3)
title('Discarded blacks and whites');
set(findall(gcf,'-property','FontSize'),'FontSize',18);

figure
myhist(img3)
title('Discarded blacks and whites histogram');
set(findall(gcf,'-property','FontSize'),'FontSize',18);



