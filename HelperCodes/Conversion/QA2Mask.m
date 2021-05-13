function mask = QA2Mask(QA,maskname)
% Decode QA

% Obtain the bitshift from the C2L2 mask table
bitshift = maskTable(maskname);

% Shift to the left
bit = bitsll(1,bitshift);

% Perform bitwise AND
mask = bitand(QA,bit) > 0;

end

function bitshift = maskTable(maskname)
% Landsat 8 C2 L2 mask table

switch maskname
    case 'fill'
        bitshift = 0;
    case 'dilated cloud'
        bitshift = 1;
    case 'cirrus'
        bitshift = 2;
    case 'cloud'
        bitshift = 3;
    case 'cloud shadow'
        bitshift = 4;
    case 'snow'
        bitshift = 5;
    case 'clear'
        bitshift = 6;
    case 'water'
        bitshift = 7;
    otherwise
        error('mask <%s> not recognized!',maskname);
end
end