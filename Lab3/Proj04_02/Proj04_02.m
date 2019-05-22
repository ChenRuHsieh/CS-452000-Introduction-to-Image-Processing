clc;
clear all;
close all;
input = imread('Fig0441(a)(characters_test_pattern).tif'); % 讀取題目圖片
input = im2single(input);
input = imresize(input, 128/688); % 縮小成128x128
subplot(1,2,1);imshow(input);title('Origin Pro04_02 256');
imwrite(im2uint8(input),'input.tif');
[row,col] = size(input);
% DFT
DFTspectrum = abs(myDFT2(input));
subplot(1,2,2);imshow(DFTspectrum);title('DFT Spectrum 128x128');
imwrite(im2uint8(DFTspectrum),'DFT Spectrum 128.tif');
% Average
averageFromDFT = DFTspectrum(1,1) / (row*col)
averageFromOrigin = sum(sum(input)) / (row*col)