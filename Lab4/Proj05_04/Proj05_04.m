clc;
clear all;
close all;
input = imread('Fig0526(a)(original_DIP).tif'); % 讀取題目圖片
subplot(2,3,1);imshow(input);title('Input');
input = im2single(input);
imwrite(im2uint8(input),'input.tif');
input_shift = fshift(input);
input_f = fft2(input_shift);
a = 0.1; b = 0.1; T = 1;
% 做motion blur
[blurred, H] = addMotionBlur(input_f, T, a, b);
subplot(2,3,2);imshow(fshift(ifft2(blurred)));title('Blurred');
imwrite(im2uint8(fshift(ifft2(blurred))),'blurred.tif');
% 做雜訊處理
A = 0.1; u0 = 20; v0 = 20; 
blurredAddNoise = addSinNoise(fshift(ifft2(blurred)), A, u0, v0); % 得到加上雜訊後的spatial
subplot(2,3,3);imshow(blurredAddNoise);title('blurredAddNoise');
imwrite(im2uint8(blurredAddNoise),'blurredAddNoise.tif');

K = [0.1, 0.000001, 10^-12]; % 三種不同的K
PSNR = zeros(1,3,'double'); % 拿來存三種K得到的PSNR
for i = 1 : 3
    % 做wienerFiltering處理
    blurredAddNoise_DFT = fft2(fshift(blurredAddNoise));
    AfterWFilter = wienerFiltering(blurredAddNoise_DFT, H, K(i));
    AfterWFilter = fshift(ifft2(AfterWFilter)); % 將結果轉回sptial
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
    
