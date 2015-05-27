
% Main run script for running the program

% Shantanu Chaudhary, Indian Institute of Technology, Delhi, August 2014.
% shantanuchaudhary24@gmail.com, cs5100295@cse.iitd.ac.in


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clean screen buffer and clear any workspace variables
clear all;
clc;

% Load test images.

% File Names
img_name1 = 's1';
img_name2 = 's2';
img_name3 = 's3';
img_name4 = 's4';

% File Names along with full paths
img_name1_prime = strcat('images/',img_name1,'.png');
img_name2_prime = strcat('images/',img_name2,'.png');
img_name3_prime = strcat('images/',img_name3,'.png');
img_name4_prime = strcat('images/',img_name4,'.png');

% Read Image Files
img1 = imread( img_name1_prime );
img2 = imread( img_name2_prime );
img3 = imread( img_name3_prime );
img4 = imread( img_name4_prime );

% Level of pyramid
level = 5;

% Compress the sample test images by building the laplacian pyramid
img_restored = img_compress(img1, img_name1, level);
% imwrite(uint8(img_restored), 'images/s1_restored.png');

img_restored = img_compress(img2, img_name2, level);
% imwrite(uint8(img_restored), 'images/s2_restored.png');

img_restored = img_compress(img3, img_name3, level);
% imwrite(uint8(img_restored), 'images/s3_restored.png');

img_restored = img_compress(img4, img_name4, level);
% imwrite(uint8(img_restored), 'images/s4_restored.png');
