function new = seamCarving(I, seam)
    %SEAMCARVING Summary of this function goes here
    %   Detailed explanation goes here
    % seam = findOptimalSeam(energy(I));
    [rows, cols, ~] = size(I);

    new = zeros(rows, cols - 1, 3);

    for i = 1:rows
        new(i, 1:seam(i) - 1, :) = I(i, 1:seam(i) - 1, :);
        new(i, seam(i):size(new, 2), :) = I(i, seam(i) + 1:size(I, 2), :);
    end
end

