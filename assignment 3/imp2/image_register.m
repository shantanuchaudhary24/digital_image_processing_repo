
% Shantanu Chaudhary, Indian Institute of Technology, Delhi, August 2014.
% shantanuchaudhary24@gmail.com, cs5100295@cse.iitd.ac.in

% This function takes in two images image1 and image2 and then returnes the
% translation which has happened to the first image to obtain the second
% image.

% image: Sample Image
% type: Test Case Type (rotate/translate)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ] = image_register( image, type )

figure, imshow(image);

% [x',y',1] = [x,y,1]*A (This is how the affine transformation matrix multiplication is)

if strcmp(type,'translate')
    
    % translate 
    Transform = maketform('affine',[1,0,0;0 1 0;-50 -80 1]); 

    % required for showing translation
    image_transformed = imtransform(image,Transform,'XData',[1,size(image,2)],'YData',[1,size(image,1)]); 

%     figure, imshow(image_transformed);
    
    [indX,indY] = phaseCorrelation(image,image_transformed);
    fprintf('The translations are (%d,%d) along x-axis and y-axis respectively.\n',indX,indY);

else
    
    % rotated and translate accordingly
    Transform = maketform('affine',[0,-1,0;1 0 0;0 0 1]);
    % GP_fft_image1 = highpass_filter(X_Size,Y_Size).*abs(fft_image1);
    % GP_fft_image2 = highpass_filter(X_Size,Y_Size).*abs(fft_image2);

    image_transform = imtransform(image,Transform,'XData',[1,size(image,2)],'YData',[1,size(image,1)]); % required for showing translation
    
%     img_transform = imtransform(image,Transform);

    img_transform = imread('images/s1_rotated.bmp');
%   figure, imshow(image_transform);

    figure, imshow(img_transform);

    fft_image = fft2(image); % taking the fourier transform of image 1.
    fft_img_transform = fft2(img_transform); % taking the fourier transform of image 2.

    log_img = log(abs(fft_image));
    log_img_transform = log(abs(fft_img_transform)); % Now these are my two images which need to be converted to polar coordinates and then send to the phasecorr function

    log_polar_img = imgpolarcoord(log_img); % Transform into polar coordinates system
    log_polar_img_tranform = imgpolarcoord(log_img_transform); % P(radius,degree)

    [theta,rho] = phaseCorrelation(log_polar_img,log_polar_img_tranform); % find the rotated theta.

    fprintf('The rotation is %d degrees.\n',theta);

    image_transform = imrotate(image_transform,-theta); % applying the inverse angle rotation on the transformed image.
    
%     figure,imshow(image_transform);
    
    % now find the respective translation
%     [indX,indY] = phaseCorrelation(image,image_transform);
    
end

