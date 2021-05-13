function out = TurbidityDogliotti(rho665,rho833)
% A. I. Dogliotti, K. G. Ruddick, B. Nechad, D. Doxaran, and E. Knaeps, 
% A single algorithm to retrieve turbidity from remotely-sensed data in all coastal and 
% estuarine waters, Remote Sensing of Environment, vol. 156, pp. 157-168, Jan. 2015
upper_lim = 0.07;
lower_lim = 0.05;
% Compute turbidity for RED and NIR bands
out_red = (228.1*rho665)./(1.-rho665/0.1641);
out_nir = (3078.9*rho833)./(1.-rho833/0.2112);
% Blending algorithm
out = out_red;
% 1st replace the most turbid with NIR band
idx = rho665 >= upper_lim;
out(idx) = out_nir(idx);
% blend in between
w   = (rho665 - lower_lim)/(upper_lim - lower_lim);
idx = rho665<upper_lim & rho665>=lower_lim;
out(idx) = (1.-w(idx)).*out_red(idx) + w(idx).*out_nir(idx);
end