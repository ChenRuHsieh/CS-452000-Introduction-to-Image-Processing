function output_f = wienerFiltering(input_f, H, K)
% input_f & output_f: 2-D image in frequency domain (centered), type single
% K: Wiener filter parameter (�� Eq. 5.8-6 [�ĥ|���ҥ� Eq. 5-85])
% H : motion blur
[M,N] = size(input_f);
W = zeros(M,N,'single');
% �إ�wienerFiltering
for u = 1 : M
    for v = 1 : N
        H_2 = abs(H(u,v))^2;
        W(u,v) = (H_2/(H_2+K)) / H(u,v);
    end
end
output_f = input_f .* W;    
end

