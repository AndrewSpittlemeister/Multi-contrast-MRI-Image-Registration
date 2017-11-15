image = dicomread('img3.dcm');
figure;
imshow(image,[]);
TestMask = ones(176,176);
WastMask = ones(176,176);
M = [0.707,-0.707; 0.707,0.707];
D = [0;0];
ImageShiftFunc(image, TestMask, M, D);
function [NewIreg, NewMask] = ImageShiftFunc(Ireg, Mask, Mnew, D)
    JointMatrix = cat(1,cat(2,Mnew,D),[0,0,1])
    xlength = length(Ireg(1,:));
    ylength = length(Ireg(:,1));
    
    PreTranslate = [1, 0, -xlength/2; 0, 1, ylength/2; 0, 0, 1]
    PostTranslate = [1, 0, xlength/2; 0, 1, -ylength/2; 0, 0, 1]
    
    %TransMatrix = PostTranslate * JointMatrix * PreTranslate;
    TransMatrix = PreTranslate;
    NewIreg = zeros(xlength, ylength);
    
    %Use Reverse Mapping to get New Image
    for x = 1:xlength
        for y = 1:ylength
            if x <= 50 && y <= 50
                Ireg(y,x) = 0;
            end
            loc = [x;y;1];
            %NewLoc = TransMatrix * loc;
            NewLoc = loc;
            NewLoc(1) = round(NewLoc(1));
            NewLoc(2) = round(NewLoc(2));
            %Boundary check for our NewLoc
            if NewLoc(1) >= 1 && NewLoc(2) >= 1
                if NewLoc(1) <= xlength && NewLoc(2) <= ylength
                    %Currently using simple point sampling. Could be improved using different sampling method
                    NewIreg(y,x) = Ireg(NewLoc(1), NewLoc(2));
                end
            end
        end
    end
    NewIreg = Mask .* NewIreg;
    figure;
    imshow(NewIreg, []);
    
end
