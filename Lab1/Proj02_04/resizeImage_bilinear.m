function resizedImage = resizeImage_bilinear(originalImage, scalingFactor)
    % originalImage: 還沒 resize 的原影像
    % scalingFactor: resize 的 scale (例如要放大為兩倍: 2；縮小為一半: 1/2)
    % resizedImage: resize 後的影像
    [r,c] = size(originalImage); % 取得輸入的imgae大小
    newR  = round(r*scalingFactor); % 新圖片的row數量，四捨五入進整數
    newC  = round(c*scalingFactor); % 新圖片的col數量，四捨五入進整數
    resizedImage = zeros(newR,newC); % 給予output相對應的大小
    rLevel = (r-1) / (newR - 1);
    cLevel = (c-1) / (newC - 1);
     for i = 1 : newR
        for j = 1 : newC
            x = (i-1)*rLevel + 1; % 第i個新圖的row 對應在 第x個舊圖的row
            y = (j-1)*cLevel + 1; % 第j個新圖的col 對應在 第y個舊圖的col
            
            if ( (x == fix(x)) & (y == fix(y)) ) == 1 % 若x和y為整數，只需直接取值
                newPixel = originalImage(x,y);
            elseif ( (x == fix(x)) & (y ~= fix(y)) ) == 1 % 若x或y其一為整數，只需做非整數的該維度線性變化
                % f(y) = ay + b
                % 找出係數a、b
                y1 = fix(y); % 最接近y且比y小的col
                y2 = y1 + 1; % 最接近y且比y大的col
                f1 = originalImage(x,y1);
                f2 = originalImage(x,y2);
                a = f2 - f1;
                b = y2*f1 - y1*f2;
                newPixel = a*y + b;
            elseif ( (x ~= fix(x)) & (y == fix(y)) ) == 1
                % f(x) = ax + b
                % 找出係數a、b
                x1 = fix(x); % 最接近x且比x小的col
                x2 = x1 + 1; % 最接近x且比x大的col
                f1 = originalImage(x1,y);
                f2 = originalImage(x2,y);
                a = f2 - f1;
                b = x2*f1 - x1*f2;
                newPixel = a*x + b;
            else % 若x、y皆非整數，需要該點附近的4個整數點
                x1 = fix(x); % x最近的最小整數
                x2 = x1 + 1; % x最近的最大整數  
                y1 = fix(y); % y最近的最小整數
                y2 = y1 + 1; % y最近的最大整數
                % f(x,y) = a0 + a1x + a2y + a3xy
                % 找出係數a0、a1、a2、a3
                % Qxy = f(x,y) Q11 = f(x1,y1)
                % 公式參照維基百科 https://en.wikipedia.org/wiki/Bilinear_interpolation
                Q11 = originalImage(x1, y1); % 左上的整數點
                Q12 = originalImage(x1, y2); % 右上的整數點
                Q21 = originalImage(x2, y1); % 左下的整數點
                Q22 = originalImage(x2, y2); % 右下的整數點
                a0 = ( (Q11*x2*y2) / ( (x1-x2)*(y1-y2) ) ) + ( (Q12*x2*y1) / ( (x1-x2)*(y2-y1) ) )...
                   + ( (Q21*x1*y2) / ( (x1-x2)*(y2-y1) ) ) + ( (Q22*x1*y1) / ( (x1-x2)*(y1-y2) ) );

                a1 = ( (Q11*y2) / ( (x1-x2)*(y2-y1) ) ) + ( (Q12*y1) / ( (x1-x2)*(y1-y2) ) )...
                   + ( (Q21*y2) / ( (x1-x2)*(y1-y2) ) ) + ( (Q22*y1) / ( (x1-x2)*(y2-y1) ) );

                a2 = ( (Q11*x2) / ( (x1-x2)*(y2-y1) ) ) + ( (Q12*x2) / ( (x1-x2)*(y1-y2) ) )...
                   + ( (Q21*x1) / ( (x1-x2)*(y1-y2) ) ) + ( (Q22*x1) / ( (x1-x2)*(y2-y1) ) );

                a3 = ( (Q11) / ( (x1-x2)*(y1-y2) ) ) + ( (Q12) / ( (x1-x2)*(y2-y1) ) )...
                   + ( (Q21) / ( (x1-x2)*(y2-y1) ) ) + ( (Q22) / ( (x1-x2)*(y1-y2) ) );
                % f(x,y) = a0 + a1x + a2y + a3xy
                newPixel = a0 + a1*x + a2*y + a3*x*y; 
            end
            resizedImage(i,j) = newPixel;
        end
        end
end

