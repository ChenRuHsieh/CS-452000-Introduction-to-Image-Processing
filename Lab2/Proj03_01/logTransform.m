function output = logTransform(input)
%{
    input: a 2-D grayscale image data, type single, range 0~1
    output: a 2-D grayscale image data, type single, range0~1
    c: function 裡面用來調整 output 的 range 使其落在[0,1]之間(可以寫死)
    s = T(r) = c * log(1+r);
%}
    %c = 1;
    c = 1 / log10(1 +range(input(:))); % c = 1/log後的全距
    output = c * log10(1+input); 
end

