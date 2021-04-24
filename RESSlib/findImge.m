function vi=findImge(L,iname) 
% Given an image list L and a string imagename prints info about all images
% containing the characters iname and returns a vector with their indices

vi=[];
for i=1:L.nd
    if ~isempty(strfind(L.name{i},iname))
        fprintf('i=%d name=<%s> host=<%s> target=<%s> filter=<%s> timestr=<%s> seconds=%s volume=<%s> \n', ...
            i,L.name{i},L.host{i},L.target{i},L.filter{i},L.timestr{i},L.seconds{i},L.volume{i} );
        vi(end+1)=i;
    end
end

end