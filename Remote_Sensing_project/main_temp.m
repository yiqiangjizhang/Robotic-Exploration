function [] = main_temp(b10)
    % Compute Rrs for L8 collection2 level2
    Temp = C2L2scaledDN2T(b10) - 273.15; % deg
    % Show image
    figure;
    imagesc(Temp); % To make sure that the range is properly displayed
    % Pad a back range to deal with NaNs
    colormap([0 0 0; jet(256)]);
    caxis([20, 30]);
    colorbar;

end
