function output = spatialFiltering(input, mask)
%{
    input: a 2-D grayscale image data, type single, range 0~1
    output: a 2-D grayscale image data, type single, range0~1
    mask: a 2-D mask, type single
%}
    [row,col] = size(input);
    [mRow,mCol] = size(mask); % 通常mask是方陣，mRow = mCol
    mLen = (mRow-1)/2; % mask的center距離邊界的距離
    output = zeros(row,col,'single');
    zeroPaddingInput = zeros(row+mLen*2,col+mLen*2,'single'); % 以input做出一個符合mask的Zero Padding
    mirrorPaddingInput = padarray(input,[mLen mLen],'symmetric','both'); % 以input做出一個符合mask的Mirror Padding
    rotateMask = zeros(mRow,mCol,'single');
    for i = 1 : row % 將input寫入zeropaddingInput
        for j = 1 : col
            zeroPaddingInput(i+1,j+1) = input(i,j);
        end
    end
    zeroPaddingInput
    for i = 1 : mRow % 將mask rotate
        for j = 1 : mCol
            rotateMask(mRow-i+1,mCol-j+1) = mask(i,j);
        end
    end
    for i = 1 : row
        for j = 1 : col
            newValue = 0;
            for s = 1 : mRow
               for t = 1 : mCol
                   newValue = newValue + mask(s,t) *  zeroPaddingInput(i+s-1,j+t-1);
               end
            end
            output(i,j) = single(newValue);
        end
    end
end

