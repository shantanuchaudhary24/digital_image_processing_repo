
% Main run script for running the image morphing program

% Shantanu Chaudhary, Indian Institute of Technology, Delhi, August 2014.
% shantanuchaudhary24@gmail.com, cs5100295@cse.iitd.ac.in


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clear Screen Buffer and any workspace variables.
clear all;
clc;

file1 = 'images/bryan.jpg';
file2 = 'images/jim.jpg';
% Load test images.
img_moving = imread(file1);
img_base= imread(file2);

[moving_points, base_points] = cpselect(file1, file2,'Wait', true);

% Call to Image Morphing Function
image_morph(img_moving, img_base, moving_points, base_points);