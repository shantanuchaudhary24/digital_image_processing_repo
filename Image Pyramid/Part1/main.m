
% Main run script for running the program

% Shantanu Chaudhary, Indian Institute of Technology, Delhi, August 2014.
% shantanuchaudhary24@gmail.com, cs5100295@cse.iitd.ac.in


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clean screen buffer and clear any workspace variables
clear all;
clc;

% Load test images.
img1 = imread('images/apple.jpeg');
img2 = imread('images/orange.jpeg');
img3 = imread('images/apple.png');
img4 = imread('images/orange.png');

% Level of pyramid
level = 6;

% Converting to double precision for better processing
 img1 = im2double(img1); % Size of image 1
 img2 = im2double(img2); % Size of image 2

%  img1 = im2double(img3); % Size of image 1
%  img2 = im2double(img4); % Size of image 2

% Extract size of images for equalization of image size
% m and n denote the rows and columns
[m n ~] = size(img1);
[mPrime nPrime ~] = size(img2);

% Resize image before construction of pyramid for both image
% Here we resize img2 with respect to img1
img2 = imresize(img2,[m n]);

% Specifies the extent to which to blend 
blend_extent = n/2;

sigma = 20;
hsize = 35;

% Construct Image pyramid of image
pyramid_img1 = pyramid(img1,level);
pyramid_img2 = pyramid(img2,level);

mask1 = zeros(size(img2));
mask1(:,1:blend_extent,:) = 1;
mask2 = 1-mask1;
blur_kernel = fspecial('gauss',hsize,sigma); % feather the border
mask1 = imfilter(mask1,blur_kernel,'replicate');
mask2 = imfilter(mask2,blur_kernel,'replicate');

pyramid_blend = cell(1,level); % the blended pyramid

% Fixing contrast of image
for i = 1:level
	[Mp Np ~] = size(pyramid_img1{i});
	mask1_prime = imresize(mask1,[Mp Np]);
	mask2_prime = imresize(mask2,[Mp Np]);
	pyramid_blend{i} = pyramid_img1{i}.*mask1_prime + pyramid_img2{i}.*mask2_prime;
%     pyramid_blend{p} = pyramid_img1{p} + pyramid_img2{p};
end

% Refer Paper: bandpass pyramid is generated in the following loop
% using the expression Gi = Li + EXPAND[i+1].
for i = length(pyramid_blend)-1:-1:1
	pyramid_blend{i} = pyramid_blend{i}+img_expand(pyramid_blend{i+1});
end

% blend by pyramid
blended_img = pyramid_blend{1};

% blend by sharpening
img_sharp = mask1.*img1+mask2.*img2;


% blend by pyramid
imwrite(blended_img,'images/blend_pyramid.jpeg') 

% blend by sharpening
imwrite(img_sharp,'images/blend_sharp.jpeg')
