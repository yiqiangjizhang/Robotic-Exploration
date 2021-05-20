function [] = main_water_mask_2(b10, QA)

    % Compute Rrs for L8 collection2 level2
    mask = QA2Mask(QA, 'water');
    % Show image
    figure;
    imagesc(~mask); % To make sure that the range is properly displayed
    % Pad a back range to deal with NaNs
    colormap('parula');

    % Compute Rrs for L8 collection2 level2
    mask = QA2Mask(QA, 'cloud');
    % Show image
    figure;
    imagesc(~mask); % To make sure that the range is properly displayed
    % Pad a back range to deal with NaNs
    colormap('parula');

end
