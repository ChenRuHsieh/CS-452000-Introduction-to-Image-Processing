clear all;
input = imread('Fig0338(a)(blurry_moon).tif'); % 讀取題目圖片
inputSingle = single(input)/255;
subplot(2,4,1);imshow(inputSingle);title('Origin');
for i = 1 : 7
    switch i
        case 1 
            scale = 1;
            laplacianMask = [0,1,0;1,-4,1;0,1,0];
        case 2
            scale = 1;
            laplacianMask = [0,1,0;1,-4,1;0,1,0];
        case 3 
            scale = -1;
            laplacianMask = [0,1,0;1,-4,1;0,1,0];
        case 4 
            scale = 5;
            laplacianMask = [0,1,0;1,-4,1;0,1,0];
        case 5 
            scale = -5;
            laplacianMask = [0,1,0;1,-4,1;0,1,0];
        case 6
            scale = 1;
            laplacianMask = [1,1,1;1,-8,1;1,1,1];
        case 7 
            scale = -1;
            laplacianMask = [1,1,1;1,-8,1;1,1,1];
        otherwise
    end
    laplacianMask = single(laplacianMask);
    [output, scaledLaplacian] = laplacianFiltering(inputSingle, laplacianMask, scale);
    subplot(2,4,i+1); % 顯示PowerLawTransform的圖片
    switch i 
        case 1
            imshow(scaledLaplacian);
            title('scaledLaplacian(a), scale = 1');
            imwrite(scaledLaplacian,'mirrorPad_scaledLaplacian(a), scale = 1.png');
        case 2
            imshow(output);
            title('laplacianMask(a), scale = 1');
            imwrite(output,'mirrorPad_laplacianMask(a), scale = 1.png');
        case 3 
            imshow(output);
            title('laplacianMask(a), scale = -1');
            imwrite(output,'mirrorPad_laplacianMask(a), scale = -1.png');
        case 4 
            imshow(output);
            title('laplacianMask(a), scale = 5');
            imwrite(output,'mirrorPad_laplacianMask(a), scale = 5.png');
        case 5
            imshow(output);
            title('laplacianMask(a), scale = -5');
            imwrite(output,'mirrorPad_laplacianMask(a), scale = -5.png');    
        case 6
            imshow(output);
            title('laplacianMask(b), scale = 1');
            imwrite(output,'mirrorPad_laplacianMask(b), scale = 1.png');
        case 7
            imshow(output);
            title('laplacianMask(b), scale = -1');
            imwrite(output,'mirrorPad_laplacianMask(b), scale = -1.png');
    end
end
