function allok=compareKernels(METAKR) 
% returns 1 if all the kernels in METAKR and only them are already loaded in the same
% order

HOMESPICE=getHomeSpice;
    
count = cspice_ktotal( 'ALL' );
     
allok=1;

if numel(METAKR)~=count*2
    allok=0;
    return
end

for i = 1:count
 
    [ file, type, source, handle, found ] = cspice_kdata( i, 'ALL');

    if ( ~found )
        continue;
    end

    kfile=osi(sprintf('%s/kernels/%s',HOMESPICE,METAKR{2*i}));

    if strcmp(file,kfile)==1
        fprintf('got %s \n',file);
    else
        allok=0;
        break;
    end

end


