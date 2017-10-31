function GlobalMotionEstimation(Mask, Iref, Ireg)
   
    C = ContrastSimilarity(Mask,Iref,Ireg);
    IregMasked = Mask .* Ireg;
    IrefMasked = Mask .* Iref;
    
    xlength = length(Iref(1,:));
    ylength = length(Iref(:,1));
    
    flag = 0;
    if C <= 0.8
        flag = 1; % use intercorrelation
    end
    
    if flag
        InitialError = Intercorrelation(IregMasked, IrefMasked,Mask);
    else
        InitialError = MutualInformation(IregMasked, IrefMasked, 100);
    end
    
    ErrorChange = inf;
    M = [1, 0; 0, 1];
    D = [0 ; 0];
    % Start Gradient Descent.
    while ErrorChange < 1
        if flag
            % postive M11 change:
            M(1,1) = M(1,1) + (1/xlength);
            
            
            
    
    
    
    
    
    
    