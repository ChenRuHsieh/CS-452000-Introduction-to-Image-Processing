function [output_f, Notch] = notchFiltering(input_f, D0, u0, v0)
% input_f & output_f: 2-D image in frequency domain (centered), type single
% Notch: notch reject filter in frequency domain (two-circle version)
[M,N] = size(input_f);
Notch = zeros(M,N,'single');
output_f = zeros(M,N,'single');
for u = 0 : M-1
    for v = 0 : N-1
        D1 = ((u-M/2-u0)^2 + (v-N/2-v0)^2)^(1/2);
        D2 = ((u-M/2+u0)^2 + (v-N/2+v0)^2)^(1/2);
        if( (D1<=D0) || (D2<=D0))
            Notch(u+1,v+1) = 0;
        else
            Notch(u+1,v+1) = 1;
        end
    end
end
output_f = input_f .* Notch;
end

