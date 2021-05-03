clear
close all

% load the three images
ir=imread('R1.tiff');
ig=imread('G1.tiff');
ib=imread('B1.tiff');

efactor=8; % increase exposure
ir=ir*efactor;
ig=ig*efactor;
ib=ib*efactor;

figure % display original images
imshow(ir);
title('R');

figure
imshow(ig);
title('G');

figure
imshow(ib);
title('B');

% call onlyplanet to erase the satellite

figure
irp=onlyplanet(ir,5000,1000); 
imshow(irp);
title('Rp');

figure
igp=onlyplanet(ig,5000,1000);
imshow(igp);
title('Gp');

figure
ibp=onlyplanet(ib,5000,1000);
imshow(ibp);
title('Bp');

% Configurations intensity-based registration 
[optimizer, metric] = imregconfig('Multimodal');

% Define the operations that will be allowed to match both images
registermode='translation';
%registermode='rigid';  % allows rotation also
%registermode='affine'; % allows some deformations also

% Some parameters
optimizer.Epsilon = 1.0e-9;
optimizer.MaximumIterations = 400;

tform_bg=imregtform(ibp, igp, registermode, optimizer, metric); % compute alignment blue to green without satellite
ib_r=imwarp(ib,tform_bg,'OutputView',imref2d(size(ig))); % transform blue image (with satellite) so that it matches the green image

tform_rg=imregtform(irp, igp, registermode, optimizer, metric); % compute alignment red to green without satellite
io_r=imwarp(ir,tform_rg,'OutputView',imref2d(size(ig))); % transform red image (with satellite) so that it matches the green image

% assemble the channels: [ moved red, original green, moved blue] to form a color image
RGB = cat(3, io_r, ig, ib_r); 

figure
imshow(RGB)
title('RGB')
