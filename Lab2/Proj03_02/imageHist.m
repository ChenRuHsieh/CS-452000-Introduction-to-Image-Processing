function histVector = imageHist(input)
%{
    input: a 2-D grayscale image data, type uint8, range 0~255
    histVector: a row(or column) vector contains the histogram of an image, 256 elements, 
                type single, range 0~?(整數)(不可命名為 histogram)
%}
    [row,col] = size(input); % 取得輸入的imgae大小
    L = 256;
    histVector = zeros(L,1); % 把input中各intensity value的pixel個數存入該col
    for i = 1 : row
       for j = 1 : col
           value = input(i,j);
           histVector(value+1) = histVector(value+1)+1;
       end
    end
end

