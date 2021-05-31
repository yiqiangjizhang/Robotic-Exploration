function [] = main_IR(b2, b3, b4)

    % Create RGB image
    rgb = cat(3, b4, b3, b2);
    % Show image
    figure;
    imshow(rgb);

    % Added on top of the previous example
    % Convert to double
    img = double(rgb) ./ double(max(rgb, [], [1, 2]));
    % Fix whitebalance
    img = whitebalance(img, 'patch', [4108, 1582], [2, 2]);
    %img = whitebalance(img, 'patch', [2055, 6063], [100, 100]);
    % Curve editing
    img = curve(img, 'rgb', ...
        [0.01, 0.15, 0.25, 0.55, 0.6, 0.7, 1.], ...
        [0., 0.2, 0.4, 0.8, 0.9, 0.95, 1.]);
    % Brightness and contrast
    img = brightness(img, 1.);

    % Reconvert to uint16
    rgb = uint16(img * (2^16 - 1));

    plot_pdf2 = figure(2);
    imshow(rgb);

end
