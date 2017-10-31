function [C] = ContrastSimilarity(M, Iref, Ireg)
    % Will return the contrast similarity measure C.
    refsum = sum(sum(M .* Iref));
    regsum = sum(sum(M .* Ireg));
    C = abs(1 - (refsum/regsum));