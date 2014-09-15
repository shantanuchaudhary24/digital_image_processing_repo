% This function prints the image pyramid
% img: Name of the image file (string)
% img_pyramid: Image to be reduced
% level: Level upto which pyramid is to be constructed.

function [ ] = img_samples( img, img_pyramid, level )

    for i=1:level
        img_out = img_pyramid{i};
        img_out = img_out.*255;
        file = strcat('images/samples/',img,'_sample',int2str(i),'.png');
        imwrite(uint8(img_out), file);
    end
end