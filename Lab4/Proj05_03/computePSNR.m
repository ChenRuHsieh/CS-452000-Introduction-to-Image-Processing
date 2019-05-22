function psnr = computePSNR(input1_s, input2_s)
% input1_s : ���
% input2_s : �g�Lfilter�_�쪺��
[M,N] = size(input1_s);
fpeak = max(max(input1_s)); % ���pixel�����̤j��
up = M*N*(fpeak^2); % ���l
down = 0; 
% ��X����
for x = 1 : M
    for y = 1 : N
        down = down + (input1_s(x,y)-input2_s(x,y))^2;
    end
end
psnr = 10 * log10(up/down);
end

