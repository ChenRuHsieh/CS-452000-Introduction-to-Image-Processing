function output = fshift(input) 
%��input��(-1)�B�z
[M,N] = size(input);
output = zeros(M,N,'single');
    for x = 0 : M-1
        for y = 0 : N-1
            output(x+1,y+1) = input(x+1,y+1) * ((-1)^(x+y));
        end
    end
end

