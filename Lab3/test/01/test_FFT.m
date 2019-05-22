clc;
clear all;
close all;
input = imread('Fig0431(d)(blown_ic_crop).tif'); % Ū���D�عϤ�
input = im2single(input);
subplot(2,4,1);imshow(input);title('Origin');
[row,col] = size(input);

% Zero Padding
newR = 2^(fix(log2(row))+1);
newC = 2^(fix(log2(col))+1);
inputZeroPad = padarray(input,[row col],0,'post');
% ��ϰ�Zeropadding


%��(-1)�B�z
inputZeroPad = fshift(inputZeroPad);

% IZP FFT
zeroPadFFT = fft2(inputZeroPad);
subplot(2,4,3);imshow(zeroPadFFT);title('DFT');

% FFT Spectrum
zeroPadFFT_SP = abs(zeroPadFFT);
c = 1 / log(1 +range(zeroPadFFT_SP(:))) % c = 1/log�᪺���Z
zeroPadFFT_SP = c * log(1+zeroPadFFT_SP);
figure;imshow(zeroPadFFT_SP);title('Zero Padding FFT Spectrum');
imwrite(uint8(zeroPadFFT_SP),'Zero Padding FFT Spectrum 1026x1026.tif');

