function [im_out] = contrast(im_in,factor)
% Increase/decrease image contrast.
%
% Inputs:
%   > factor: -1 to 1

im_out = (1 + factor)*(im_in - 0.5) + 0.5;

im_out(im_out>1) = 1;
im_out(im_out<0) = 0;
end