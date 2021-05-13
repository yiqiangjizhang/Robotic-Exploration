function out = TurbidityVantrepotte(rho665)
% From Vantrepotte et al. (2011)
% Pg. 49 of https://climate.esa.int/media/documents/CCI-LAKES-0024-ATBD_v1.2.pdf
out = ( 206.*rho665./(1.-(rho665./20460.)) - 0.7921 ) / 1.17; % from gm-3 to NTU
end