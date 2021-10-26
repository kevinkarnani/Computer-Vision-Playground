function distance = d(p1, p2)
%D Summary of this function goes here
%   Detailed explanation goes here
    distance = sqrt(sum((p1 - p2) .^ 2));
end

