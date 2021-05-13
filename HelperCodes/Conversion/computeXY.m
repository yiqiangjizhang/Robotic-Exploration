function [X,Y] = computeXY(X_UL,Y_UL,X_LR,Y_LR)
% Compute the raw X,Y arrays from collection metadata.

% Standard resolution for L8
dx = 30;
dy = 30;

% Compute width and height arrays
width  = round((X_LR - X_UL)/dx) + 1;
height = round((Y_UL - Y_LR)/dy) + 1;

% Compute px and py
px = 0:dx:dx*width;
py = 0:dy:dy*height;
[PX, PY] = meshgrid(px,py);

% Obtain the arrays
X = X_UL + PX;
Y = Y_UL - PY;
end