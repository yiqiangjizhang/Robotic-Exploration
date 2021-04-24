function fK=fullK(MK) 
% generates a full kernel list for initSPICE from a list with kernel web locations

fK={};
for i=1:numel(MK)
    n=MK{i};
    fK{end+1}=n;
    nl=strsplit(n,'/');
    fK{end+1}=nl{end};
end

end
