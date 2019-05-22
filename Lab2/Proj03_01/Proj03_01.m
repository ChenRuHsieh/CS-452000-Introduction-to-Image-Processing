clear all;
input = imread('Fig0308(a)(fractured_spine).tif');
inputSingle  = single(input) / 255; % uint8�নsingle
log = single(logTransform(inputSingle));
imwrite(log,'log_c=log���Z.png');
subplot(2,4,1);imshow(inputSingle),title('��l�Ϥ�'); % ��ܭ�l�Ϥ�
subplot(2,4,2);imshow(log),title('Log'); % ���LogTransform���Ϥ�
for i = 1 : 5
    switch i 
        case 1
            r = 0.3;
        case 2 
            r = 0.4;
        case 3
            r = 0.6;
        case 4
            r = 2;
        case 5
            r = 5;
        otherwise
            r = 0;
    end
    powerLaw = single(powerlawTransform(inputSingle, r));
    subplot(2,4,2+i);imshow(powerLaw); % ���PowerLawTransform���Ϥ�
    switch i 
        case 1
            title('PowerLaw, r = 0.3');
            imwrite(powerLaw,'PowerLaw_r=0.3.png');
        case 2 
            title('PowerLaw, r = 0.4');
            imwrite(powerLaw,'PowerLaw_r=0.4.png');
        case 3
            title('PowerLaw, r = 0.6');
            imwrite(powerLaw,'PowerLaw_r=0.6.png');
        case 4
            title('PowerLaw, r = 2');
            imwrite(powerLaw,'PowerLaw_r=2.png');
        case 5
            title('PowerLaw, r = 5');
            imwrite(powerLaw,'PowerLaw_r=5.png');
        otherwise
            title('PowerLaw, r = 0');
    end
end

