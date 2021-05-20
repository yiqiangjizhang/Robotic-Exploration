function [] = main_NDVI_2(b4, b5)
    % Compute NDVI
    ndvi = NDVI(b4, b5);
    % Show image
    figure;
    % Make sure that the range is properly displayed
    imagesc(ndvi);
    % Pad a back range to deal with NaNs
    colormap([0 0 0; parula(256)]);
    colorbar;

end
