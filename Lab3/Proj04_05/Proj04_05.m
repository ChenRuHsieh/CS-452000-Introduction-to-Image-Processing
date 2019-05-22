clc;
clear all;
close all;
input = imread('Fig0457(a)(thumb_print).tif'); % Ū���D�عϤ�
input = imresize(input, 1/10); % �Y�p10��
input = im2single(input);
subplot(1,4,1);imshow(input);title('Origin��1/10');
imwrite(im2uint8(input),'input.tif');
[M,N] = size(input);
% Zero Padding�쥿���

edge = 2^(fix(log2(max(M,N)))+1) % �M��̱���2����A��@padding�᪺��`
inputZeroPad = padarray(input,[edge-M edge-N],0,'post');
subplot(1,4,2);imshow(inputZeroPad);title('Zero Padding');
imwrite(im2uint8(inputZeroPad),'Zero Padding.tif');

D0 = 20; 
MyGHPF = myGHPF(D0,edge,edge); % ����filter
input_shift = fshift(inputZeroPad); % ��shift�B�z
outputDFT = myDFT2(input_shift); % DFT
G = outputDFT .* MyGHPF;% ��filter�B�z
tic
GIDFT = real(myIDFT2(G));% ��IDFT�A����ƨ���ܹϤ�
toc
GIDFT = fshift(GIDFT); %��shift�B�z
GIDFT = GIDFT(1:M,1:N);%�h��Padding
subplot(1,4,3);imshow(GIDFT);title('result');
imwrite(im2uint8(GIDFT),'result.tif');

thresholding = 0; % �H0����
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
