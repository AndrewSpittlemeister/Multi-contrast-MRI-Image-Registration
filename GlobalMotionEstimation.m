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
        PrevError = Intercorrelation(IregMasked, IrefMasked,Mask);
    else
        PrevError = MutualInformation(IregMasked, IrefMasked, 100);
    end
    
    ErrorChange = inf;
    M = [1, 0; 0, 1];
    D = [0 ; 0];
    
    if flag % Start Gradient Descent for Intercorrelation error:
        while ErrorChange < 1
            % for each of the 6 parameters vary their values positively and negatively.
            % after each change calculate the respective error function value.
            % this will produce 6 x 2 matrix of errors (col 1 for postive changes, col 2 for negative).
                  % rows are denoted from top to bottom: M11, M12, M21, M22, D1, D2
            % for each row determine which error is less, and either the positve or negative action for 
               % that parameter will be implemented.
            % implement these changes onto the IregMasked matrix and its Mask.
            % Recalculate the error for the newly changed image and store this in CurError.
            % Assign abs(CurError - PrevError) to ErrorChange for the while loop conditional.
            M(1,1) = M(1,1) + (1/xlength);
                    
    else % Start gradient descent for mutual information error:           
            
            
    
    
    
    
    
    
    
