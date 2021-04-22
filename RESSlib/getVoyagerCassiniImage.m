function a = getVoyagerCassiniImage(L,i,imgtype)
% Downloads (if not yet in local drive) a Cassini or Voyager RAW image,
% decodes it to tif, and saves it. Returns the tif image
%
% L: image list as returned by getAllLists
% i: index of the image to be downloaded
% imgtype can be 'CALIB' or 'RAW'


    if strcmp(L.host{i},'CASSINI')
        q=strsplit(L.volume{i},'_');
        CC=q{2}(1);
        fullpath=sprintf('%s/imgo/',getHomeSpice());
        if strcmp(imgtype,'RAW')==1
            web=sprintf('https://pds-rings.seti.org/holdings/volumes/COISS_%sxxx_v1.0/%s/%s.IMG',CC,L.volume{i},L.name{i});
            file=sprintf('%s/%s.IMG',fullpath,L.name{i});
        else % CALIB
            if strcmp(imgtype,'CALIB')~=1
                error('uhh ? only RAW or CALIB');
            end
            web=sprintf('https://pds-rings.seti.org/holdings/calibrated/COISS_%sxxx/%s/%s_CALIB.IMG',CC,L.volume{i},L.name{i});
            file=sprintf('%s/%s_CALIB.IMG',fullpath,L.name{i});            
        end
        
        if ~isfile(file)
            fprintf('downloading %s\nsaving as %s \n',web,file);        
            websave(file,web);
        end
    else
        vol=L.volume{i};
        img=L.name{i};
        fullpath=sprintf('%s/imgo/',getHomeSpice());
        %fprintf('fullpath=%s\n',fullpath);
        [SUCCESS,MESSAGE,MESSAGEID]=mkdir(fullpath);
        xvv=strcat(img(1:end-2),'XX');
        file=sprintf('%s/%s_%s.IMG',fullpath,img,imgtype);
        if ~isfile(file)
            web=sprintf('https://pds-rings.seti.org/holdings/volumes/VGISS_%sxxx/%s/DATA/%s/%s_%s.IMG',vol(end-3),vol,xvv,img,imgtype);
            fprintf('downloading %s\nsaving as %s \n',web,file);
            websave(file,web);
        end
        %fprintf('Reading %s\n',file);
    end
    
    a=read_tif_or_vicar2(file);
end

