function [Ireg, Mask] = TranslateX(inputIreg, X)
    Ireg = imtranslate(inputIreg,[X,0]);
