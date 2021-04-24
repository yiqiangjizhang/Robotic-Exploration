% FILE vicarread5.m
% ====================
% 
% DESCRIPTION
% ----------
% Reads a VICAR image and returns a matrix with the values of each pixel,
%   as well as the information available in such file
% 
% INPUTS
% ----------
% - imgName: name of the VICAR image to be converted
% 
% OUTPUTS
% ----------
% - imgPixels: cell array containing the values of each pixel  
% - vicarProperty: structure array containing the information available
%   in the VICAR image, i.e. IMAGE_TIME

function [imgPixels,vicarProperty] = vicarread5(imgName)
vicar = getLabels(imgName);
vicarProperty = vicar;
image_fd = fopen(imgName,'r');
fseek(image_fd,vicar.LBLSIZE + vicar.NLB*vicar.RECSIZE,'bof');
num_records = vicar.N2 * vicar.N3;
pixels = [];
% Image format:
% 'BYTE' format means unsigned 8 bits (uint8) format (0 to 255)
% 'HALF' format means signed int16 (int16) format (-32768 to 32767)
% 'REAL' format means single precision floating-point (single) format (0 to 1)
if(strcmp('BYTE',vicar.FORMAT)) n=1; end
if(strcmp('HALF',vicar.FORMAT)) n=2; end
if(strcmp('REAL',vicar.FORMAT)) n=3; end
% Endianness: 'b' if big-endian and 'l' if little-endian
if(strcmp('HIGH',vicar.INTFMT)) endianness=sprintf('b'); end
if(strcmp('LOW',vicar.INTFMT)) endianness=sprintf('l'); end
for i = 1:num_records
    fread(image_fd,vicar.NBB);
    switch n
        case 1 % type 1 : bytes
            pixel_data = fread(image_fd,vicar.N1,'uint8',0,endianness);
        case 2 % type 2: int16 (signed)
            pixel_data = fread(image_fd,vicar.N1,'int16',0,endianness);
            %pixel_data = pixel_data*32768*2/(4096.0); !!!! NOO ooops 
            % HALF is a two-byte, two's-complement signed value in the range -32768 - +32767
            % we return it as an unsigned 16 bits integer
            
        case 3  % type 3: floating point (single)
            pixel_data = fread(image_fd,vicar.N1,'single=>single',0,endianness);
    end    
    pixels = [pixels;pixel_data'];
end
fclose(image_fd);

switch n
    case 1
        imgPixels = uint8(pixels);
    case 2
        imgPixels = uint16(pixels);
    case 3
        imgPixels = pixels/max(pixels(:));
end

end


function metadata_dict = getLabels(imgName)

metadata_fd = fopen(imgName,'r');
if (metadata_fd==-1) 
    error('Can''t find %s ',imgName);
end
l=fgetl(metadata_fd);
s=strsplit(l,'  ');
metadata_dict = struct();
for i = 1:(length(s)-1)
        [tag,value] = strSplit(char(s(i)),'=');
        if (strcmp(tag,'TASK'))
            break;
        end
        %fprintf('tag=<%s> value=%f \n',tag,value);
        if ~isempty(tag)
            metadata_dict = setfield(metadata_dict,tag,value);
        end
end
fclose(metadata_fd);
end

function [tag,value] = strSplit(str,ch)

    id = strfind(str,ch);
    tag = str(1:id-1);
    value = str(id+1:end);
    if(~isnan(str2double(value)))
        value = str2double(value);
    else
        value = str(id+2:end-1);
    end
end
