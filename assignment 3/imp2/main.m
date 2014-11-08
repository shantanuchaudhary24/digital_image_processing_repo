
% Main run script for running the program

% Shantanu Chaudhary, Indian Institute of Technology, Delhi, August 2014.
% shantanuchaudhary24@gmail.com, cs5100295@cse.iitd.ac.in


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clear Screen Buffer and any workspace variables.
clear all;
clc;

% Load test image.
img = imread('images/s1.bmp');

% Call to Image Registration Function
 image_register(img, 'rotate');

% image_register(img, 'rotate');