clc;
clear all;
close all;
input = imread('Fig0431(d)(blown_ic_crop).tif'); % 讀取題目圖片
input = imresize(input, 128/1026); % 縮小成128x128
input = im2single(input);
subplot(3,3,1);imshow(input);title('Origin 128x128');
imwrite(im2uint8(input),'Origin 128x128.tif');
[M,N] = size(input);

% 原圖做Zeropadding
inputZeroPad = padarray(input,[M N],0,'post');
subplot(3,3,2);imshow(inputZeroPad);title('Zero Padding');
imwrite(im2uint8(inputZeroPad),'Zero Padding.tif');

%做shift處理
[P, Q] = size(inputZeroPad);
inputZeroPadShift = fshift(inputZeroPad);
subplot(3,3,3);imshow(inputZeroPadShift);title('Zero Padding After shift');
imwrite(im2uint8(inputZeroPadShift),'Zero Padding_after shift.tif');

%IZP(-1) DFT
tic
izpsDFT = myDFT2(inputZeroPadShift);
subplot(3,3,4);imshow(izpsDFT);title('Zero Padding Shift DFT');
imwrite(im2uint8(izpsDFT),'Zero Padding shift DFT.tif');
fprintf('IZPS的 DFT 結束');
toc

%IZP DFT(-1)的Spectrum
tic
izpsDFTSp = abs(izpsDFT);
c = 1 / log(1 +range(izpsDFTSp(:))) % c = 1/log後的全距
izpsDFTSp = c * log(1+izpsDFTSp); % 原圖過白，取log讓暗區放大，並做縮放讓Range維持在0~1
subplot(3,3,5);imshow(izpsDFTSp);title('Zero Padding DFT Shift Spectrum');
imwrite(im2uint8(izpsDFTSp),'Zero Padding DFT Spectrum_128x128.tif');
fprintf('IZPS DFT的Spectrum 結束');
toc
% H = GLPH
tic
D0 = 10;
GLPH = myGLPF(D0,P,Q);
subplot(3,3,6);imshow(GLPH);title('MyGLPH');
imwrite(im2uint8(GLPH),'MyGLPH.tif');
fprintf('GLPH 結束');
toc
% G = H * F
tic
G = GLPH .* izpsDFT;
GSpectrum = abs(G);
subplot(3,3,7);imshow(GSpectrum);title('G Spectrum');
imwrite(im2uint8(GSpectrum),'GSpectrum.tif');
fprintf('H * F 結束');
toc
% IDFT
tic
GIDFT = real(myIDFT2(G));
GIDFT = fshift(GIDFT); %做shift處理
subplot(3,3,8);imshow(GIDFT);title('G IDFT');
imwrite(im2uint8(GIDFT),'G IDFT.tif');
fprintf('G IDFT 結束');
toc
% 去除padding
tic
result = GIDFT(1:M,1:N);
subplot(3,3,9);imshow(result);title('delete padding');
imwrite(im2uint8(result),'result.tif');
fprintf('去除padding結束');
toc