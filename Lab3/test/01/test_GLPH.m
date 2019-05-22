clc;
clear all;
close all;

input = ones(1000);
input = im2single(input);
[M,N] = size(input);
D0 = 10;
MyGLPH = myGLPF(D0,M,N)
imshow(MyGLPH);