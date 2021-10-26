function im_arr = gist(im)
%GIST Summary of this function goes here
%   Detailed explanation goes here
    im_cell = mat2cell(im, [20 20], [20 20 20 20 20]);

    grad_x = [0, 0, 0; 1, 0, -1; 0, 0, 0] / 2;
    grad_y = [0, 1, 0; 0, 0, 0; 0, -1, 0] / 2;
    
    bins = (0:45:360) .* (pi / 180);
    im_arr = zeros(80, 1);

    for i=1:10

        Gx = conv2(im_cell{i}, grad_x, "same");
        Gy = conv2(im_cell{i}, grad_y, "same");
        
        thetas = atan2(Gy, Gx);
        
        thetas(thetas < 0) = thetas(thetas < 0) + 2 * pi;
        
        discretized = discretize(thetas, bins);
        
        x = zeros(8, 1);
        for j = 1:8
          x(j) = sum(discretized == j, 'all');
        end

        im_arr(8 * (i - 1) + 1:8 * i, :) = x;
    end
end

