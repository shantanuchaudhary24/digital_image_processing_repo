
% RUNDEMO Illustrates the use of BFILTER2 and CARTOON.
%    This demo shows typical usage for the bilateral 
%    filter implemented by BFILTER2. The application
%    of bilateral filtering to image abstraction is
%    demonstrated by the CARTOON function.
%
% Douglas R. Lanman, Brown University, September 2006.
% dlanman@brown.edu, http://mesh.brown.edu/dlanman


% Load test images.
% Note: Must be double precision in the interval [0,1].
img1 = double(imread('einstein.jpg'))/255;

% Introduce AWGN into test images.
% Note: This will show the benefit of bilateral filtering.
img1 = img1+0.05*randn(size(img1));
img1(img1<0) = 0; img1(img1>1) = 1;

% Set bilateral filter parameters.
w     = 5;       % bilateral filter half-width
sigma = [1.25 0.1]; % bilateral filter standard deviations

% Apply bilateral filter to each image.
bflt_img1 = bfilter2(img1,w,sigma);

% Display grayscale input image and filtered output.
figure(1); clf;
set(gcf,'Name','Grayscale Bilateral Filtering Results');
subplot(1,2,1); imagesc(img1);
axis image; colormap gray;
title('Input Image');
subplot(1,2,2); imagesc(bflt_img1);
axis image; colormap gray;
title('Result of Bilateral Filtering');

drawnow;