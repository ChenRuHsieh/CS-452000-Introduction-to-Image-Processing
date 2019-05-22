clear all;
TestInput = ones(5,5)
TestMask = [1,2,1;2,4,2;1,2,1]
input = imread('Fig0338(a)(blurry_moon).tif'); % 讀取題目圖片
inputSingle = single(input)/255;
TestOutput = spatialFiltering(TestInput, TestMask)
%imshow(TestOutput);