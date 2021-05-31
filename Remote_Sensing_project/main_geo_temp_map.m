function [] = main_geo_temp_map(b10, QA, file_QA, UL, LR)

    % Compute Rrs for L8 collection2 level2
    mask = QA2Mask(QA, 'water');

    % Compute Rrs for L8 collection2 level2
    Temp = C2L2scaledDN2T(b10) - 273.15; % deg
    % Mask all the parts that are not water
    Temp(~mask) = nan;

    [X, Y] = computeXY(UL(1), UL(2), LR(1), LR(2));

    figure;
    imagesc(Temp);

    % Project X,Y to lat,lon
    info = georasterinfo(file_QA);
    [lat, lon] = projinv(info.RasterReference.ProjectedCRS, X, Y);
    % Show in a map
    geoimg = geoshow(lat, lon, Temp, 'DisplayType', 'texturemap');
    % Set NaN data transparent
    set(geoimg, 'AlphaDataMapping', 'none', 'FaceAlpha', 'texturemap');
    alpha(geoimg, double(~isnan(Temp)));
    % Set limits and color
    % axis([19.0,19.6,42.0,42.4]);
    colormap('jet'); caxis([20, 32]); colorbar;

end
