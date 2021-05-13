function out = chl_oc3(rho443,rho483,rho561)
% Chlorophyll band ratio OC3 algorithm.
% J. E. O’Reilly et al., ‘Ocean Color Chlorophyll a Algorithms for SeaWiFS, 
% OC2 and OC4: Version 4’, p. 15, 2000.
coefs = [0.2412,-2.0546,1.1776,-0.5538,-0.4570];
% Blue and green bands
blue  = max(cat(3,rho443,rho483),[],3);
green = rho561;
% Equation
ratio = log10(blue./green);
out   = real(10.^polyval(flip(coefs),ratio));
end