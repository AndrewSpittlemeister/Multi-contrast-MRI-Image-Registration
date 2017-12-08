function [RegisteredImg] = MutualInfoRegister(Ireg,Iref,Mask)

keepSize = imref2d(size(Iref));
metric = registration.metric.MattesMutualInformation;
optimizer = registration.optimizer.OnePlusOneEvolutionary;
optimizer.InitialRadius = optimizer.InitialRadius / 500;

% mask out images.
Iref = uint16(Iref);
Ireg = uint16(Ireg);
Mask = uint16(Mask);

moving = Ireg;
fixed = Iref .* Mask;

tform = imregtform(moving, fixed, 'affine', optimizer, metric);
RegisteredImg = imwarp(moving, tform, 'OutputView', keepSize);
end

