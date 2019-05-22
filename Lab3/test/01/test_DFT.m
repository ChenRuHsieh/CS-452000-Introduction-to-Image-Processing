clc;
clear all;
close all;

input = imread('Fig0431(d)(blown_ic_crop).tif');
input = im2single(input);
[row,col] = size(input);

for x = 1 : row
    for y = 1 : col
        input(x,y) = input(x,y) * (-1)^(x+y);
    end
end
%input = input / (Max-Min);
%imshow(input);
outputFFT = fft2(input);
c = 1 / log(1 +range(outputFFT(:))); % c = 1/log«áªº¥þ¶Z
outputFFT = c * log(1+outputFFT);
imshow(outputFFT)
outputIFFT = ifft2(outputFFT);
%{
DFTspectrum = abs(myDFT2(input));
averageFromDFT = DFTspectrum(1,1) / (row*col)
averageFromOrigin = sum(sum(input)) / (row*col)
%}