function dicomshow(img)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure
imshow(img,[]);
hFig = gcf;
set(hFig,'units','normalized','outerposition',[0 0 1 1]);
set(hFig,'menubar','none');
set(hFig,'NumberTitle','off');
end

