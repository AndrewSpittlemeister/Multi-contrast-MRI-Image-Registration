function [M,D,Ireg,Mask] = GlobalMotionEstimation(Mask, Iref, Ireg)
   
    C = ContrastSimilarity(Mask,Iref,Ireg);
    
    xlength = length(Iref(1,:));
    ylength = length(Iref(:,1));
    
    flag = 0;
    if C <= 0.8
        flag = 1; % use intercorrelation otherwise us mutual information.
    end
    
    if flag
        PrevError = Intercorrelation(Ireg, Iref,Mask);
    else
        PrevError = MutualInformation(Ireg, Iref, Mask, 100);
    end
    
    CurError = 0;
    iteration = 0;
    CUTOFF = 0.1;
    M = [1,0; 0,1];
    D = [0;0];
    
    if flag
        % Compute Gradient Descent for Intercorrelation error:
        while (PrevError - CurError > CUTOFF) | (iteration > 1000)
            % Test positive change in M11:
            Mnew = M;
            Mnew(1,1) = Mnew(1,1) + (1/xlength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            PositiveChangeError = Intercorrelation(NewIreg, Iref,NewMask);
            % Test negative change in M11:
            Mnew = M;
            Mnew(1,1) = Mnew(1,1) - (1/xlength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            NegativeChangeError = Intercorrelation(NewIreg, Iref,NewMask);
            
            % Check which direction yielded smaller error and update M11:
            if PositiveChangeError > NegativeChangeError
                M(1,1) = M(1,1) + (1/xlength);
            elseif NegativeChangeError > PositiveChangeError
                M(1,1) = M(1,1) - (1/xlength);
            end
            
            %---------------------------------------------------------------------------------------
            % Test positive change in M12:
            Mnew = M;
            Mnew(1,2) = Mnew(1,2) + (1/ylength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            PositiveChangeError = Intercorrelation(NewIreg, Iref,NewMask);
            % Test negative change in M12:
            Mnew = M;
            Mnew(1,2) = Mnew(1,2) - (1/ylength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            NegativeChangeError = Intercorrelation(NewIreg, Iref,NewMask);  
            
            % Check which direction yielded smaller error and update M12:
            if PositiveChangeError > NegativeChangeError
                M(1,2) = M(1,2) + (1/ylength);
            elseif NegativeChangeError > PositiveChangeError
                M(1,2) = M(1,2) - (1/ylength);
            end
            
            %---------------------------------------------------------------------------------------
            % Test positive change in M21:
            Mnew = M;
            Mnew(2,1) = Mnew(2,1) + (1/xlength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            PositiveChangeError = Intercorrelation(NewIreg, Iref,NewMask);
            % Test negative change in M21:
            Mnew = M;
            Mnew(2,1) = Mnew(2,1) - (1/xlength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            NegativeChangeError = Intercorrelation(NewIreg, Iref,NewMask);  
            
            % Check which direction yielded smaller error and update M21:
            if PositiveChangeError > NegativeChangeError
                M(2,1) = M(2,1) + (1/xlength);
            elseif NegativeChangeError > PositiveChangeError
                M(2,1) = M(2,1) - (1/xlength);
            end
            
            %---------------------------------------------------------------------------------------
            % Test positive change in M22:
            Mnew = M;
            Mnew(2,2) = Mnew(2,2) + (1/ylength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            PositiveChangeError = Intercorrelation(NewIreg, Iref,NewMask);
            % Test negative change in M22:
            Mnew = M;
            Mnew(2,2) = Mnew(2,2) - (1/ylength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            NegativeChangeError = Intercorrelation(NewIreg, Iref,NewMask);  
            
            % Check which direction yielded smaller error and update M22:
            if PositiveChangeError > NegativeChangeError
                M(2,2) = M(2,2) + (1/ylength);
            elseif NegativeChangeError > PositiveChangeError
                M(2,2) = M(2,2) - (1/ylength);
            end
            
            %---------------------------------------------------------------------------------------
            % Test Positive change for D1:
            Dnew = D;
            Dnew(1) = Dnew(1) + (1/xlength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, M, Dnew);
            PositiveChangeError = Intercorrelation(NewIreg, Iref,NewMask);
            % Test negative change for D1:
            Dnew = D;
            Dnew(1) = Dnew(1) - (1/xlength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, M, Dnew);
            NegativeChangeError = Intercorrelation(NewIreg, Iref,NewMask);
            
            % Check which direction yielded smaller error and update D1:
            if PositiveChangeError > NegativeChangeError
                D(1) = D(1) + (1/xlength);
            elseif NegativeChangeError > PositiveChangeError
                D(1) = D(1) + (1/xlength);
            end
            
            %---------------------------------------------------------------------------------------
            % Test Positive change for D2:
            Dnew = D;
            Dnew(2) = Dnew(2) + (1/ylength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, M, Dnew);
            PositiveChangeError = Intercorrelation(NewIreg, Iref,NewMask);
            % Test negative change for D2:
            Dnew = D;
            Dnew(2) = Dnew(2) - (1/ylength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, M, Dnew);
            NegativeChangeError = Intercorrelation(NewIreg, Iref,NewMask);
            
            % Check which direction yielded smaller error and update D1:
            if PositiveChangeError > NegativeChangeError
                D(2) = D(2) + (1/ylength);
            elseif NegativeChangeError > PositiveChangeError
                D(2) = D(2) + (1/ylength);
            end
            
            % Calculate the CurError of this iteration with all 6 changes:
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, M, D);
            CurError = Intercorrelation(NewIreg, Iref,NewMask);
            iteration = iteration + 1;
        end
            
    else % Start gradient descent for mutual information error:
        % Compute Gradient Descent for MutualInformation error:
        while (PrevError - CurError > CUTOFF) | (iteration > 1000)
            % Test positive change in M11:
            Mnew = M;
            Mnew(1,1) = Mnew(1,1) + (1/xlength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            PositiveChangeError = MutualInformation(NewIreg, Iref, NewMask, 100);
            % Test negative change in M11:
            Mnew = M;
            Mnew(1,1) = Mnew(1,1) - (1/xlength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            NegativeChangeError = MutualInformation(NewIreg, Iref, NewMask, 100);
            
            % Check which direction yielded smaller error and update M11:
            if PositiveChangeError > NegativeChangeError
                M(1,1) = M(1,1) + (1/xlength);
            elseif NegativeChangeError > PositiveChangeError
                M(1,1) = M(1,1) - (1/xlength);
            end
            
            %---------------------------------------------------------------------------------------
            % Test positive change in M12:
            Mnew = M;
            Mnew(1,2) = Mnew(1,2) + (1/ylength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            PositiveChangeError = MutualInformation(NewIreg, Iref, NewMask, 100);
            % Test negative change in M12:
            Mnew = M;
            Mnew(1,2) = Mnew(1,2) - (1/ylength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            NegativeChangeError = MutualInformation(NewIreg, Iref, NewMask, 100);  
            
            % Check which direction yielded smaller error and update M12:
            if PositiveChangeError > NegativeChangeError
                M(1,2) = M(1,2) + (1/ylength);
            elseif NegativeChangeError > PositiveChangeError
                M(1,2) = M(1,2) - (1/ylength);
            end
            
            %---------------------------------------------------------------------------------------
            % Test positive change in M21:
            Mnew = M;
            Mnew(2,1) = Mnew(2,1) + (1/xlength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            PositiveChangeError = MutualInformation(NewIreg, Iref, NewMask, 100);
            % Test negative change in M21:
            Mnew = M;
            Mnew(2,1) = Mnew(2,1) - (1/xlength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            NegativeChangeError = MutualInformation(NewIreg, Iref, NewMask, 100); 
            
            % Check which direction yielded smaller error and update M21:
            if PositiveChangeError > NegativeChangeError
                M(2,1) = M(2,1) + (1/xlength);
            elseif NegativeChangeError > PositiveChangeError
                M(2,1) = M(2,1) - (1/xlength);
            end
            
            %---------------------------------------------------------------------------------------
            % Test positive change in M22:
            Mnew = M;
            Mnew(2,2) = Mnew(2,2) + (1/ylength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            PositiveChangeError = MutualInformation(NewIreg, Iref, NewMask, 100);
            % Test negative change in M22:
            Mnew = M;
            Mnew(2,2) = Mnew(2,2) - (1/ylength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, Mnew, D);
            NegativeChangeError = MutualInformation(NewIreg, Iref, NewMask, 100);
            
            % Check which direction yielded smaller error and update M22:
            if PositiveChangeError > NegativeChangeError
                M(2,2) = M(2,2) + (1/ylength);
            elseif NegativeChangeError > PositiveChangeError
                M(2,2) = M(2,2) - (1/ylength);
            end
            
            %---------------------------------------------------------------------------------------
            % Test Positive change for D1:
            Dnew = D;
            Dnew(1) = Dnew(1) + (1/xlength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, M, Dnew);
            PositiveChangeError = MutualInformation(NewIreg, Iref, NewMask, 100);
            % Test negative change for D1:
            Dnew = D;
            Dnew(1) = Dnew(1) - (1/xlength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, M, Dnew);
            NegativeChangeError = MutualInformation(NewIreg, Iref, NewMask, 100);
            
            % Check which direction yielded smaller error and update D1:
            if PositiveChangeError > NegativeChangeError
                D(1) = D(1) + (1/xlength);
            elseif NegativeChangeError > PositiveChangeError
                D(1) = D(1) + (1/xlength);
            end
            
            %---------------------------------------------------------------------------------------
            % Test Positive change for D2:
            Dnew = D;
            Dnew(2) = Dnew(2) + (1/ylength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, M, Dnew);
            PositiveChangeError = MutualInformation(NewIreg, Iref, NewMask, 100);
            % Test negative change for D2:
            Dnew = D;
            Dnew(2) = Dnew(2) - (1/ylength);
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, M, Dnew);
            NegativeChangeError = MutualInformation(NewIreg, Iref, NewMask, 100);
            
            % Check which direction yielded smaller error and update D1:
            if PositiveChangeError > NegativeChangeError
                D(2) = D(2) + (1/ylength);
            elseif NegativeChangeError > PositiveChangeError
                D(2) = D(2) + (1/ylength);
            end

            % Calculate the CurError of this iteration with all 6 changes:
            % [NewIreg, NewMask] = ImageShift(Ireg, Mask, M, D);
            CurError = Intercorrelation(NewIreg, Iref,NewMask);
            iteration = iteration + 1;
        end
    end
    
    % At this point Ireg and Mask have never actually been moved.
    % M and D contain the parameters that have been optimized to move the
    % image in a way that minimizes the intensity error.
    % [Ireg, Mask] = ImageShift(Ireg, Mask, M, D);     
            
    
    
    
    
    
    
    
