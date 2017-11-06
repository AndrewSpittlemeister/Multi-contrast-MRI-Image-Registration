function [IregMasked, IrefMasked] = MaskImages(Ireg,Iref,Mask)
    IregMasked = Mask .* Ireg;
    IrefMasked = Mask .* Iref;