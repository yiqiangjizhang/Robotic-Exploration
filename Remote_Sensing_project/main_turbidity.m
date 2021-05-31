function [] = main_turbidity(b4, b5, QA, file_QA, UL, LR)
    % Read bands
    rho665 = C2L2scaledDN2Rrs(b4);
    rho865 = C2L2scaledDN2Rrs(b5);
    mask = QA2Mask(QA, 'water');
    % Mask all the parts that are not water
    rho665(~mask) = nan;
    rho865(~mask) = nan;
    % Compute turbidity - either one of them
    turb1 = TurbidityVantrepotte(rho665);
    turb2 = TurbidityDogliotti(rho665, rho865);

    [X, Y] = computeXY(UL(1), UL(2), LR(1), LR(2));

    figure;

    % Project X,Y to lat,lon
    info = georasterinfo(file_QA);
    [lat, lon] = projinv(info.RasterReference.ProjectedCRS, X, Y);
    % Show in a map
    geoimg = geoshow(lat, lon, turb1, 'DisplayType', 'texturemap');
    % Set NaN data transparent
    set(geoimg, 'AlphaDataMapping', 'none', 'FaceAlpha', 'texturemap');
    alpha(geoimg, double(~isnan(turb1)));
    % Set limits and color
    % axis([19.0,19.6,42.0,42.4]);
    colormap(flipud(autumn));
    caxis([0 10])
    colorbar;

    figure;

    % Project X,Y to lat,lon
    info = georasterinfo(file_QA);
    [lat, lon] = projinv(info.RasterReference.ProjectedCRS, X, Y);
    % Show in a map
    geoimg = geoshow(lat, lon, turb2, 'DisplayType', 'texturemap');
    % Set NaN data transparent
    set(geoimg, 'AlphaDataMapping', 'none', 'FaceAlpha', 'texturemap');
    alpha(geoimg, double(~isnan(turb2)));
    % Set limits and color
    % axis([19.0,19.6,42.0,42.4]);
    colormap(flipud(autumn));
    caxis([0 10])
    colorbar;

end
