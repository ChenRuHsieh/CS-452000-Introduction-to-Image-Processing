clc;
clear all;
close all;
input = imread('Fig0457(a)(thumb_print).tif'); % 讀取題目圖片
input = imresize(input, 1/10); % 縮小10倍
figure;imshow(input);title('Origin的1/10');
input = im2single(input);
[M,N] = size(input);

edge = 128;
inputZeroPad = padarray(input,[edge-M edge-N],0,'post');
figure;imshow(inputZeroPad);title('Zero Padding');
imwrite(inputZeroPad,'Zero Padding.png');
input_shift = fshift(inputZeroPad); % 做(-1)處理

D0 = 6; % 因為圖片有縮小，也對D0做縮小
MyGHPF = myGHPF(D0,edge,edge);

outputDFT = fft2(input_shift);
figure;imshow(outputDFT);title('fft2');
imwrite(outputDFT,'fft2.png');

G = outputDFT .* MyGHPF;
GIDFT = real(ifft2(G));
figure;imshow(GIDFT);title('ifft2');
imwrite(GIDFT,'ifft2.png');

GIDFT = fshift(GIDFT); %做(-1)處理
figure;imshow(GIDFT);title('After GHPH');
imwrite(GIDFT,'matlab After GHPH.png');
%去除Padding
GIDFT = GIDFT(1:M,1:N);


thresholding = 0;
GIDFT_th = zeros(M,N,'single');
for x = 1 : M
    for y = 1 : N
        if GIDFT(x,y) < 0
            GIDFT_th(x,y) = 0;
        else
            GIDFT_th(x,y) = 1;
        end
    end
end
figure;imshow(GIDFT_th);title('After Thresholding');
imwrite(im2uint8(GIDFT_th),'matlab After Thresholding.tif');
%}