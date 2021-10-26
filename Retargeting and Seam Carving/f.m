function fp = f(color, d1, d2, d3, d4)
%F Summary of this function goes here
%   Detailed explanation goes here
    fp = color .* ((1 / d1) / (1 / d1 + 1 / d2 + 1 / d3 + 1 / d4));
end

