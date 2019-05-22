function output = logTransform(input)
%{
    input: a 2-D grayscale image data, type single, range 0~1
    output: a 2-D grayscale image data, type single, range0~1
    c: function �̭��Ψӽվ� output �� range �Ϩ丨�b[0,1]����(�i�H�g��)
    s = T(r) = c * log(1+r);
%}
    %c = 1;
    c = 1 / log10(1 +range(input(:))); % c = 1/log�᪺���Z
    output = c * log10(1+input); 
end

