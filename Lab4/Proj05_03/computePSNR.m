function psnr = computePSNR(input1_s, input2_s)
% input1_s : 原圖
% input2_s : 經過filter復原的圖
[M,N] = size(input1_s);
fpeak = max(max(input1_s)); % 原圖pixel中的最大值
up = M*N*(fpeak^2); % 分子
down = 0; 
% 算出分母
for x = 1 : M
    for y = 1 : N
        down = down + (input1_s(x,y)-input2_s(x,y))^2;
    end
end
psnr = 10 * log10(up/down);
end

