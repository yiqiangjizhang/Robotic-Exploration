function myhist( img )
% plots histogram of a uint8 monochrome image

for c=0:255 
    n(c+1)=sum(img(:)==c);
end

plot(n)
end

