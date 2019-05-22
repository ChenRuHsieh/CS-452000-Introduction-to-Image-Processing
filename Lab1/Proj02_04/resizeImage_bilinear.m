function resizedImage = resizeImage_bilinear(originalImage, scalingFactor)
    % originalImage: �٨S resize ����v��
    % scalingFactor: resize �� scale (�Ҧp�n��j���⭿: 2�F�Y�p���@�b: 1/2)
    % resizedImage: resize �᪺�v��
    [r,c] = size(originalImage); % ���o��J��imgae�j�p
    newR  = round(r*scalingFactor); % �s�Ϥ���row�ƶq�A�|�ˤ��J�i���
    newC  = round(c*scalingFactor); % �s�Ϥ���col�ƶq�A�|�ˤ��J�i���
    resizedImage = zeros(newR,newC); % ����output�۹������j�p
    rLevel = (r-1) / (newR - 1);
    cLevel = (c-1) / (newC - 1);
     for i = 1 : newR
        for j = 1 : newC
            x = (i-1)*rLevel + 1; % ��i�ӷs�Ϫ�row �����b ��x���¹Ϫ�row
            y = (j-1)*cLevel + 1; % ��j�ӷs�Ϫ�col �����b ��y���¹Ϫ�col
            
            if ( (x == fix(x)) & (y == fix(y)) ) == 1 % �Yx�My����ơA�u�ݪ�������
                newPixel = originalImage(x,y);
            elseif ( (x == fix(x)) & (y ~= fix(y)) ) == 1 % �Yx��y��@����ơA�u�ݰ��D��ƪ��Ӻ��׽u���ܤ�
                % f(y) = ay + b
                % ��X�Y��a�Bb
                y1 = fix(y); % �̱���y�B��y�p��col
                y2 = y1 + 1; % �̱���y�B��y�j��col
                f1 = originalImage(x,y1);
                f2 = originalImage(x,y2);
                a = f2 - f1;
                b = y2*f1 - y1*f2;
                newPixel = a*y + b;
            elseif ( (x ~= fix(x)) & (y == fix(y)) ) == 1
                % f(x) = ax + b
                % ��X�Y��a�Bb
                x1 = fix(x); % �̱���x�B��x�p��col
                x2 = x1 + 1; % �̱���x�B��x�j��col
                f1 = originalImage(x1,y);
                f2 = originalImage(x2,y);
                a = f2 - f1;
                b = x2*f1 - x1*f2;
                newPixel = a*x + b;
            else % �Yx�By�ҫD��ơA�ݭn���I����4�Ӿ���I
                x1 = fix(x); % x�̪񪺳̤p���
                x2 = x1 + 1; % x�̪񪺳̤j���  
                y1 = fix(y); % y�̪񪺳̤p���
                y2 = y1 + 1; % y�̪񪺳̤j���
                % f(x,y) = a0 + a1x + a2y + a3xy
                % ��X�Y��a0�Ba1�Ba2�Ba3
                % Qxy = f(x,y) Q11 = f(x1,y1)
                % �����ѷӺ���ʬ� https://en.wikipedia.org/wiki/Bilinear_interpolation
                Q11 = originalImage(x1, y1); % ���W������I
                Q12 = originalImage(x1, y2); % �k�W������I
                Q21 = originalImage(x2, y1); % ���U������I
                Q22 = originalImage(x2, y2); % �k�U������I
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

