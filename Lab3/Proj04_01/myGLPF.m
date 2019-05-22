function output = myGLPF(D0,M,N);
% D0: variable of Gaussian Lowpass Filtering, type single (see Eq. (4.8-7) [²Ä¥|ª©½Ò¥» Eq. (4-116)])
% M, N: size of the filter(M x N), type int
% output: a 2-D GLPF, type single
output = zeros(M,N,'single');
midM = round(M/2);
midN = round(N/2);
    for u = 0 : M-1
        for v = 0 : N-1
            Duv = (u-midM)^2 + (v-midN)^2;
            o = 2*(D0^2);
            output(u+1,v+1) = exp(-Duv/o);
        end
    end
end

