%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script tests your implementation of seamCarving function, and you can 
% also use it for resizing your own images.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clear all
clear; close all; clc;

%% Load data
image = imread('data/sea.jpg');
sz = size(image);
% resize image to half size
image = imresize(image, [floor(sz(1)/3), floor(sz(2)/3)]);
sz = size(image);
figure
imshow(image)
imwrite(image, 'results/image.jpg')
title('image')

%% Image resizing
% apply seam carving
tic
[image_seamCarving, Mask, energy] = seamCarving(double(image), [sz(1), floor(sz(2)/2)]);
%Mask =+Mask;
ImageMask = image;
for i = 1:size(Mask,1)
    for j = 1:size(Mask,2)
        if (Mask(i,j)==0)
            ImageMask(i,j,1) = 0;
            ImageMask(i,j,2) = 0;
            ImageMask(i,j,3) = 0;
        end
    end
end
figure
imshow(ImageMask)
imwrite(ImageMask, 'results/mask.jpg')
title('Mask')
figure
imshow(uint8(energy))
imwrite(energy, 'results/energy.jpg')
title('energy')
figure
imshow(uint8(image_seamCarving))
imwrite(image_seamCarving, 'results/seamcarving.jpg')
title('image seamCarving')
toc
% apply scaling 
image_scaling_width = imresize(image, [sz(1), floor(sz(2)/2)]);
figure
imshow(image_scaling_width)
imwrite(image_scaling_width, 'image_scaling_width.jpg')
title('image scaling width')
% apply cropping 
image_crop_width = imcrop(image, [1, 1, floor(sz(2)/2), sz(1)]);
figure
imshow(image_crop_width)
imwrite(image_crop_width, 'image_crop_width.jpg')
title('image crop width')
