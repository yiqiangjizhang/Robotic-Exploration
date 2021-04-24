function [l1] = readFileList(f)
% reads a text file with one word per line into a list; empty lines are
% discarded and strings trimmed

d = fileread(f);
l1 = strsplit(d,'\n');
l1=l1(~cellfun('isempty',l1));
for i=1:length(l1)
    l1{i}=strtrim(l1{i});
end

end