clc;
clear all;
close all;
input = imread('Fig0441(a)(characters_test_pattern).tif'); % Ū���D�عϤ�
input = imresize(input, 128/688); % �Y�p��128x128
subplot(2,3,1);imshow(input);title('Origin��128x128');
imwrite(im2uint8(input),'input.tif');
input = im2single(input);
[M,N] = size(input);
input_shift = fshift(input); % ��shift�B�z
n=1;
    for i = [10, 30, 60, 160, 460]
        n = n + 1;
        tic
        D0 = i *128/688; % �]���Ϥ����Y�p�A�]��D0���Y�p
        MyGLPF = myGLPF(i,M,N); % ����GLPH
        outputDFT = myDFT2(input_shift); % ��DFT
        G = outputDFT .* MyGLPF; % ��filter 
        GIDFT = real(myIDFT2(G)); % ��IDFT�A�u��������
        GIDFT = fshift(GIDFT); %��shift�B�z
        subplot(2,3,n);imshow(GIDFT);
        switch i 
        case 10
            title('D0 = 10');
            imwrite(im2uint8(GIDFT),'D0 = 10.tif');
            fprintf("D0 = 10 ��GLPH�w����");
        case 30
            title('D0 = 30');
            imwrite(im2uint8(GIDFT),'D0 = 30.tif');
            fprintf("D0 = 30 ��GLPH�w����");
        case 60
            title('D0 = 60');
            imwrite(im2uint8(GIDFT),'D0 = 60.tif');
            fprintf("D0 = 60 ��GLPH�w����");
        case 160 
            title('D0 = 160');
            imwrite(im2uint8(GIDFT),'D0 = 160.tif');
            fprintf("D0 = 160 ��GLPH�w����");
        case 460
            title('D0 = 460');
            imwrite(im2uint8(GIDFT),'D0 = 460.tif');
            fprintf("D0 = 460 ��GLPH�w����");  
        end
        toc
    end
