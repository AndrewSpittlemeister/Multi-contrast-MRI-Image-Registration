function [Ireg, Mask] = Rotate(inputIreg, inputMask, deg)
    Ireg = imrotate(inputIreg, deg);
    Mask = imrotate(inputMask, deg);
    % note that there is a gpu enabled implementation of imrotate.