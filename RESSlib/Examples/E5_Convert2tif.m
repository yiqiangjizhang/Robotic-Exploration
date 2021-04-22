% Converts all images in cache to tif format 
% WARNING: this can generate a lot of data
clear 
close all

showImages=0;



myFiles = dir(sprintf('%s/imgo/*mat',getHomeSpice)); %gets all wav files in struct
for k = 1:length(myFiles)
    fprintf('<%s> ',myFiles(k).name);
    ftif=strrep(sprintf('%s/imgo/%s',getHomeSpice,myFiles(k).name),'mat','tif');
    if isfile(ftif)==0
        fprintf(' processing\n');

        load(sprintf('%s/imgo/%s',getHomeSpice,myFiles(k).name));
        if showImages
            imshow(a);
        end
        if strcmp(class(a),'single')
            b=uint8(255*a);
        else
            b=uint16(65535*a);
        end

        imwrite(b,ftif);
    else
        fprintf(' skipping\n');
    end
end