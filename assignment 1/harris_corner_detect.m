% harrisDetect Corner Detection to determine corner points of interests.
% srcImg    :   Image to be processed
% thresh    :   Threshold for determining points of interests
% sigma     :   Parameters to vary smoothening
% outImg    :   Output Image vector
% xArea     :   length of the area to be considered
% yArea     :   breadth of the are to be considered
%
% Shantanu Chaudhary, Indian Institute of Technology, Delhi, August 2014.
% shantanuchaudhary24@gmail.com, cs5100295@cse.iitd.ac.in

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Harris corner detection function with bilateral filter:
function [outImg] = harris_corner_detect(srcImg, thresh, sigma ,xArea, yArea)

% Verifying number of arguments to the function
narginchk(5,5);

% Converting the input source image grayscale values to double if not double already. 
if ~isa(srcImg,'double')
    srcImg = double(srcImg);
end

%Size of image
[numCols, numRows] = size(srcImg);

% Derivative width
hx = 1/numCols;
hy = 1/numRows;

% Here we define the window WILL BE CHANGED NOW
window = xArea*yArea ;

%Calculation of partial derivatives of I with respect to X and Y (finite distance method)
Ix = zeros([numCols, numRows]);
Iy = zeros([numCols, numRows]);

for i=1:numCols-1
    for j=1:numRows
        Ix(i, j)=(srcImg(i+1, j)-srcImg(i, j))/hx;
    end
end

for i=1:numCols
   for j=1:numRows-1
       Iy(i, j)=(srcImg(i, j+1)-srcImg(i, j))/hy;
   end
end

% To calculate Ix^2 and Iy^2 respectively at every pixel.
Ix2 = zeros([numCols, numRows]);
Iy2 = zeros([numCols, numRows]);

for i=1:numCols
   for j=1:numRows
       Iy2(i, j)= Iy(i, j)*Iy(i, j);
       Ix2(i, j)= Ix(i, j)*Ix(i, j);
   end
end

% To calculate Ixy at every pixel
Ixy = zeros([numCols, numRows]);
for i=1:numCols
   for j=1:numRows
       Ixy(i, j)= Ix(i, j)*Iy(i, j);
   end
end

%



