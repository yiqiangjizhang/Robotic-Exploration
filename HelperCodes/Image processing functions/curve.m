function [im_out] = curve(im_in,channels,points,values)
%Perform curve adjustments on the image.
%
%Inputs:
%    > channels: which channels to adjust (default: 'rgb')
%    > points:   start and end point of the curve (default: [0,1])
%    > values:   values on the curve (default: [0,1])

im_out = im_in;

% Channels
if any('r' == channels)
    im_out(:,:,1) = channel_adjust(im_in(:,:,1),points,values);
end
if any('g' == channels)
    im_out(:,:,2) = channel_adjust(im_in(:,:,2),points,values);
end
if any('b' == channels)
    im_out(:,:,3) = channel_adjust(im_in(:,:,3),points,values);
end

end

function [c] = channel_adjust(channel, points, values)
% preserve the original size, so we can reconstruct at the end
orig_size = size(channel);

% flatten the image into a single array
flat_channel = channel(:);

adjusted = interp1(points,values,flat_channel);

% put back into the original image shape
c = reshape(adjusted,orig_size);
end