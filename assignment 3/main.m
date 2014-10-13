
% Main run script for running the program

% Shantanu Chaudhary, Indian Institute of Technology, Delhi, August 2014.
% shantanuchaudhary24@gmail.com, cs5100295@cse.iitd.ac.in


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Load test images.
img1 = imread('images/lena.bmp');
img2 = imread('images/lena_cropped_rotated_shifted.bmp');

% Call to Image Registration Function
image_register(img1, img2);