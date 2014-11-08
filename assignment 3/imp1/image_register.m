
% Image Registration using FFT 
% img1          :   Reference Image
% img2          :   Target Image
% Shantanu Chaudhary, Indian Institute of Technology, Delhi, October 2014.
% shantanuchaudhary24@gmail.com, cs5100295@cse.iitd.ac.in


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image Registration function

function [] = image_register(img1, img2)

    % Convert both images to FFT, centering on zero frequency component
    
    X_Size = size(img1, 1);
    Y_Size = size(img1, 2);
    
    FFT1 = fftshift(fft2(img1));
    FFT2 = fftshift(fft2(img2));
        
% Convolve the magnitude of the FFT with a high pass filter
    
    IA = hipass_filter(X_Size,Y_Size).*abs(FFT1);  
    IB = hipass_filter(X_Size,Y_Size).*abs(FFT2);  
        
    % Transform the high passed FFT phase to Log Polar space
    
    L1 = transformImage(IA, X_Size, Y_Size, X_Size, Y_Size, size(IA) / 2 );
    L2 = transformImage(IB, X_Size, Y_Size, X_Size, Y_Size, size(IB) / 2 );
    
    % Convert log polar magnitude spectrum to FFT
    
    THETA_F1 = fft2(L1);
    THETA_F2 = fft2(L2);
    
    % Compute cross power spectrum of F1 and F2
    
    a1 = angle(THETA_F1);
    a2 = angle(THETA_F2);

    THETA_CROSS = exp(i * (a1 - a2));
    THETA_PHASE = real(ifft2(THETA_CROSS));
    
    % Find the peak of the phase correlation

    THETA_SORTED = sort(THETA_PHASE(:));  % TODO speed-up, we surely don't need to sort
    
    SI = length(THETA_SORTED):-1:(length(THETA_SORTED));

    [THETA_X, THETA_Y] = find(THETA_PHASE == THETA_SORTED(SI));
    
    % Compute angle of rotation
    
    DPP = 360 / size(THETA_PHASE, 2);

    Theta = DPP * (THETA_Y - 1);
    
    fprintf('The angle of rotation is %f\n', Theta);
    % Output (Theta)
    
    % Rotate image back by theta and theta + 180
    
    R1 = imrotate(img2, -Theta, 'nearest', 'crop');  
    R2 = imrotate(img2,-(Theta + 180), 'nearest', 'crop');
    
    % Output (R1, R2)
    
    % Take FFT of R1
     
    R1_F2 = fftshift(fft2(R1));
     
    % Compute cross power spectrum of R1_F2 and F2
    
    a1 = angle(FFT1);
    a2 = angle(R1_F2);

    R1_F2_CROSS = exp(i * (a1 - a2));
    R1_F2_PHASE = real(ifft2(R1_F2_CROSS));

    % Take FFT of R2
     
    R2_F2 = fftshift(fft2(R2));
    
    % Compute cross power spectrum of R2_F2 and F2
    
    a1 = angle(FFT1);
    a2 = angle(R2_F2);

    R2_F2_CROSS = exp(i * (a1 - a2));
    R2_F2_PHASE = real(ifft2(R2_F2_CROSS));

    % Decide whether to flip 180 or -180 depending on which was the closest

    MAX_R1_F2 = max(max(R1_F2_PHASE));
    MAX_R2_F2 = max(max(R2_F2_PHASE));
    
    if (MAX_R1_F2 > MAX_R2_F2)
        
        [y, x] = find(R1_F2_PHASE == max(max(R1_F2_PHASE)));
        
        R = R1;
        
    else
        
        [y, x] = find(R2_F2_PHASE == max(max(R2_F2_PHASE)));
        
        if (Theta < 180)
            Theta = Theta + 180;
        else
            Theta = Theta - 180;
        end
        
        R = R2;
    end
    
    % Output (R, x, y)
    
    % Ensure correct translation by taking from correct edge
    
    Tx = x - 1;
    Ty = y - 1;
    
    if (x > (size(img1, 1) / 2))
        Tx = Tx - size(img1, 1);
    end
    
    if (y > (size(img1, 2) / 2))
        Ty = Ty - size(img1, 2);
    end
       
    % Output (Sx, Sy)
    fprintf('The translation in x and y is %f, %f\n', Tx,Ty);