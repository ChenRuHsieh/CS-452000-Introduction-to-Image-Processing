clc;
clear all;
close all;
input = imread('Fig0526(a)(original_DIP).tif'); % Ū���D�عϤ�
subplot(2,3,1);imshow(input);title('Input');
input = im2single(input);
imwrite(im2uint8(input),'input.tif');
input_shift = fshift(input);
input_f = fft2(input_shift);
a = 0.1; b = 0.1; T = 1;
% ��motion blur
[blurred, H] = addMotionBlur(input_f, T, a, b);
subplot(2,3,2);imshow(fshift(ifft2(blurred)));title('Blurred');
imwrite(im2uint8(fshift(ifft2(blurred))),'blurred.tif');
% �����T�B�z
A = 0.1; u0 = 20; v0 = 20; 
blurredAddNoise = addSinNoise(fshift(ifft2(blurred)), A, u0, v0); % �o��[�W���T�᪺spatial
subplot(2,3,3);imshow(blurredAddNoise);title('blurredAddNoise');
imwrite(im2uint8(blurredAddNoise),'blurredAddNoise.tif');

K = [0.1, 0.000001, 10^-12]; % �T�ؤ��P��K
PSNR = zeros(1,3,'double'); % ���Ӧs�T��K�o�쪺PSNR
for i = 1 : 3
    % ��wienerFiltering�B�z
    blurredAddNoise_DFT = fft2(fshift(blurredAddNoise));
    AfterWFilter = wienerFiltering(blurredAddNoise_DFT, H, K(i));
    AfterWFilter = fshift(ifft2(AfterWFilter)); % �N���G��^sptial
    subplot(2,3,i+3);imshow(AfterWFilter);
    switch i
        case 1
            title('AfterWFilter, K = 0.1');
            imwrite(im2uint8(AfterWFilter),'AfterWFilter K = 0.1.tif');
        case 2
            title('AfterWFilter, K = 10^-6');
            imwrite(im2uint8(AfterWFilter),'AfterWFilter K = 10^-6.tif');
        case 3
            title('AfterWFilter, K = 10^-12');
            imwrite(im2uint8(AfterWFilter),'AfterWFilter K = 10^-12.tif');
    end
    %PSNR
    PSNR(i) = computePSNR(input, AfterWFilter);
end

for i = 1 : 3
    fprintf('Wiener Filtering with K = %f, PSNR = %f\n', K(i), PSNR(i));
end
    
