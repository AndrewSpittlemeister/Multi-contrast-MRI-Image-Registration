function [E] = MutualInformation(Ireg, Iref, Mask, N)
    Ireg = double(Ireg(Mask == 1));
    Iref = double(Iref(Mask == 1));
    Pref = hist(Iref, N);
    Preg = hist(Ireg, N);
    data = [Iref,Ireg];
    Joint = hist3(data, [N,N]);
    E = 0;
    for n1=1:N
        for n2=1:N
            if ~(Joint(n1, n2) == 0 || Pref(n1) == 0 || Preg(n2) == 0)
                E = E + Joint(n1,n2) * abs(log((Joint(n1,n2)/(Pref(n1)*Preg(n2)))));
            end
           
        end
    end
    E
end
    
