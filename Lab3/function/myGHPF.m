function output = myGHPF(D0,M,N)
% D0: variable of Gaussian Lowpass Filtering, type single (see Eq. (4.9-4) [²Ä¥|ª©½Ò¥»Eq. (4-120)])
% M, N: size of the filter(M x N), type single
% output: a 2-D GHPF, type single
    output = 1 - myGLPF(D0,M,N); % high pass = 1 - low pass
end

