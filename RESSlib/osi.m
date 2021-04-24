function [ fname ] = osi( fname )
% Manel Soria July 2019
% operating system independent
% given a path name
% changes / to \ or viceversa, only if needed, to suit the operating system
% eg osi('a/b/c') excuted in a windows machine will return 'a\b\c'

if ismac || isunix % to unix
    fname(fname=='\')='/';
else % windows
    fname(fname=='/')='\';    
end

end

