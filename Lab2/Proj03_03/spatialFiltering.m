function output = spatialFiltering(input, mask)
%{
    input: a 2-D grayscale image data, type single, range 0~1
    output: a 2-D grayscale image data, type single, range0~1
    mask: a 2-D mask, type single
%}
    [row,col] = size(input);
    [mRow,mCol] = size(mask); % �q�`mask�O��}�AmRow = mCol
    mLen = (mRow-1)/2; % mask��center�Z����ɪ��Z��
    output = zeros(row,col,'single');
    zeroPaddingInput = zeros(row+mLen*2,col+mLen*2,'single'); % �Hinput���X�@�ӲŦXmask��Zero Padding
    mirrorPaddingInput = padarray(input,[mLen mLen],'symmetric','both'); % �Hinput���X�@�ӲŦXmask��Mirror Padding
    rotateMask = zeros(mRow,mCol,'single');
    for i = 1 : row % �Ninput�g�JzeropaddingInput
        for j = 1 : col
            zeroPaddingInput(i+1,j+1) = input(i,j);
        end
    end
    zeroPaddingInput
    for i = 1 : mRow % �Nmask rotate
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

