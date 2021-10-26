clear;

Z = [0, 1, 1, 1; 0, 1, 2, 2; 1, 2, 3, 4; 2, 2, 3, 3; 4, 4, 4, 4; 3, 4, 4, 4];
disp(Z);

[N, L] = size(Z);
D = 5;
A = zeros(N * L + 1, D + N);
b = zeros(1, N * L + 1);
E = [1/16, 1/8, 1/4, 1/2];

k = 1;
for loc = 1:N
    for exposure = 1:L
        z = Z(loc, exposure);
        A(k, z + 1) = 1; % assign a one to the location in g for z
        A(k, D + loc) = -1; %mark this location as -1 for pix location
        b(k) = log(E(exposure)); %this pixel’s exposure length
        k = k + 1;
    end
end
A(k, 3) = 1;
disp(A);
b(k) = 0;
x = A \ b';
disp(x);
disp(b);
g = x(1:D);
disp(g);

res = zeros(N, L);
for i = 1:N
    for j = 1:L
        res(i, j) = g(Z(i, j) + 1) - log(E(j));
    end
end

res = exp(res);
disp(res);
