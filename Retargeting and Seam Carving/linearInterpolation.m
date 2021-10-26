function R = linearInterpolation(I, w, h)
%LINEARINTERPOLATION Summary of this function goes here
%   Detailed explanation goes here
    R = zeros(w, h, 3);
    scale_x = size(I, 1) / w;
    scale_y = size(I, 2) / h;
    
    for i = 1:w
        for j = 1:h
            p = [i * scale_x, j * scale_y];
            A = [floor(i * scale_x), floor(j * scale_y)];
            B = [floor(i * scale_x), ceil(j * scale_y)];
            C = [ceil(i * scale_x), floor(j * scale_y)];
            D = [ceil(i * scale_x), ceil(j * scale_y)];
            dA = 1 / d(p, A);
            dB = 1 / d(p, B);
            dC = 1 / d(p, C);
            dD = 1 / d(p, D);
            fA = f(I(A(1), A(2), :), dA, dB, dC, dD);
            fB = f(I(B(1), B(2), :), dB, dA, dC, dD);
            fC = f(I(C(1), C(2), :), dC, dB, dA, dD);
            fD = f(I(D(1), D(2), :), dD, dB, dC, dA);
            R(i, j, :) = fA + fB + fC + fD;
        end
    end
end

