function [output_f, H] = addMotionBlur(input_f, T, a, b);
% input_f & output_f: 2-D image in frequency domain (centered), type single
% H: motion blur degradation function in frequency domain, type single
% T & a & b: motion blur parameters (見 Eq. 5.6-11 [第四版課本 Eq. 5-77])
[M,N] = size(input_f);
H = zeros(M,N,'single');
for u = 0 : M-1
    for v = 0 : N-1
        offset = 10^-5; % 避免當u、v等於原點時，出現分母=0的情況
        tmp = pi* (a*(u-round(M/2)+offset) + b*(v-round(N/2)+offset)); % 要將filter原點移至中央
        up = -1i*(tmp); % e的指數項
        theta = tmp; % sin裡的數字
        H(u+1,v+1) = (T/tmp) * sin(theta) * exp(up);
    end
end
output_f = input_f .* H;
end

