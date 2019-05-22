clc;
clear all;
close all;
input = imread('Fig0441(a)(characters_test_pattern).tif'); % Ū���D�عϤ�
input = imresize(input, 128/688); % �Y�p��128x128
subplot(1,3,1);imshow(input);title('Origin��1/10');
input = im2single(input);
imwrite(im2uint8(input),'input.tif');
[M,N] = size(input);
input_shift = fshift(input); % ��(-1)�B�z
n=1;    
    for i = [60, 160]
        n=n+1;    
        tic
        D0 = i*128/688; % �]���Ϥ����Y�p�A�]��D0���Y�p
        MyGHPF = myGHPF(i,M,N);
        outputDFT = myDFT2(input_shift);
        G = outputDFT .* MyGHPF;
        GIDFT = real(myIDFT2(G));
        GIDFT = fshift(GIDFT); %��(-1)�B�z
        GIDFT = powerlawTransform(GIDFT, 0.3); % �ӷt�A���G�ƳB�z
        subplot(1,3,n);imshow(GIDFT);
        switch i 
        case 60
            title('D0 = 60');
            imwrite(im2uint8(GIDFT),'D0 = 60_light.tif');
            fprintf("D0 = 60 ��GLPH�w����");
        case 160 
            title('D0 = 160');
            imwrite(im2uint8(GIDFT),'D0 = 160_light.tif');
            fprintf("D0 = 160 ��GLPH�w����");
        end
        toc
    end
