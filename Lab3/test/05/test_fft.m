clc;
clear all;
close all;
input = imread('Fig0457(a)(thumb_print).tif'); % Ū���D�عϤ�
input = imresize(input, 1/10); % �Y�p10��
figure;imshow(input);title('Origin��1/10');
input = im2single(input);
[M,N] = size(input);

edge = 128;
inputZeroPad = padarray(input,[edge-M edge-N],0,'post');
figure;imshow(inputZeroPad);title('Zero Padding');
imwrite(inputZeroPad,'Zero Padding.png');
input_shift = fshift(inputZeroPad); % ��(-1)�B�z

D0 = 6; % �]���Ϥ����Y�p�A�]��D0���Y�p
MyGHPF = myGHPF(D0,edge,edge);

outputDFT = fft2(input_shift);
figure;imshow(outputDFT);title('fft2');
imwrite(outputDFT,'fft2.png');

G = outputDFT .* MyGHPF;
GIDFT = real(ifft2(G));
figure;imshow(GIDFT);title('ifft2');
imwrite(GIDFT,'ifft2.png');

GIDFT = fshift(GIDFT); %��(-1)�B�z
figure;imshow(GIDFT);title('After GHPH');
imwrite(GIDFT,'matlab After GHPH.png');
%�h��Padding
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