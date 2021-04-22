function [a] = read_tif_or_vicar2(f) 
% reads or generates tif from vicar
% f: full tif name, we assume there is a similar .IMG file there if tif is
% not present

f=f(1:end-3);
ftif=strcat(f,'TIF');
fimg=strcat(f,'IMG');
fmat=strcat(f,'mat');

if isfile(ftif)
    a=imread(ftif);
else
    if isfile(fmat)
        load(fmat);
    else
        fprintf('Can''t find %s or %s \nDecoding %s\n',ftif,fmat,fimg);
        try
            a=vicarread5(fimg);
        catch
            error('image %s not found or unreadable',fimg);
        end
        if isa(a,'single')
            save(fmat,'a'); % save as a matlab file
        else
            imwrite(a,ftif);
        end
end

end

