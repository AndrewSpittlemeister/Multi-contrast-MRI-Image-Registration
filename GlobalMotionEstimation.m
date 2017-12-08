function [Fixed] = GlobalMotionEstimation(Mask, Iref, Ireg)
   
    C = ContrastSimilarity(Mask,Iref,Ireg);
    xlength = length(Iref(1,:));
    ylength = length(Iref(:,1));
    
    if C <= 0.8
        % Compute Gradient Descent for Intercorrelation error:
        Fixed = IntercorrelationRegister(Ireg,Iref,Mask);
            
    else % Start gradient descent for mutual information error:
        Fixed = MutualInfoRegister(Ireg,Iref,Mask);
    end
end

            
    
    
    
    
    
    
    
