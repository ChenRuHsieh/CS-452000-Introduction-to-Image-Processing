function [output, scaledLaplacian] = laplacianFiltering(input, laplacianMask, scale)
%{
    input: a 2-D grayscale image data, type single, range 0~1
    output: a 2-D grayscale image data, type single, range0~1
    laplacianMask: a 2-D laplacian mask 
    scale: c in Eq. (3.6-7)
    scaledLaplacian: a 2-D matrix of c * [?2f(x,y)] in Eq. (3.6-7), type single
    g(x,y) = f(x,y) + c * [?^2f(x,y)]
    
%}
    laplacianInput = spatialFiltering(input,laplacianMask);
    scaledLaplacian = scale * laplacianInput;
    output = single(input + scaledLaplacian);
    [row,col] = size(output);
    for i = 1 : row
        for j = 1 : col
            if(output(i,j) > 1)
                output(i,j) = 1;
            elseif(output(i,j) < 0)
                output(i,j) = 0;
            end
        end
    end
end

