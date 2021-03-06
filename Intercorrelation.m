function [E] = Intercorrelation(Ireg, Iref, Mask)
    
    % mask images:
    [Ireg, Iref] = MaskImages(Ireg,Iref,Mask);
    
    Ireg = Ireg(:);              % cast to array
    Ireg = Ireg(Ireg ~= 0);      % get rid of all zeros
    % do same for Iref
    Iref = Iref(:);
    Iref = Iref(Iref ~= 0);
    
    S = sum(sum(Mask));
    SigmaRef = std(Iref);
    SigmaReg = std(Ireg);
    MeanRef = mean(Iref);
    MeanReg = mean(Ireg);
    
    % calculate error:
    denom = S * SigmaRef * SigmaReg;
    Iref = Iref - MeanRef;
    Ireg = Ireg - MeanReg;
    
    IntensityProduct = Iref .* Ireg;
    E = IntensityProduct / denom;
    
