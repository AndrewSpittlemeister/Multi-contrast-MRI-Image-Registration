function [FixedImage] = LocalMotionEstimation(Ireg, Iref, Mask)
    IregM = uint8(Ireg .* Mask);
    IrefM = uint8(Iref .* Mask);

    D1 = HS(IregM,IrefM,100,100);

% with GPU:
%     GPUreg = gpuArray(IregM);
%     GPUref = gpuArray(IrefM);
%     fixedHist = imhist(GPUref);
%     GPUreg = histeq(GPUreg,fixedHist);
%     
%     [GPUD,~] = imregdemons(GPUreg,GPUref,[50 50 50 50 50 50],'AccumulatedFieldSmoothing',25, 'PyramidLevels',6);  
%     D2 = gather(GPUD);


% Without GPU:
    Iregh = imhistmatch(IregM,IrefM);
    [D2,~] = imregdemons(Iregh,IrefM,[50 50 50 50 50 50],'AccumulatedFieldSmoothing',25, 'PyramidLevels',6);

    D = zeros(size(D2));
    D(:,:,1) = (D1(:,:,1) + D2(:,:,1)) / 2;
    D(:,:,2) = (D1(:,:,2) + D2(:,:,2)) / 2;
    
    FixedImage = imwarp(Ireg,D, 'cubic');