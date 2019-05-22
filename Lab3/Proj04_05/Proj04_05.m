clc;
clear all;
close all;
input = imread('Fig0457(a)(thumb_print).tif'); % 讀取題目圖片
input = imresize(input, 1/10); % 縮小10倍
input = im2single(input);
subplot(1,4,1);imshow(input);title('Origin的1/10');
imwrite(im2uint8(input),'input.tif');
[M,N] = size(input);
% Zero Padding到正方形

edge = 2^(fix(log2(max(M,N)))+1) % 尋找最接近的2次方，當作padding後的邊常
inputZeroPad = padarray(input,[edge-M edge-N],0,'post');
subplot(1,4,2);imshow(inputZeroPad);title('Zero Padding');
imwrite(im2uint8(inputZeroPad),'Zero Padding.tif');

D0 = 20; 
MyGHPF = myGHPF(D0,edge,edge); % 產生filter
input_shift = fshift(inputZeroPad); % 做shift處理
outputDFT = myDFT2(input_shift); % DFT
G = outputDFT .* MyGHPF;% 做filter處理
tic
GIDFT = real(myIDFT2(G));% 做IDFT，取實數來顯示圖片
toc
GIDFT = fshift(GIDFT); %做shift處理
GIDFT = GIDFT(1:M,1:N);%去除Padding
subplot(1,4,3);imshow(GIDFT);title('result');
imwrite(im2uint8(GIDFT),'result.tif');

thresholding = 0; % 以0為界
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
subplot(1,4,4);imshow(GIDFT_th);title('result After Thresholding');
imwrite(im2uint8(GIDFT_th),'result After Thresholding.tif');
