% Image Morphing Function
%
%   moving_img    : Source Image 
%   fixed_img     : Destination Image
%   moving_points : Control Points in src image
%   base_points   : Control Points in destination image
% 
% 
function morph( moving_pts, base_pts, inputNames, outputName, steps)

% Find the values of the weights.
[N M] = size( moving_pts ); % Number of control points

images = [];
maxSz = [0 0 0];
for m=1:M
    Isz = size( imread( inputNames(m,:) ) );
    if ( length(Isz) < 3 )
        Isz = [Isz 0];
    end
    maxSz = max(Isz, maxSz);
end

% Load in images, pad with zeros.
for m=1:M
    image = imread( inputNames(m,:) );
    sz = size( image );
    if ( length(sz) < 3 )
        sz = [sz 0];
    end
    Isz = maxSz - sz;
    images(:,:,:,m) = padarray(image, [max(Isz(1), 0) max(Isz(2), 0)], 'post');
end

[height width channel num] = size(images);

% Scale down to 0.0 - 1.0 range
base_pts = base_pts / height;
moving_pts = moving_pts / width;

% Create an interpolated x and y
step = 1/(steps + 1);
currentStep = 1;
tic;
for n=1:num
    for m=n+1:num
        x1 = moving_pts(:,n);
        y1 = moving_pts(:,m);
        
        x2 = base_pts(:,n);
        y2 = base_pts(:,m);
        
        for t=step:step:0.99
			% Interpolate control points.
            yt = (1 - t) * y1 + t * y2;
            xt = (1 - t) * x1 + t * x2;

			% Calculate weights
            k1 = calculate_rbf_weights( yt, xt, y1, x1);
            k2 = calculate_rbf_weights( yt, xt, y2, x2);

			% Generate new morphed images
            [dh dw c] = size( images(:,:,:,n) );
            I1 = interpolate_morph( yt, xt, k1, images(:,:,:,n), dh, dw );

            [dh dw c] = size( images(:,:,:,m) );
            I2 = interpolate_morph( yt, xt, k2, images(:,:,:,m), dh, dw );

			% Interpolate images and write.
            If = (1 - t) * I1 + t * I2;

            str = sprintf('morphed_images/%d_of_%d_%s.png', currentStep, steps, outputName);
            imwrite(If, str, 'png');
            fprintf('Completed %d of %d image:\n',currentStep,steps);
            currentStep = currentStep + 1;
        end
    end
end
toc
end

