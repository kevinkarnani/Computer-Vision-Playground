function verticalSeam = findOptimalSeam(energyImage)
%FINDOPTIMALSEAM Summary of this function goes here
%   Detailed explanation goes here
    [rows, cols] = size(energyImage);
    M = zeros(rows, cols);
    M(1, :) = energyImage(1, :);
    for i = 2:rows
        for j = 2:cols - 1
            M(i, j) = energyImage(i, j) + min(M(i - 1, j - 1:j + 1));
        end
        % edge cases
        M(i, 1) = energyImage(i, 1) + min(M(i - 1, 1:2));
        M(i, cols) = energyImage(i, cols) + min(M(i - 1, cols - 1:cols));
    end

    verticalSeam = zeros(rows, 1);
    [~, index] = min(M(rows, :));
    verticalSeam(rows) = index;
    for i = 1:rows - 1
        if index == cols
            [~, idx] = min(M(rows - i, cols - 1:cols)); 
        elseif index == 1
            [~, idx] = min(M(rows - i, 1:2));
            idx = idx + 1;
        else
            [~, idx] = min(M(rows - i, verticalSeam(rows - i + 1) - 1:verticalSeam(rows - i + 1) + 1)); 
        end
        if idx >= 1 && idx <= 3
            index = verticalSeam(rows - i + 1) + idx - 2;
        end
        verticalSeam(rows - i) = index;
    end
end