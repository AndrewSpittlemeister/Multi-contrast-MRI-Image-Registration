function [D] = HS(im1, im2, alpha, ite)
% Horn-Schunck optical flow method 
% Horn, B.K.P., and Schunck, B.G., Determining Optical Flow, AI(17), No.
% 1-3, August 1981, pp. 185-203 http://dspace.mit.edu/handle/1721.1/6337
%
% Usage:
% [u, v] = HS(im1, im2, alpha, ite, uInitial, vInitial, displayFlow)
% For an example, run this file from the menu Debug->Run or press (F5)
%
% -im1,im2 : two subsequent frames or images.
% -alpha : a parameter that reflects the influence of the smoothness term.
% -ite : number of iterations.


%% Default parameters for initialization
u = zeros(size(im1));
v = zeros(size(im1));

% smooth the image with Gaussian Filter
segma = 1.5;
kSize=2*(segma*3);
x=-(kSize/2):(1+1/kSize):(kSize/2);
G=(1/(sqrt(2*pi)*segma)) * exp (-(x.^2)/(2*segma^2));

im1=conv2(im1,G,'same');
im1=conv2(im1,G','same');

im2=conv2(im2,G,'same');
im2=conv2(im2,G','same');

im1=double(im1);
im2=double(im2);

% Estimate spatiotemporal derivatives
Ix = conv2(im1,[1 -1]);
Ix = Ix(:,1:end-1);
Iy = conv2(im1,[1; -1]);
Iy = Iy(1:end-1,:);
It= im2-im1;

% Averaging kernel
kernel_1=[1/12 1/6 1/12;1/6 0 1/6;1/12 1/6 1/12];

% Iterations
for i=1:ite
    % Compute local averages of the flow vectors
    u_localAvg=conv2(u,kernel_1,'same');
    v_localAvg=conv2(v,kernel_1,'same');
    
    % Compute flow vectors constrained by its local average and the optical flow constraints
    u= u_localAvg - ( Ix .* ( ( Ix .* u_localAvg ) + ( Iy .* v_localAvg ) + It ) ) ./ ( alpha^2 + Ix.^2 + Iy.^2); 
    v= v_localAvg - ( Iy .* ( ( Ix .* u_localAvg ) + ( Iy .* v_localAvg ) + It ) ) ./ ( alpha^2 + Ix.^2 + Iy.^2);
end

u(isnan(u))=0;
v(isnan(v))=0;
D = zeros(176,176,2);
D(:,:,1) = u;
D(:,:,2) = v;

