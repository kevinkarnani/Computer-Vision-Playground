function R = nearestNeighbor(I, w, h)
%NEARESTNEIGHBOR Summary of this function goes here
%   Detailed explanation goes here
    R = zeros(w, h, 3);
    scale_x = size(I, 1)/w;
    scale_y = size(I, 2)/h;
    
    for i = 1:w
        for j = 1:h
            R(i, j, :) = I(round(i * scale_x), round(j * scale_y), :);
        end
    end
end

