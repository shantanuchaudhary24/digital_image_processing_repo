
% This function generates a lapcian pyramid
% img: input image
% level: parameter for pyramid height

function [output_pyramid] = pyramid(img, level)

    % Create an array of size level that represents the pyramid
    % structure.
    output_pyramid = cell(level);

    % Lowest level of pyramid contains the image (uncompressed)
    output_pyramid{1} = im2double(img);

	% Gaussian Pyramid formed here.
    % Reduce successive image levels by a factor of 2
    for i=2:level
        output_pyramid{i} = img_reduce(output_pyramid{i-1});
    end
    
    % Adjust the image size
    for i = level-1:-1:1 
        size_level = size(output_pyramid{i+1})*2-1;
        output_pyramid{i} = output_pyramid{i}(1:size_level(1),1:size_level(2),:);
    end

    % Pyramid Reconstruction
    for i = 1:level-1
        output_pyramid{i} = output_pyramid{i}-img_expand(output_pyramid{i+1});
    end
    
return;
end
