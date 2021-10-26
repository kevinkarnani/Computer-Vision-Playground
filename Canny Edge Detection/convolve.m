function C = convolve(I, G)
    % D = conv2(I, G, 'valid');
    
    I = double(I);
    N = size(G, 1);
    C = zeros(size(I) - N + 1);
    
    for i = 1:size(I, 1)
        for j = 1:size(I, 2)
            if i - N + 1 > 0 && j - N + 1 > 0
                C(i - N + 1, j - N + 1) = sum(G .* I(i - N + 1: i, j - N + 1: j), 'all');
            end
        end
    end
end