clear all;
close all;
addpath('./Inpainting');

% Arguments
% ===================
filename = 'couple';
fileformat = '.jpg';
patch_size = 15;
% ===================

filepath = strcat('.\samples\', filename, fileformat);
im = im2single(imread(filepath));

figure(3), hold off, imagesc(im)
[x, y] = ginput 
target_mask = poly2mask(x, y, size(im, 1), size(im, 2)); 

inpainted_img = hole_filling_crimnisi(im, target_mask, patch_size, 0.01, filename);
filepath = strcat('.\results\', filename,'_inpainted', fileformat);
imwrite(inpainted_img , filepath);