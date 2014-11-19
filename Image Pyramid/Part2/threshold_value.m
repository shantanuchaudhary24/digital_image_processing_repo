
% This function generates threshold
% img: input image
% level: parameter for pyramid height

function [output_value] = threshold_value(img, alpha)
[M N O] = size(img);
value = 0;
for i=1:M
    for j=1:N
        for k=1:O
          value= value + img{i}{j}{k};  
        end
    end
end

output_value = value/(M*N*O);
output_value = alpha*output_value;
end