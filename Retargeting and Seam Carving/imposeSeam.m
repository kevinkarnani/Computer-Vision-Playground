function I = imposeSeam(I, s)
%IMPOSESEAM Summary of this function goes here
%   Detailed explanation goes here
    for i = 1:size(I, 1)
        I(i, s(i), 1) = 255;
        I(i, s(i), 2:3) = 0;
    end
end
