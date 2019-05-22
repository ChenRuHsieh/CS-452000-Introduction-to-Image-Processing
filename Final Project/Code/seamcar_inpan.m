clear all;
close all;

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

imwrite(~target_mask , './samples/mask.jpg');

% please modify the python code
system('python main.py');

% load the bgd image
im_bgd = im2single(imread('./results/obj_removed.jpg'));
% Inpaint the hold through generated background
figure(3), hold off, imagesc(im)
[x, y] = ginput 
target_mask = poly2mask(x, y, size(im, 1), size(im, 2)); 
inpainted_img = hole_filling_crimnisi_with_background(im, target_mask, patch_size, 0.01, filename, im_bgd);
filepath = strcat('.\results\', filename,'_inpainted', fileformat);
imwrite(inpainted_img , filepath);



