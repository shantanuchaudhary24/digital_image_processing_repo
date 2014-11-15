
% Main run script for running the image morphing program (Line Morphing)

% Shantanu Chaudhary, Indian Institute of Technology, Delhi, August 2014.
% shantanuchaudhary24@gmail.com, cs5100295@cse.iitd.ac.in


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clear Screen Buffer and any workspace variables.
clear all;
clc;

file1 = 'images/img1.jpg';
file2 = 'images/img2.jpg';

file3 = 'images/img3.jpg';
file4 = 'images/img4.jpg';

file5 = 'images/img5.jpg';
file6 = 'images/img6.jpg';

% Load test images.
% img_moving = imread(file1);
% img_base= imread(file2);

% moving_points: Control Points in Source Image
% fixed_points : Control Points in Destination Image
% cpselect(file1, file2,cpstruct_pt);
% cpselect(file5, file6);
% [moving_points fixed_points] = cpselect(file1, file2, 'Wait' , true);

% load('cpstruct_pts_1_2.mat');
% [moving_points fixed_points] = cpstruct2pairs(cpstruct_pts);

% load('cpstruct_pts_3_4.mat');
% [moving_points fixed_points] = cpstruct2pairs(cpstruct_pts_3_4);

load('cpstruct_pts_5_6.mat');
[moving_points fixed_points] = cpstruct2pairs(cpstruct_pts_5_6);

inp1 = file5;
inp2 = file6;

Steps = 30;
Names = [inp1 ; inp2];
OutName = 'morphed';
t = 0.5;
 morph(moving_points, fixed_points, Names, OutName,Steps);