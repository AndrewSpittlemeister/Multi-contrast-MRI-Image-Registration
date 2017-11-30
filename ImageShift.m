function [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D)
    %Invert due to reverse Mapping. Also Y axis is downaward.
    JointMatrix = cat(1,cat(2,Mnew,D),[0,0,1]);
    xlength = length(Ireg(1,:));
    ylength = length(Ireg(:,1));
    PreTranslate = [1, 0, -xlength/2; 0, 1, -ylength/2; 0, 0, 1];
    %PostTranslate = inv(PreTranslate)
    FlipYMatrix = [1, 0, 0; 0, -1, 0; 0, 0, 1];
    
    TransformMatrix = (PreTranslate \ (FlipYMatrix * JointMatrix * FlipYMatrix * PreTranslate));
    
    NewIreg = zeros(xlength, ylength);
    
    %Use Reverse Mapping to get New Image
    for x = 1:xlength
        for y = 1:ylength
            loc = [x;y;1];
            NewLoc = TransformMatrix \ loc;
            NewLoc(1) = round(NewLoc(1));
            NewLoc(2) = round(NewLoc(2));
            %Boundary check for our NewLoc
            if NewLoc(1) >= 1 && NewLoc(2) >= 1
                if NewLoc(1) <= xlength && NewLoc(2) <= ylength
                    %Currently using simple point sampling. Could be improved using different sampling method
                    NewIreg(y,x) = Ireg(NewLoc(2), NewLoc(1));
                end
            end
        end
    end

    NewMask = Mask;
end

