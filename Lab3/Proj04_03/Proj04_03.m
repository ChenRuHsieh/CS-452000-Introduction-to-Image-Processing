clc;
clear all;
close all;
input = imread('Fig0441(a)(characters_test_pattern).tif'); % 讀取題目圖片
input = imresize(input, 128/688); % 縮小成128x128
subplot(2,3,1);imshow(input);title('Origin的128x128');
imwrite(im2uint8(input),'input.tif');
input = im2single(input);
[M,N] = size(input);
input_shift = fshift(input); % 做shift處理
n=1;
    for i = [10, 30, 60, 160, 460]
        n = n + 1;
        tic
        D0 = i *128/688; % 因為圖片有縮小，也對D0做縮小
        MyGLPF = myGLPF(i,M,N); % 產生GLPH
        outputDFT = myDFT2(input_shift); % 做DFT
        G = outputDFT .* MyGLPF; % 做filter 
        GIDFT = real(myIDFT2(G)); % 做IDFT，只取實數顯示
        GIDFT = fshift(GIDFT); %做shift處理
        subplot(2,3,n);imshow(GIDFT);
        switch i 
        case 10
            title('D0 = 10');
            imwrite(im2uint8(GIDFT),'D0 = 10.tif');
            fprintf("D0 = 10 的GLPH已完成");
        case 30
            title('D0 = 30');
            imwrite(im2uint8(GIDFT),'D0 = 30.tif');
            fprintf("D0 = 30 的GLPH已完成");
        case 60
            title('D0 = 60');
            imwrite(im2uint8(GIDFT),'D0 = 60.tif');
            fprintf("D0 = 60 的GLPH已完成");
        case 160 
            title('D0 = 160');
            imwrite(im2uint8(GIDFT),'D0 = 160.tif');
            fprintf("D0 = 160 的GLPH已完成");
        case 460
            title('D0 = 460');
            imwrite(im2uint8(GIDFT),'D0 = 460.tif');
            fprintf("D0 = 460 的GLPH已完成");  
        end
        toc
    end
