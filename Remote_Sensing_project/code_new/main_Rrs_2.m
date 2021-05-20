function [] = main_Rrs_2(b1)
    % Compute Rrs for L8 collection2 level2
    Rrs = C2L2scaledDN2Rrs(b1);
    % Show image
    figure;
    imagesc(Rrs); % To make sure that the range is properly displayed
    % Pad a back range to deal with NaNs
    colormap([0 0 0; jet(256)]);
    colorbar;

end
