function img=onlyplanet(img1,wsat,sizesat)
% Erases the satellites
    BW=img1>wsat;
    CC = bwconncomp(BW);
    S = regionprops(CC, 'Area');
    L = labelmatrix(CC);
    BW2 = ismember(L, find([S.Area] >= sizesat));
    img=img1; % same class
    img(BW2==0)=0;
    %imshow(img);
end