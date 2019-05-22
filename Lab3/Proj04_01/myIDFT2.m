function output = myIDFT2(input);
%input: a 2-D matrix, type single
%output: a 2-D matrix, type single
[M,N] = size(input);
inputVector = reshape(input,1,M*N); % 把input轉成1個row
output = zeros(M,N,'single');
    for x = 0 : M-1
        for y = 0 : N-1
            %fprintf('x = %d, y = %d\n', x, y); % 用來看執行到哪
            expMap = zeros(M*N,1); % 用來放該f(x,y)的exp
            for u = 0 : M-1
                for v = 0 : N-1
                    pow = (1i*2*pi) * ((u*x/M) + (v*y/N));
                    expMap(u*N + v + 1) = exp(pow);
                end
            end
            output(x+1,y+1) = (inputVector * expMap) / (M*N);
        end
    end
end

