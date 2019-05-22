function histVector = imageHist(input)
%{
    input: a 2-D grayscale image data, type uint8, range 0~255
    histVector: a row(or column) vector contains the histogram of an image, 256 elements, 
                type single, range 0~?(���)(���i�R�W�� histogram)
%}
    [row,col] = size(input); % ���o��J��imgae�j�p
    L = 256;
    histVector = zeros(L,1); % ��input���Uintensity value��pixel�ӼƦs�J��col
    for i = 1 : row
       for j = 1 : col
           value = input(i,j);
           histVector(value+1) = histVector(value+1)+1;
       end
    end
end

