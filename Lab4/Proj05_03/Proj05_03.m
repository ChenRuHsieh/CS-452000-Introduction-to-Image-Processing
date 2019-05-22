clc;
clear all;
close all;
input = imread('Fig0526(a)(original_DIP).tif'); % 讀取題目圖片
subplot(2,3,1);imshow(input);title('Input');
input = im2single(input);
imwrite(im2uint8(input),'input.tif');
[M,N] = size(input);
% 做雜訊處理
u0 = 100; v0 = 100; % 找出原圖的正中央
A = 0.5;
addNoise = addSinNoise(input, A, u0, v0);
subplot(2,3,2);imshow(addNoise);title('AddNoise');
imwrite(im2uint8(addNoise),'AddNoise.tif');
% 轉到frequency domain
addNoise_shift = fshift(addNoise); % 做shift處理
addNoiseDFT = fft2(addNoise_shift);
subplot(2,3,3);imshow(log(abs(addNoiseDFT))/10);title('addNoiseDFT');
imwrite(im2uint8(log(abs(addNoiseDFT))/10),'addNoiseDFT.tif');
% NotchFilter
D0 = 20;
[AfterFilterDFT,NotchFilter] = notchFiltering(addNoiseDFT, D0, u0, v0);
subplot(2,3,4);imshow(abs(NotchFilter));title('NotchFilter');
imwrite(im2uint8(abs(NotchFilter)),'NotchFilter.tif');
% 經過filter後的frequency domain
subplot(2,3,5);imshow(log(abs(AfterFilterDFT))/10);title('AfterFilterDFT');
imwrite(im2uint8(log(abs(AfterFilterDFT))/10),'AfterFilterDFT.tif');
% 顯示經過filter後的sptial domaina
AfterFilter = fshift(ifft2(AfterFilterDFT)); % IDFT後，做shift處理
subplot(2,3,6);imshow(AfterFilter);title('AfterFilter');
imwrite(im2uint8(AfterFilter),'AfterFilter.tif');
% PSNR
PSNR = computePSNR(input, AfterFilter)
% 顯示Spectrum
%{
%addNoiseDFT_sepc = abs(addNoiseDFT) - abs(fft2(fshift(input)));

%addNoiseDFT_sepc = abs(addNoiseDFT);
c = 1 / log(1 +range(addNoiseDFT(:))); % c = 1/log後的全距
addNoiseDFT_sepc = log(1+addNoiseDFT_sepc)*c; % 原圖過白，取log讓暗區放大，並做縮放讓Range維持在0~1
subplot(2,3,4);imshow(addNoiseDFT_sepc);title('addNoiseDFT_sepc');
imwrite(im2uint8(addNoiseDFT_sepc),'addNoiseDFT_sepc.tif');
%}


