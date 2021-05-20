function = Temperature(b5, b10, 15, b20, i)
    % Set interpreter to latex
    set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
    set(groot, 'defaulttextinterpreter', 'latex');
    set(groot, 'defaultLegendInterpreter', 'latex');

    % Open bands
    %file_b10 = 'LC08_L2SP_091075_20200701_20200913_02_T1_ST_B10.tif'; b10 = imread(file_b10);
    % Compute Rrs for L8 collection2 level2
    Temp = C2L2scaledDN2T(b(i)) - 273.15; % deg
    % Show image
    figure;
    imagesc(Temp); % To make sure that the range is properly displayed
    % Pad a back range to deal with NaNs
    colormap([0 0 0; jet(256)]);
    caxis([20, 30]);
    colorbar;

end
