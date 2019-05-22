clear all;
origin = imread('Fig0220(a)(chronometer 3692x2812  2pt25 inch 1250 dpi).tif');
originDouble  = double(origin) / 255; % unit8轉成double
resizeImage_shrink = resizeImage_replication(originDouble,1/10);
resizeImage_zoom = resizeImage_replication(resizeImage_shrink,10);
subplot(1,2,1);imshow(originDouble),title('原始圖片'); % 顯示原始圖片
subplot(1,2,2);imshow(resizeImage_zoom),title('縮小10倍再放大回原樣'); % 顯示縮小後再放大的圖片
imwrite(resizeImage_zoom,'resizeImage_zoom.tif');