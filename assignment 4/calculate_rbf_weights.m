% calculate_rbf_weights
%
%  Calculates the weights for the rbf matrix.  Just uses matlabs built in matrix inverter.
%

function k = calculate_rbf_weights( y, x, y_prime, x_prime )

N = size( x, 1 );

% Radial basis function (part)
B = zeros(N);
for i=1:N
    for j=1:N
        s = norm( [y(j) x(j)] - [y(i) x(i)] );
        %B(j, i) = kernel(s);
        if ( s ~= 0 ) 
            B(j, i) = s * s * log(s);
        else
            B(j, i) = 0;
        end
    end
end

% Linear portion.
top = [y' 0 0 0; x' 0 0 0; ones(N,1)' 0 0 0];
right(:,1) = x;
right(:,2) = y;
right(:,3) = ones(N,1);

B = [top; B right];

% Solve the linear equation.
bi = [0; 0; 0; y_prime; 0; 0; 0; x_prime];

k = ([B zeros(N+3); zeros(N+3) B] ^ -1) * bi;

end

