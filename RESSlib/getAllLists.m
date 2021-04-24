% From downloaded data, generates a structure containing image information
% spacecraftid can be 'VOYAGER1', 'VOYAGER2' or 'CASSINI'
% encounter can be (for CASSINI) 'JUPITER' or 'SATURN'
%  ...

function L = getAllLists(spacecraftid,encounter)

% TODO: check input !!

p=getHomeSpice();
spacecraftid=upper(spacecraftid);
encounter=upper(encounter);

L.seconds   =readFileList(sprintf('%s/%s/%s/main_list/EXPOSURE_SECONDS.txt',p,spacecraftid,encounter));
L.host      =readFileList(sprintf('%s/%s/%s/main_list/HOST.txt',p,spacecraftid,encounter));  
L.name      =readFileList(sprintf('%s/%s/%s/main_list/NAME.txt',p,spacecraftid,encounter)); 
L.target    =readFileList(sprintf('%s/%s/%s/main_list/TARGET_NAME.txt',p,spacecraftid,encounter)); 
L.filter    =readFileList(sprintf('%s/%s/%s/main_list/FILTER_NAME.txt',p,spacecraftid,encounter)); 
L.instrument=readFileList(sprintf('%s/%s/%s/main_list/INSTRUMENT.txt',p,spacecraftid,encounter)); 
L.timestr   =readFileList(sprintf('%s/%s/%s/main_list/START_TIME.txt',p,spacecraftid,encounter));
L.volume    =readFileList(sprintf('%s/%s/%s/main_list/VOLUME.txt',p,spacecraftid,encounter));

L.nd=length(L.seconds);

if length(L.host)~=L.nd, error('Inconsistent lists2'); end
if length(L.name)~=L.nd, error('Inconsistent lists3'); end
if length(L.target)~=L.nd, error('Inconsistent lists4'); end
if length(L.filter)~=L.nd, error('Inconsistent lists5'); end
if length(L.instrument)~=L.nd, error('Inconsistent lists6'); end
if length(L.timestr)~=L.nd, error('Inconsistent lists7'); end
if length(L.volume)~=L.nd, error('Inconsistent lists8'); end


if strcmp(spacecraftid,'CASSINI')==0 % if not Cassini
    for i=1:L.nd
        %fprintf('<%s>\n',L.instrument{i});
        q=strsplit(L.instrument{i},'-');
        %q{2}=q{2}(1:end);
        if numel(q)>1
            L.instrument{i}=strtrim(q{2});
        end
    end
else % CASSINI
    for i=1:L.nd
        L.instrument{i}=L.instrument{i}(2:end);
    end
    for i=1:L.nd
        %fprintf('Host=<%s>\n',L.host{i});
        if strcmp(L.host{i},'CASSINIORBITER')==1 || strcmp(L.host{i},'CASSINI ORBITER')==1
            L.host{i}='CASSINI';
        else
            %fprintf('Instrument=<%s>\n',L.host{i});
        end   
    end
    %fprintf('CONVERSION TO SECONDS MARTI\n');
end

rr=[];
for i=1:L.nd
    if strcmp(L.timestr{i},'"UNK"')==1
        rr(end+1)=i;
    end
end

L.seconds(rr)   =[]; 
L.host(rr)      =[];
L.name(rr)      =[];
L.target(rr)    =[];
L.filter(rr)    =[];
L.instrument(rr)=[];
L.timestr(rr)   =[];
L.volume(rr)    =[];



L.nd=length(L.seconds);

end

