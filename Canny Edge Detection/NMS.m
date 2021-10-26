function I = NMS(I, G, A)
    %NMS Summary of this function goes here
    %   Detailed explanation goes here
    for i = 1:size(I, 1)
        for j = 1:size(I, 2)
            if I(i, j) == 255 && i - 1 > 0 && i + 1 < size(I, 1) && j - 1 > 0 && j + 1 < size(I, 2)
                conds = [(A(i, j) < pi / 8 || A(i, j) >= 7 * pi / 8) && (G(i, j + 1) > G(i, j) || G(i, j - 1) > G(i, j)),...
                        (A(i, j) < 3 * pi / 8 && A(i, j) >= pi / 8) && (G(i - 1, j + 1) > G(i, j) || G(i + 1, j - 1) > G(i, j)),...
                        (A(i, j) < 5 * pi / 8 && A(i, j) >= 3 * pi / 8) && (G(i - 1, j) > G(i, j) || G(i + 1, j) > G(i, j)),...
                        (A(i, j) < 7 * pi / 8 && A(i, j) >= 5 * pi / 8) && (G(i - 1, j - 1) > G(i, j) || G(i + 1, j + 1) > G(i, j))];
                if any(conds)
                    I(i, j) = 0;
                end
            end
        end
    end
end