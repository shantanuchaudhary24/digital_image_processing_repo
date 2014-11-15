function [ output ] = thin_plate_spline( s )

if ( s ~= 0 ) 
    output = s * s * log(s);
else
    output = 0;
end

end

