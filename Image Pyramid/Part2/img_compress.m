% This function constructs the image pyramid and returns
% the compressed image.
% img: Image to be reduced
% level: Level upto which pyramid is to be constructed.
% img_out: Output image

function [ img_out ] = img_compress( img,img_name, level )
% Converting to double precision for better processing
img = im2double( img ); % Size of image 1

% Extract size of images for equalization of image size
% m and n denote the rows and columns
[M N ~] = size( img );

img_pyramid = pyramid( img, level );

% Temporary pyramid to store the img_pyramid
pyramid_decompress = cell( 1, level );

for i = 1:level
    pyramid_decompress{i} = img_pyramid{i} ;
end

% Refer Paper: bandpass pyramid is generated in the following loop
% using the expression Gi = Li + EXPAND[i+1].
for i = length( img_pyramid )-1:-1:1
 	img_pyramid{i} = img_pyramid{i}+img_expand( img_pyramid{i+1} );
end
img_samples(img_name, img_pyramid, level);
img_out = img_pyramid{1};
img_out = imresize(img_out,[M N]);
img_out = img_out.*255;

return ;
end