% interpolate_morph
%
%  Helper function that performs the actual transformation for the warping.
%

function [ output ] = interpolate_morph( cy, cx, k, I, dest_height, dest_width )

[height width channels] = size( I );
output = zeros( dest_height, dest_width, channels );

N = size(cx,1);

% For each pixel in the final image...
for j=1:dest_height
    for i=1:dest_width
        % Do we have to scale?
        y = j / height;
        x = i / width;
        
		% Run the RBF on it.
        npos = [0 0];
        for n=1:N
            s = norm( [x y] - [cy(n) cx(n)] );
            if ( s ~= 0 ) 
                kern = s * s * log(s);
            else
                kern = 0;
            end
            %kern = kernel( s );
            
            npos(1) = npos(1) + k(n) * kern;
            npos(2) = npos(2) + k(n+N+3) * kern;
        end
        
        % Add in the linear portion...
        npos(1) = npos(1) + k(N+1) * x + k(N+2) * y + k(N+3);
        npos(2) = npos(2) + k(N+N+4) * x + k(N+N+5) * y + k(N+N+6);
        
        fpos = [(npos(1) * height) (npos(2) * width)];
        
        if ( fpos(1) > (height - 1) || fpos(1) < 2 || fpos(2) > (width - 1) || fpos(2) < 2 )
            continue;
        else
			% Perform linear interpolation.
            tx = fpos(2) - floor(fpos(2));
            ty = fpos(1) - floor(fpos(1));

            yval = [floor(fpos(1)) ceil(fpos(1))];
            xval = [floor(fpos(2)) ceil(fpos(2))];

            v1 = I(yval(1), xval(1), :) * (1 - tx) + I(yval(1), xval(2), :) * tx;
            v2 = I(yval(2), xval(1), :) * (1 - tx) + I(yval(2), xval(2), :) * tx;
            output(j, i, :) = v1 * (1 - ty) + v2 * ty;
        end
    end
end

% Scale it back down for visualization.
output = ( (output) / (max(max(max(output)))) );

end

