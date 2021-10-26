function smooth = smoothing(image, N, sig)
    %SMOOTHING Summary of this function goes here
    %   Detailed explanation goes here
    G = zeros(N);

    for i = 1:N
        for j = 1:N
            G(i, j) = exp(-((i - (N + 1)/2)^2 + (j - (N + 1)/2)^2) / (2 * sig^2));
        end
    end
    
    G = round(G ./ min(G(:)));
    G = G ./ sum(G, 2);
    
    smooth = convolve(image, G);
end