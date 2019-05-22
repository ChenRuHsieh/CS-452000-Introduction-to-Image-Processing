function output_s = addSinNoise(input_s, A, u0, v0)
% input_s & output_s: 2-D image in spatial domain, type single, range 0~1
[M,N] = size(input_s);
noise = zeros(M,N,'single');
output_s = zeros(M,N,'single');
% °µ¥Xnoise matrix
for x = 0 : M-1
    for y = 0 : N-1
        tmp = u0*x/M + v0*y/N;
        noise(x+1,y+1) = A * sin(2*pi*tmp);
    end
end
%input_sptial = fshift(ifft(input_s));
%imshow(
output_s = input_s + noise;
end

