
% Main run script for running the program

% Shantanu Chaudhary, Indian Institute of Technology, Delhi, August 2014.
% shantanuchaudhary24@gmail.com, cs5100295@cse.iitd.ac.in


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clear Screen Buffer and any workspace variables.
 clear all;
 clc;

% Load test images.
% img00 = imread('images/testcases/case1/original.png');

[img00,map] = imread('images/s1.bmp');
[img01,map] = imread('images/s1_rotated.bmp');

[img02,map] = imread('images/s2.bmp');
[img03,map] = imread('images/s2_shifted_rotated.bmp');

[img04,map] = imread('images/s4.bmp');
[img05,map] = imread('images/s4_shifted.bmp');

img1 = imread('images/testcases/case1/s1.bmp');
img2 = imread('images/testcases/case1/s2.bmp');

[img3,map] = imread('images/testcases/case2/s1.bmp');
[img4,map] = imread('images/testcases/case2/s2.bmp');

[img5,map] = imread('images/testcases/case3/s1.bmp');
[img6,map] = imread('images/testcases/case3/s2.bmp');

%  image_register(img0, img00);

% Call to Image Registration Function
%    image_register(img1, img2);
%    image_register(img3, img4);
%    image_register(img5, img6);

% 
   image_register(img00, img01);
   image_register(img02, img03);
   image_register(img04, img05);