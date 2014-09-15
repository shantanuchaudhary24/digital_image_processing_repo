
% This function reduces the scale of image
% img: Image to be reduced
% img_out: Output image
% If size of img is MxN then size of img_out is
% Int(M/2)xInt(N/2) where Int value is greatest integer
% value. This function is basically an implementation of matlab
% impyramid function (with reduce option).
% http://www.mathworks.in/help/images/ref/impyramid.html.

function [ img_out ] = img_reduce( img )

    % kernelWidth = 5; % default
    % Kernel Center weight (Refer http://www.mathworks.in/help/images/ref/impyramid.html)
    % The following value of a gives it a gaussian shape
    a = 0.375; 
    
    % Kernel Vector   
    kernel_prime = [((1/4)-(a/2)) 1/4 a 1/4 ((1/4)-(a/2))];
    
    % Kernel for filter is obtained by taking a kronecker tensor product 
    % Generating Kernel
    kernel = kron(kernel_prime,kernel_prime');

    % Taking double precision of the image vector.
    img_size = size(img);

    % Max size of img_out is equal to the input image size. Size check (Initialization) !
    img_out = zeros(0);

    % Instead of seprarating into YUP space, we filter each component
    for i = 1:size(img,3)   % Iterate over all color components (if any)
        
        % Apply filter component by component
        img1 = img(:,:,i);

        % Apply filter with kernel to img1, retain size of img1 and replicate
        imgFiltered = imfilter(img1,kernel,'replicate','same');
        
        % Set values to output image
        img_out(:,:,i) = imgFiltered(1:2:img_size(1),1:2:img_size(2));
    end

end