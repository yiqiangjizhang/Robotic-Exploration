function out = NDVI(b4,b5)
%Comptue NDVI from raw band arrays.
out = (double(b5)-double(b4))./(double(b5)+double(b4));
end