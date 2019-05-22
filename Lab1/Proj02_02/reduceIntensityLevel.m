function quantizedImage = reduceIntensityLevel(originalImage, intensityLevel)
    %{
    originalImage: �٨S quantize ����v��
    intensityLevel: reduce �� intensity level �� �q (2 �� 256)
    quantizedImage: intensity level quantized �᪺�v��
    �o��funtion�O����X�Ulevel���ȡA�A�ݭ�Ϫ���x���h�֡A��X�Px�̪�level��
    Ex.256 -> 4 level���Ȭ�0 85 170 255�A��Ϫ��ȳ̱�����ӭȡA�K�O�s�ȡC
    %}
    [r,c]=size(originalImage); % ���o��J��imgae�j�p
    indexValue = zeros(intensityLevel, 1); % ��C��level�������ȫإߦ��@�i��
    quantizedImage = zeros(r,c); % ����output�۹������j�p
    
    for i = 1 : intensityLevel
        indexValue(i,1) = (i-1)/(intensityLevel-1); % level value(double)
    end
    
    for i = 1 : r % ��i��row
        for j = 1 : c % ��j��col
            for k = 1 : intensityLevel % �q�̧Clevel�}�l��A��X���b����level�A�A��X�̪�level
                if k == (intensityLevel) & (originalImage(i,j) == indexValue(k)) % �P�_�O�_��̰�level 
                    quantizedImage(i,j) = indexValue(k); % �̰�level����
                    break;
                elseif (originalImage(i,j) >= indexValue(k)) & (originalImage(i,j) < indexValue(k+1))
                    % �P�_�O�_�blevel(k)�Mlevel(k+1)����
                    min = originalImage(i,j) - indexValue(k); % �Mlevel(k)���Z��
                    max = indexValue(k+1) - originalImage(i,j); % �Mlevel(k+1)���Z��
                    %fprintf("i = %g, j = %g,    min = %g, max = %g", i, j, min, max);
                    if min <= max % ����level(k)
                        quantizedImage(i,j) = indexValue(k); 
                    else % ����level(k+1)
                        quantizedImage(i,j) = indexValue(k+1);
                    end
                    break;
                end
            end
        end
    end
end

