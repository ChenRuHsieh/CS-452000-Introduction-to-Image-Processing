function resizedImage = resizeImage_replication(originalImage, scalingFactor)
    % originalImage: �٨S resize ����v��
    % scalingFactor: resize �� scale (�Ҧp�n��j���⭿: 2�F�Y�p���@�b: 1/2)
    % resizedImage: resize �᪺�v��
    [r,c] =size(originalImage); % ���o��J��imgae�j�p
    newR  = round(r*scalingFactor); % �s�Ϥ���row�ƶq�A�|�ˤ��J�i���
    newC  = round(c*scalingFactor); % �s�Ϥ���col�ƶq�A�|�ˤ��J�i���
    resizedImage = zeros(newR,newC); % ����output�۹������j�p
    rLevel = (r-1) / (newR - 1);
    cLevel = (c-1) / (newC - 1);
    for i = 1 : newR
        for j = 1 : newC
            R = (i-1)*rLevel + 1; % ��i�ӷs�Ϫ�row �����b ��R���¹Ϫ�row
            C = (j-1)*cLevel + 1; % ��j�ӷs�Ϫ�col �����b ��C���¹Ϫ�col
            %�YR��C���p�ơA�ݭn��̪񪺾��
            minR = fix(R); % R�̪񪺳̤p���
            maxR = minR + 1; % R�̪񪺳̤j���  
            minC = fix(C); % C�̪񪺳̤p���
            maxC = minC + 1; % C�̪񪺳̤j���
            %��row�����j�p
            if (R-minR) <= (maxR-R) % ����a��p��row
                replaceR = minR; % ���p��row
            else % ����a��j��row
                replaceR = maxR; % ���j��row
            end
            %��col���B�z�A�Prow
            if (C-minC) <= (maxC-C)
                replaceC = minC;
            else
                replaceC = maxC;
            end
            resizedImage(i,j) = originalImage(replaceR, replaceC);
        end
    end
end

