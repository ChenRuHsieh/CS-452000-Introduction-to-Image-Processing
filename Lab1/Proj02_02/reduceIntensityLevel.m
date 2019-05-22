function quantizedImage = reduceIntensityLevel(originalImage, intensityLevel)
    %{
    originalImage: 還沒 quantize 的原影像
    intensityLevel: reduce 的 intensity level 數 量 (2 到 256)
    quantizedImage: intensity level quantized 後的影像
    這個funtion是先找出各level的值，再看原圖的值x為多少，找出與x最近的level值
    Ex.256 -> 4 level的值為0 85 170 255，原圖的值最接近哪個值，便是新值。
    %}
    [r,c]=size(originalImage); % 取得輸入的imgae大小
    indexValue = zeros(intensityLevel, 1); % 把每個level的對應值建立成一張表
    quantizedImage = zeros(r,c); % 給予output相對應的大小
    
    for i = 1 : intensityLevel
        indexValue(i,1) = (i-1)/(intensityLevel-1); % level value(double)
    end
    
    for i = 1 : r % 第i個row
        for j = 1 : c % 第j個col
            for k = 1 : intensityLevel % 從最低level開始找，找出落在哪兩level，再找出最近的level
                if k == (intensityLevel) & (originalImage(i,j) == indexValue(k)) % 判斷是否到最高level 
                    quantizedImage(i,j) = indexValue(k); % 最高level的值
                    break;
                elseif (originalImage(i,j) >= indexValue(k)) & (originalImage(i,j) < indexValue(k+1))
                    % 判斷是否在level(k)和level(k+1)之間
                    min = originalImage(i,j) - indexValue(k); % 和level(k)的距離
                    max = indexValue(k+1) - originalImage(i,j); % 和level(k+1)的距離
                    %fprintf("i = %g, j = %g,    min = %g, max = %g", i, j, min, max);
                    if min <= max % 接近level(k)
                        quantizedImage(i,j) = indexValue(k); 
                    else % 接近level(k+1)
                        quantizedImage(i,j) = indexValue(k+1);
                    end
                    break;
                end
            end
        end
    end
end

