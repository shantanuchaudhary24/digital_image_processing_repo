function [cim, r, c] = harris2(im, sigma, thresh, radius, disp)
    
    error(nargchk(2,5,nargin));
    
    dx = [-1 0 1; -1 0 1; -1 0 1]; % Derivative masks
    dy = dx';
    
    Ix = conv2(im, dx, 'same');    % Image derivatives
    Iy = conv2(im, dy, 'same');    
    
    % Generate Gaussian filter of size 6*sigma (+/- 3sigma) and of
    % minimum size 1x1.
    g = fspecial('gaussian',max(1,fix(6*sigma)), sigma);
    
    Ix2 = conv2(Ix.^2, g, 'same'); % Smoothed squared image derivatives
    Iy2 = conv2(Iy.^2, g, 'same');
    Ixy = conv2(Ix.*Iy, g, 'same');
    
    
%    cim = (Ix2.*Iy2 - Ixy.^2)./(Ix2 + Iy2 + eps); % Harris corner measure
    % Alternate Harris corner measure used by some.  Suggested that
    % k=0.04 - I find this a bit arbitrary and unsatisfactory.
   cim = (Ix2.*Iy2 - Ixy.^2) - 0.04*(Ix2 + Iy2).^2; 
    
    dlmwrite('harris2', cim);
    
    if nargin > 2   % We should perform nonmaximal suppression and threshold
	
	% Extract local maxima by performing a grey scale morphological
	% dilation and then finding points in the corner strength image that
	% match the dilated image and are also greater than the threshold.
	sze = 2*radius+1;                   % Size of mask.
	mx = ordfilt2(cim,sze^2,ones(sze)); % Grey-scale dilate.
	cim = (cim==mx)&(cim>thresh);       % Find maxima.
	
	[r,c] = find(cim);                  % Find row,col coords.
	
	if nargin==5 & disp      % overlay corners on original image
	    figure, imagesc(im), axis image, colormap(gray), hold on
	    plot(c,r,'ys'), title('corners detected');
	end
    
    else  % leave cim as a corner strength image and make r and c empty.
	r = []; c = [];
    end