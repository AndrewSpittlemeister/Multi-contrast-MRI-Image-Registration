
function p=adjustgray(imgin)
%Pass an input image
%and output array of same size
%Output is normalized to 0-255
temp=255/double(max(max(imgin)));
aa=size(imgin);
a=zeros(aa(1),aa(2),'uint8');
for y=1:aa(1)
    for z=1:aa(2)
        a(y,z)=round(imgin(y,z)*temp);
    end
end
p=a;
end
