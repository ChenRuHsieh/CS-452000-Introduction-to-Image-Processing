clear all;
TestInput = ones(5,5)
TestMask = [1,2,1;2,4,2;1,2,1]
input = imread('Fig0338(a)(blurry_moon).tif'); % Ū���D�عϤ�
inputSingle = single(input)/255;
TestOutput = spatialFiltering(TestInput, TestMask)
%imshow(TestOutput);