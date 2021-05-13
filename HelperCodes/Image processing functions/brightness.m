function [im_out] = brightness(im_in,factor)
% Increase/decrease image brightness.
%
% Inputs:
%   > factor: -1 to 1

im_out = im_in*(1+factor);

im_out(im_out>1) = 1;
im_out(im_out<0) = 0;
end