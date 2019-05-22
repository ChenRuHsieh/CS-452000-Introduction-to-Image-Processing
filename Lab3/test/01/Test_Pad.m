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

%Zeropadding��(-1)�B�z
[P, Q] = size(inputZeroPad);
inputZeroPadShift = fshift(inputZeroPad);
subplot(3,3,3);imshow(inputZeroPadShift);title('Zero Padding After shift');
%��ϰ�(-1)�B�z
input = fshift(input);

%IZP(-1) DFT
%{
tic
izpsDFT = myDFT2(inputZeroPadShift);
subplot(3,3,4);imshow(izpsDFT);title('Zero Padding Shift DFT');
imwrite(im2uint8(izpsDFT),'Zero Padding shift DFT.tif');
fprintf('IZPS�� DFT ����');
toc
%}
%input DFT
tic
inputDFT = myDFT2(input);
subplot(3,3,5);imshow(inputDFT);title('Input DFT');
imwrite(im2uint8(inputDFT),'DFT without zeropadding 128x128.tif');
fprintf('IZPS�� DFT ����');
toc