function output = myDFT2(input)
%input: a 2-D matrix, type single
%output: a 2-D matrix, type single
[M,N] = size(input);
inputVector = reshape(input,1,M*N); % ��input�ন1��row
output = zeros(M,N,'single');
    for u = 0 : M-1
        for v = 0 : N-1
            %fprintf('u = %d, v = %d\n', u, v); % �ΨӬݰ�����
            expMap = zeros(M*N,1); % �Ψө��F(u,v)��exp
            for x = 0 : M-1 
                for y = 0 : N-1 
                    pow = (-1i*2*pi) * (u*x/M + v*y/N);
                    expMap(x*N + y + 1) = exp(pow);
                end
            end
            output(u+1,v+1) = inputVector * expMap ; % [1,M*N] * [M*N,1] 
        end
    end
end

