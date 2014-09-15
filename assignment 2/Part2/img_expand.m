% This function reduces the scale of image
% img: Image to be reduced
% img_out: Output image
% If size of img is MxN then size of img_out is
% Int(2*M-1)xInt(2*N-1) where Int value is greatest integer
% value. This function is basically an implementation of matlab
% impyramid function (with expand option).
% http://www.mathworks.in/help/images/ref/impyramid.html.

function [ img_out ] = img_expand( img )

    kernel_width = 5; % default kernel width
    % Kernel Center weight (Refer http://www.mathworks.in/help/images/ref/impyramid.html)
    % The following value of a gives it a gaussian shape
    a = 0.375; 
    
    % Kernel Vector    
    kernel_prime = [((1/4)-(a/2)) 1/4 a 1/4 ((1/4)-(a/2))];
    
     % Kernel for filter is obtained by taking a kronecker tensor product  
    kernel = kron(kernel_prime,kernel_prime')*4;

    % expand to [ker00 ker01;ker10 ker11] with 4 kernels used for interpolation
    ker00 = kernel(1:2:kernel_width,1:2:kernel_width); 
    ker01 = kernel(1:2:kernel_width,2:2:kernel_width); 
    ker10 = kernel(2:2:kernel_width,1:2:kernel_width); 
    ker11 = kernel(2:2:kernel_width,2:2:kernel_width); 

    img = im2double(img);
    img_sz = size(img(:,:,1));
    
    % Expanding size to accomodate expanded image
    img_size = img_sz*2-1;
    
    % Initiliazing size and values of output_img with zero values
    img_out = zeros(img_size(1),img_size(2),size(img,3));

	% The main loop for interpolation and expansion
    for i = 1:size(img,3) % Iterate over all color components (if any)
        img1 = img(:,:,i);
        
        % Pad the image array
        img1ph = padarray(img1,[0 1],'replicate','both'); % horizontally padded
        img1pv = padarray(img1,[1 0],'replicate','both'); % horizontally padded

        img00 = imfilter(img1,ker00,'replicate','same');
        img01 = conv2(img1pv,ker01,'valid');
        img10 = conv2(img1ph,ker10,'valid');
        img11 = conv2(img1,ker11,'valid');

		% Interpolate and expand
        img_out(1:2:img_size(1),1:2:img_size(2),i) = img00;
        img_out(2:2:img_size(1),1:2:img_size(2),i) = img10;
        img_out(1:2:img_size(1),2:2:img_size(2),i) = img01;
        img_out(2:2:img_size(1),2:2:img_size(2),i) = img11;
    end

end
