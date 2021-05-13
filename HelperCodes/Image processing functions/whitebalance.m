function [im_out] = whitebalance(im_in,method,varargin)
% White balance the image using different methods.
% Different methods have additional inputs.
% Inputs:
%   > method: whitebalance method. They are:
%       - grayworld
%       - image_patch(from_row,row_width,from_column,column_width)

im_out = im_in;

% Grayworld whitebalance method
if strcmp(method,'grayworld') || strcmp(method,'gw')
    im_out =im_in.*mean(im_in,'all')./mean(im_in,[1,2]);
end

% Image patch whitebalance
if strcmp(method,'image_patch') || strcmp(method,'patch')
    from_row     = varargin{1}(1);
    row_width    = varargin{2}(1);
    from_column  = varargin{1}(2);
	column_width = varargin{2}(2);
	
    patch  = im_in(from_row:from_row+row_width,from_column:from_column+column_width,:);
	im_out = im_in.*mean(patch,'all')./max(patch,[],[1,2]);
end

end