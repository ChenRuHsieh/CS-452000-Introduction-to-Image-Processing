function output = powerlawTransform(input, r)
%{
    input: a 2-D grayscale image data, type single, range 0~1
    output: a 2-D grayscale image data, type single, range0~1
    r: gamma value used in power law transformation (不可命名為 gamma), type single
    c: function 裡面用來調整 output 的 range 使其落在[0,1]之間(可以寫死)
%}
    c = 1; % 將c寫死成1
    output = c * input.^r; % 給予output相對應的大小
end

