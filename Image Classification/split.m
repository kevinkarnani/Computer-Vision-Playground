function [Xtrain, Xvalid, Ytrain, Yvalid, indsTest] = split(X, Y)
%SPLIT Summary of this function goes here
%   Detailed explanation goes here
    rng(3);
    inds = randperm(size(X, 1));
    num = size(X, 1) / 3;

    indsTest = inds(2 * num + 1:end);
    X = X(inds, :);
    Y = Y(inds, :);

    Xtrain = X(1:2 * num, :);
    Ytrain = Y(1:2 * num, :);

    Xvalid = X(2 * num + 1:end, :);
    Yvalid = Y(2 * num + 1:end, :);
end

