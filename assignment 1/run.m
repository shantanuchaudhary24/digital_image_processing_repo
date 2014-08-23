
% Main run script for running the program

% Shantanu Chaudhary, Indian Institute of Technology, Delhi, August 2014.
% shantanuchaudhary24@gmail.com, cs5100295@cse.iitd.ac.in


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Load test images.
% Note: Must be double precision in the interval [0,1].
img1 = imread('pyramid.png');
img2 = imread('chair.png');
img3 = imread('einstein.jpg');

% Set bilateral filter parameters.
w     = 5;       % bilateral filter half-width
sigma1 = [1.25 0.1]; % bilateral filter standard deviations

%Set Harris parameters
% Manipulate the following parameters to fine tune corner detection
k   =   0.04;
windowWidth = 5;
threshold = 30;

harris_corner_detect(img1,sigma1, w, k, windowWidth, threshold);

%Set Harris parameters
% Manipulate the following parameters to fine tune corner detection
k   =   0.04;
windowWidth = 7;
threshold = 0.006;

harris_corner_detect(img2,sigma1, w, k, windowWidth, threshold);