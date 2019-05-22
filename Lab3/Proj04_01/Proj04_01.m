clc;
clear all;
close all;
input = imread('Fig0431(d)(blown_ic_crop).tif'); % Ū���D�عϤ�
input = imresize(input, 128/1026); % �Y�p��128x128
input = im2single(input);
subplot(3,3,1);imshow(input);title('Origin 128x128');
imwrite(im2uint8(input),'Origin 128x128.tif');
[M,N] = size(input);

% ��ϰ�Zeropadding
inputZeroPad = padarray(input,[M N],0,'post');
subplot(3,3,2);imshow(inputZeroPad);title('Zero Padding');
imwrite(im2uint8(inputZeroPad),'Zero Padding.tif');

%��shift�B�z
[P, Q] = size(inputZeroPad);
inputZeroPadShift = fshift(inputZeroPad);
subplot(3,3,3);imshow(inputZeroPadShift);title('Zero Padding After shift');
imwrite(im2uint8(inputZeroPadShift),'Zero Padding_after shift.tif');

%IZP(-1) DFT
tic
izpsDFT = myDFT2(inputZeroPadShift);
subplot(3,3,4);imshow(izpsDFT);title('Zero Padding Shift DFT');
imwrite(im2uint8(izpsDFT),'Zero Padding shift DFT.tif');
fprintf('IZPS�� DFT ����');
toc

%IZP DFT(-1)��Spectrum
tic
izpsDFTSp = abs(izpsDFT);
c = 1 / log(1 +range(izpsDFTSp(:))) % c = 1/log�᪺���Z
izpsDFTSp = c * log(1+izpsDFTSp); % ��ϹL�աA��log���t�ϩ�j�A�ð��Y����Range�����b0~1
subplot(3,3,5);imshow(izpsDFTSp);title('Zero Padding DFT Shift Spectrum');
imwrite(im2uint8(izpsDFTSp),'Zero Padding DFT Spectrum_128x128.tif');
fprintf('IZPS DFT��Spectrum ����');
toc
% H = GLPH
tic
D0 = 10;
GLPH = myGLPF(D0,P,Q);
subplot(3,3,6);imshow(GLPH);title('MyGLPH');
imwrite(im2uint8(GLPH),'MyGLPH.tif');
fprintf('GLPH ����');
toc
% G = H * F
tic
G = GLPH .* izpsDFT;
GSpectrum = abs(G);
subplot(3,3,7);imshow(GSpectrum);title('G Spectrum');
imwrite(im2uint8(GSpectrum),'GSpectrum.tif');
fprintf('H * F ����');
toc
% IDFT
tic
GIDFT = real(myIDFT2(G));
GIDFT = fshift(GIDFT); %��shift�B�z
subplot(3,3,8);imshow(GIDFT);title('G IDFT');
imwrite(im2uint8(GIDFT),'G IDFT.tif');
fprintf('G IDFT ����');
toc
% �h��padding
tic
result = GIDFT(1:M,1:N);
subplot(3,3,9);imshow(result);title('delete padding');
imwrite(im2uint8(result),'result.tif');
fprintf('�h��padding����');
toc