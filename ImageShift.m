image = dicomread('ACCMR_VOL_020.MR.AKCAKAYA_VE11C_SETUP.0013.0001.2017.08.18.16.08.30.466382.36253287.IMA');
TestMask = ones(176,176);
WastMask = ones(176,176);
M = [1,0; 0,1];
D = [0;0];
ImageShiftFunc(image, TestMask, M, D);
function [NewIreg, NewMask] = ImageShiftFunc(Ireg, Mask, Mnew, D)
    JointMatrix = cat(1,cat(2,Mnew,D),[0,0,1]);
    xlength = length(Ireg(1,:));
    ylength = length(Ireg(:,1));
    
    NewIreg = zeros(xlength, ylength);
    
    %Use Reverse Mapping to get New Image
    for x = 1:xlength
        for y = 1:ylength
            loc = [x;y;1];
            NewLoc = JointMatrix * loc;
            NewLoc(1,1) = int16(NewLoc(1,1));
            NewLoc(2,1) = int16(NewLoc(2,1));
            %Boundary check for our NewLoc
            if NewLoc(1,1) >= 1 && NewLoc(2,1) >= 1
                if NewLoc(1,1) <= xlength && NewLoc(2,1) <= ylength
                    %Currently using simple point sampling. Could be improved using different sampling method
                    NewIreg(x,y) = Ireg(NewLoc(1), NewLoc(2));
                end
            end
        end
    end
    NewIreg = Mask .* NewIreg
    
end

