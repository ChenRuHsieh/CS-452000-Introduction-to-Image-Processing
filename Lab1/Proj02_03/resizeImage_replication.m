function resizedImage = resizeImage_replication(originalImage, scalingFactor)
    % originalImage: 還沒 resize 的原影像
    % scalingFactor: resize 的 scale (例如要放大為兩倍: 2；縮小為一半: 1/2)
    % resizedImage: resize 後的影像
    [r,c] =size(originalImage); % 取得輸入的imgae大小
    newR  = round(r*scalingFactor); % 新圖片的row數量，四捨五入進整數
    newC  = round(c*scalingFactor); % 新圖片的col數量，四捨五入進整數
    resizedImage = zeros(newR,newC); % 給予output相對應的大小
    rLevel = (r-1) / (newR - 1);
    cLevel = (c-1) / (newC - 1);
    for i = 1 : newR
        for j = 1 : newC
            R = (i-1)*rLevel + 1; % 第i個新圖的row 對應在 第R個舊圖的row
            C = (j-1)*cLevel + 1; % 第j個新圖的col 對應在 第C個舊圖的col
            %若R或C為小數，需要找最近的整數
            minR = fix(R); % R最近的最小整數
            maxR = minR + 1; % R最近的最大整數  
            minC = fix(C); % C最近的最小整數
            maxC = minC + 1; % C最近的最大整數
            %對row做取大小
            if (R-minR) <= (maxR-R) % 比較靠近小的row
                replaceR = minR; % 取小的row
            else % 比較靠近大的row
                replaceR = maxR; % 取大的row
            end
            %對col的處理，同row
            if (C-minC) <= (maxC-C)
                replaceC = minC;
            else
                replaceC = maxC;
            end
            resizedImage(i,j) = originalImage(replaceR, replaceC);
        end
    end
end

