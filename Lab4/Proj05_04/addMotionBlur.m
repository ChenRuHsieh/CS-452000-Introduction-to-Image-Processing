function [output_f, H] = addMotionBlur(input_f, T, a, b);
% input_f & output_f: 2-D image in frequency domain (centered), type single
% H: motion blur degradation function in frequency domain, type single
% T & a & b: motion blur parameters (�� Eq. 5.6-11 [�ĥ|���ҥ� Eq. 5-77])
[M,N] = size(input_f);
H = zeros(M,N,'single');
for u = 0 : M-1
    for v = 0 : N-1
        offset = 10^-5; % �קK��u�Bv������I�ɡA�X�{����=0�����p
        tmp = pi* (a*(u-round(M/2)+offset) + b*(v-round(N/2)+offset)); % �n�Nfilter���I���ܤ���
        up = -1i*(tmp); % e�����ƶ�
        theta = tmp; % sin�̪��Ʀr
        H(u+1,v+1) = (T/tmp) * sin(theta) * exp(up);
    end
end
output_f = input_f .* H;
end

