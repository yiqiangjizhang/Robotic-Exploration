function [] = main_clorophyll_2(b1, b2, b3, QA, file_QA, UL, LR)

    rho443 = C2L2scaledDN2Rrs(b1);
    rho483 = C2L2scaledDN2Rrs(b2);
    rho561 = C2L2scaledDN2Rrs(b3);
    mask = QA2Mask(QA, 'water');
    % Mask all the parts that are not water
    rho443(~mask) = nan;
    rho483(~mask) = nan;
    rho561(~mask) = nan;
    % Compute chlorophyll
    chl = chl_oc3(rho443, rho483, rho561);
    % Same code as the turbidity example for plotting

    [X, Y] = computeXY(UL(1), UL(2), LR(1), LR(2));

    % Project X,Y to lat,lon
    info = georasterinfo(file_QA);
    [lat, lon] = projinv(info.RasterReference.ProjectedCRS, X, Y);
    % Show in a map
    geoimg = geoshow(lat, lon, chl, 'DisplayType', 'texturemap');
    % Set NaN data transparent
    set(geoimg, 'AlphaDataMapping', 'none', 'FaceAlpha', 'texturemap');
    alpha(geoimg, double(~isnan(chl)));
    % Set limits and color
    % axis([19.0,19.6,42.0,42.4]);
    colormap(flipud(winter));
    caxis([0.1 0.7])
    colorbar;

end
