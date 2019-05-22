clear all;
origin = imread('Fig0220(a)(chronometer 3692x2812  2pt25 inch 1250 dpi).tif');
originDouble  = double(origin) / 255; % unit8�নdouble
resizeImage_shrink = resizeImage_replication(originDouble,1/10);
resizeImage_zoom = resizeImage_replication(resizeImage_shrink,10);
subplot(1,2,1);imshow(originDouble),title('��l�Ϥ�'); % ��ܭ�l�Ϥ�
subplot(1,2,2);imshow(resizeImage_zoom),title('�Y�p10���A��j�^���'); % ����Y�p��A��j���Ϥ�
imwrite(resizeImage_zoom,'resizeImage_zoom.tif');