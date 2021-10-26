%% Part 2

I = [1 2 5 0;
    2 2 4 1;
    2 2 5 1;
    1 1 1 1;]';
[w, h] = size(I);
W = zeros([w * h, w * h]);
[rows, cols] = ind2sub([w h], 1:w*h);
for i = 1:w * h
    for j = 1:w * h
        W(i,j) = (I(i) - I(j))^2 + (rows(i) - rows(j))^2 + (cols(i) - cols(j))^2;
    end
end
latex(sym(W));
%% Part 3

W = exp(-W);
latex(sym(vpa(fix(W * 10^2) / 10^2)));
D = diag(sum(W));
latex(sym(vpa(fix(D * 10^2) / 10^2)));
A = D - W;
latex(sym(vpa(fix(A * 10^2) / 10^2)));
[U,S,V] = svd(A);
latex(sym(vpa(fix(U * 10^2) / 10^2)));
latex(sym(vpa(fix(S * 10^2) / 10^2)));
latex(sym(vpa(fix(V * 10^2) / 10^2)));