clc;
clear all;
close all;
input = imread('Fig0431(d)(blown_ic_crop).tif'); % Ū���D�عϤ�
input = imresize(input, 0.1); % �Y�p10��
input = im2single(input);
subplot(3,3,1);imshow(input);title('Origin');
[M,N] = size(input);

% ��ϰ�Zeropadding
inputZeroPad = padarray(input,[50 50],0,'post');
subplot(3,3,2);imshow(inputZeroPad);title('Zero Padding');
imwrite(inputZeroPad,'Zero Padding.png');

%��(-1)�B�z
[P, Q] = size(inputZeroPad);
inputZeroPad_mul = fshift(inputZeroPad);
subplot(3,3,3);imshow(inputZeroPad_mul);title('Zero Padding After -1');
imwrite(inputZeroPad_mul,'Zero Padding_after(-1).png');
% ��Ϫ� DFT
%{
tic
originDFT = myDFT2(input);
subplot(5,3,4);imshow(originDFT);title('Origin DFT');
imwrite(originDFT,'origin DFT.png');
fprintf('��Ϫ� DFT ����');
toc
%IZP DFT
tic
zeroPadDFT = myDFT2(inputZeroPad);
subplot(5,3,5);imshow(zeroPadDFT);title('Zero Padding DFT');
imwrite(zeroPadDFT,'Zero Padding DFT.png');
fprintf('IZP�� DFT ����');
toc
%}
%IZP(-1) DFT
tic
zeroPadDFT_mul = myDFT2(inputZeroPad_mul);
subplot(3,3,4);imshow(zeroPadDFT_mul);title('Zero Padding(-1) DFT');
imwrite(zeroPadDFT_mul,'Zero Padding(-1) DFT.png');
fprintf('IZP(-1)�� DFT ����');
toc
%��� DFT��Spectrum
%{
tic
originDFTSp = abs(originDFT);
subplot(5,3,7);imshow(originDFTSp);title('Origin DFT Spectrum');
imwrite(originDFTSp,'Origin DFT Spectrum.png');
fprintf('Origin DFT��Spectrum ����');
toc
%}
%IZP DFT��Spectrum
%{
tic
zPadDftSp = abs(zeroPadDFT);
subplot(5,3,8);imshow(zPadDftSp);title('Zero Padding DFT Spectrum');
imwrite(zPadDftSp,'Zero Padding DFT Spectrum.png');
fprintf('IZP DFT��Spectrum ����');
toc
%}
%IZP DFT(-1)��Spectrum
tic
zPadDftSp_mul = abs(zeroPadDFT_mul);
c = 1 / log(1 +range(zPadDftSp_mul(:))) % c = 1/log�᪺���Z
zPadDftSp_mul = c * log(1+zPadDftSp_mul);
subplot(3,3,5);imshow(zPadDftSp_mul);title('Zero Padding DFT(-1) Spectrum');
imwrite(zPadDftSp_mul,'Zero Padding DFT Spectrum.png');
fprintf('IZP DFT��Spectrum ����');
toc
% H = GLPH
tic
D0 = 10;
MyGLPH = myGLPF(D0,P,Q);
subplot(3,3,6);imshow(MyGLPH);title('MyGLPH');
imwrite(MyGLPH,'MyGLPH.png');
fprintf('GLPH ����');
toc
% G = H * F
tic
G = MyGLPH .* zeroPadDFT_mul;
GSpectrum = abs(G);
%subplot(5,3,11);imshow(G);title('G = GLPH x zpdDFT(-1)')
subplot(3,3,7);imshow(GSpectrum);title('G Spectrum');
%imwrite(G,'GLPH x zpdDFT(-1).png');
imwrite(GSpectrum,'GSpectrum.png');
fprintf('H * F ����');
toc
% IDFT
tic
GIDFT = real(myIDFT2(G));
GIDFT = fshift(GIDFT); %��(-1)�B�z
subplot(3,3,8);imshow(GIDFT);title('G IDFT');
imwrite(GIDFT,'G IDFT.png');
fprintf('G IDFT ����');
toc
% �h��padding
tic
result = GIDFT(1:M,1:N);
subplot(3,3,9);imshow(result);title('delete padding');
imwrite(result,'result.png');
fprintf('�h��padding����');
toc
%{
% ��Ϫ� IDFT
tic
originIDFT = myIDFT2(originDFT);
subplot(3,4,11);imshow(originIDFT);title('Origin IDFT');
imwrite(originIDFT,'Origin IDFT.png');
fprintf('��Ϫ� IDFT ����');
toc
%IZP IDFT
tic
zeroPadIDFT = myIDFT2(zeroPadDFT);
subplot(3,4,12);imshow(zeroPadIDFT);title('Zero Padding IDFT');
imwrite(zeroPadIDFT,'Zero Padding IDFT.png');
fprintf('IZP�� IDFT ����');
toc
%}