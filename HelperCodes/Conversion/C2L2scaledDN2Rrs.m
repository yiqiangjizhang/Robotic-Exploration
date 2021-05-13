function Rrs = C2L2scaledDN2Rrs(DN)
% Returns the float value from a scaled
% digital number codified in an image.

% Change these coefficients accordingly if using
% different METADATA
M = 2.75e-05;
A = -0.2;

Rrs = M*double(DN) + A;
end