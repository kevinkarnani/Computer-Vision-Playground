k = 5;
W = zeros(k, k);
sig = 1;

for i = 1:k
    for j = 1:k
        W(i, j) = exp(-((i - (k + 1)/2)^2 + (j - (k + 1)/2)^2)/(2 * sig));
    end
end

W = round(W ./ min(W(:)));

W = W ./ sum(W, 2);

