function [Ireg, Mask] = TranslateY(inputIreg, Y)
    Ireg = imtranslate(inputIreg,[0,Y]);
