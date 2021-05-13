function T = C2L2scaledDN2T(DN)
% Returns the float value from a scaled
% digital number codified in an image.

% Change these coefficients accordingly if using
% different METADATA
M = 0.00341802;
A = 149.0;

T = M*double(DN) + A; % In K
end