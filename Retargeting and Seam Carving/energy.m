function e = energy(I)
%ENERGY Summary of this function goes here
%   Detailed explanation goes here
    grad_x = [0, 0, 0; 1, 0, -1; 0, 0, 0] / 2;
    grad_y = [0, 1, 0; 0, 0, 0; 0, -1, 0] / 2;
    % why doesnt rgb2gray work, but this does????
    % gray = 0.2989 * I(:, :, 1) + 0.5870 * I(:, :, 2) + 0.1140 * I(:, :, 3);
    e = abs(conv2(imgaussfilt(I), grad_x, 'same')) + abs(conv2(imgaussfilt(I), grad_y, 'same'));
end
