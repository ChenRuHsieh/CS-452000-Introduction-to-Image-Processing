clear all;
input = imread('Fig0308(a)(fractured_spine).tif'); % Ū���D�عϤ�
% ��Ϫ� histogram
input_histVector = single(imageHist(input)); %
x = 0:255;y = input_histVector(x+1);
plot(x,y);
xlabel('intensity value'),ylabel('the nuber of pixels'),title('the histogram of input image');
grid on;
saveas(gcf,'input_histogram.tif');

% enhance �᪺��
[output,T] = histEqualization(input);
T = uint8(T);
output = uint8(output);
imwrite(output,'Fig0308(a)(fractured_spine)_hist.tif');
% enhance �᪺�Ϫ�histogram
output_histVector = single(imageHist(output));
x = 0:255;y = output_histVector(x+1);
plot(x,y);
xlabel('intensity value'),ylabel('the nuber of pixels'),title('the histogram of output image');
grid on;
saveas(gcf,'output_histogram.tif');

% histogram equalization transformation function
x = 0:255;y = T(x+1);
figure;
stairs(x,y);
xlabel('pk'),ylabel('tk'),title('histogram equalization transformation function');
grid on;
saveas(gcf,'histogram equalization transformation function.tif');
% �N���G��ܦb�P�@�ӵ���
subplot(3,2,1);imshow(input);title('Origin');
subplot(3,2,2);imshow('input_histogram.tif'),title('the histogram of input image');
subplot(3,2,3);imshow(output);title('enhance �᪺��');
subplot(3,2,4);imshow('output_histogram.tif');title('the histogram of output image');
subplot(3,2,5);imshow('histogram equalization transformation function.tif');title('histogram equalization transformation function');
