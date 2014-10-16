

% Shantanu Chaudhary, Indian Institute of Technology, Delhi, August 2014.
% shantanuchaudhary24@gmail.com, cs5100295@cse.iitd.ac.in

% This function takes in two images image1 and image2 and then returnes the
% translation which has happened to the first image to obtain the second
% image.

% image1: Original Image
% image2: Transformed Image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [ X,Y ] = phaseCorrelation( image1,image2 )

X_Size = size(image1,1);
Y_Size = size(image1,2);

X_Size_prime = size(image2,1);
Y_Size_prime = size(image2,2);

% disp(X_Size);
% disp(Y_Size);
error('');

%  fft_image1 = fftshift(fft2(image1)); %taking fourier transform of image 1.
%  fft_image2 = fftshift(fft2(image2)); % taking fourier transform of image 2.

fft_image1 = fft2(image1); %taking fourier transform of image 1.
fft_image2 = fft2(image2); % taking fourier transform of image 2.


% GP_fft_image1 = highpass_filter(X_Size,Y_Size).*abs(fft_image1);
% GP_fft_image2 = highpass_filter(X_Size,Y_Size).*abs(fft_image2);


phaseCorr = (fft_image2.*conj(fft_image1))./(abs(fft_image2.*fft_image1)); % using the phase correlation formula from the research paper.
% phaseCorr = (GP_fft_image1.*conj(fft_image1))./(abs(GP_fft_image2.*fft_image1)); 

phaseCorr_ift = ifft2(phaseCorr); % taking the inverse fourier transform of the phase correlation values.

% the index where phaseCorr_ift is maximum will give us the translation

gr = phaseCorr_ift(1,1);
indX = 0;
indY = 0;
for i=1:size(phaseCorr_ift,1)
    for j=1:size(phaseCorr_ift,2)
        if(phaseCorr_ift(i,j)>gr) % finding the index of the maximum value.
            gr = phaseCorr_ift(i,j);
            indY = i-1;
            indX = j-1;
        end
    end
end

if indX > size(phaseCorr_ift,2)/2 % for negative translations
    indX = indX - size(phaseCorr_ift,2);
end
    

if indY > size(phaseCorr_ift,1)/2 % for negative translations
    indY = indY - size(phaseCorr_ift,1);
end

X = indX;
Y = indY;

end

