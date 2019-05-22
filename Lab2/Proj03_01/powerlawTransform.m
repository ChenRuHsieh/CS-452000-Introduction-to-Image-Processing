function output = powerlawTransform(input, r)
%{
    input: a 2-D grayscale image data, type single, range 0~1
    output: a 2-D grayscale image data, type single, range0~1
    r: gamma value used in power law transformation (���i�R�W�� gamma), type single
    c: function �̭��Ψӽվ� output �� range �Ϩ丨�b[0,1]����(�i�H�g��)
%}
    c = 1; % �Nc�g����1
    output = c * input.^r; % ����output�۹������j�p
end

