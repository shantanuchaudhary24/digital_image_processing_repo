% harrisDetect Corner Detection to determine corner points of interests.
% inpImg        :   Image to be processed
% thresh        :   Threshold for determining points of interests
% sigma         :   Parameters to vary smoothening
% windowWidth   :   Size of window to analyse R (scoreMatrix)
% w             :   For filtering
% k             :   For harris corner measure (Value is between 0.04 -0.06)
% Shantanu Chaudhary, Indian Institute of Technology, Delhi, August 2014.
% shantanuchaudhary24@gmail.com, cs5100295@cse.iitd.ac.in


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Harris corner detection function with bilateral filter:
function [] = harris_corner_detect(inpImg, sigma , w, k,windowWidth, thresh)

% Verifying number of arguments to the function
% narginchk(7,7); 
 
% Reduce noise in the image by using bilateral filter

% srcImg= bfilter2(inpImg, w, sigma1);
 if ~isa(inpImg,'double')
	srcImg = double(inpImg)/255;
 else
    srcImg = inpImg/255;
 end
[m,n,colorWidth] = size(inpImg);

% Calculation of partial derivatives of I with respect to X and Y uses
% sobel operators. We define the following Sobel operators as masks
Gx = [-1 0 1 ; -1 0 1 ; -1  0  1 ];
Gy = Gx';

% The partial derivatives (approximated) can be obtained by using the
% convolution of Gx and Gy with srcImg for partial derivatives with respect
% to X and Y respectively.
if colorWidth > 1   % For colored picture
    Ix = conv2(rgb2gray(srcImg), Gx, 'same');
    Iy = conv2(rgb2gray(srcImg), Gy, 'same');
    disp('RGB Deteted!');
else                % For Grayscale Picture
    Ix = conv2(srcImg, Gx, 'same');
    Iy = conv2(srcImg, Gy, 'same');
    disp('Grayscale Detected!');
end

% For Debugging
% dlmwrite('harris1_Ix', Ix);
% dlmwrite('harris1_Iy', Iy);

% To calculate Ix^2 and Iy^2 respectively. Point to Point multiplication
% and not matrix multiplication and smoothened with bilateral filter
Ix2 = bfilter2(double(Ix.^2)/255, w, sigma);
Iy2 = bfilter2(double(Iy.^2)/255, w, sigma);
Ixy = bfilter2(abs(Ix.*Iy)/255, w, sigma);

% Calculation of the harris measure score is done here:
% R = det(M) - k(trace(M))^2 : where M is the structure tensor calculated
% det(M) = (Ix2.*Iy2 - Ixy.^2)
% trace(M) = (Ix + Iy)

  scoreMatrix = (Ix2.*Iy2 - Ixy.^2) - k*(Ix + Iy).^2 ;

% Suppression of minimas and elevation of maximas takes place here:
  resultScoreMatrix = findCorner(scoreMatrix, windowWidth, thresh);

  [r,c] = find(resultScoreMatrix);
  figure, imagesc(inpImg), axis image, colormap(gray), hold on
  plot(c,r,'gs'), title('corners detected');
return;

% Following code is incase we don't want to use conv function of matlab.
%{
% Derivative width
hx = 1/numCols;
hy = 1/numRows;

%Calculation of partial derivatives of I with respect to X and Y (finite distance method)
IxPrime = zeros([numCols, numRows]);
IyPrime = zeros([numCols, numRows]);

for i=1:numCols-1
    for j=1:numRows
        IxPrime(i, j)=(srcImg(i+1, j)-srcImg(i, j))/hx;
    end
end

for i=1:numCols
   for j=1:numRows-1
       IyPrime(i, j)=(srcImg(i, j+1)-srcImg(i, j))/hy;
   end
end

% To calculate IxPrime^2 and IyPrime^2 respectively at every pixel.
IxPrime2 = zeros(numCols, numRows);
IyPrime2 = zeros(numCols, numRows);

for i=1:numCols
   for j=1:numRows
       IyPrime2(i, j)= IyPrime(i, j)*IyPrime(i, j);
       IxPrime2(i, j)= IxPrime(i, j)*IxPrime(i, j);
   end
end

% To calculate IxyPrime at every pixel
IxyPrime = zeros([numCols, numRows]);
for i=1:numCols
   for j=1:numRows
       IxyPrime(i, j)= IxPrime(i, j)*IyPrime(i, j);
   end
end

%}

