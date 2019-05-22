function output = myIDFT2(input);
%input: a 2-D matrix, type single
%output: a 2-D matrix, type single
[M,N] = size(input);
inputVector = reshape(input,1,M*N); % ��input�ন1��row
output = zeros(M,N,'single');
    for x = 0 : M-1
        for y = 0 : N-1
            %fprintf('x = %d, y = %d\n', x, y); % �ΨӬݰ�����
            expMap = zeros(M*N,1); % �Ψө��f(x,y)��exp
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

