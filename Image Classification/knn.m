function knn(d, k, flag)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    files = dir(d);
    
    [X, Y] = representation(files, d, flag);
    
    [Xtrain, Xvalid, Ytrain, Yvalid, indsTest] = split(X, Y);
    
    Ypred = train(Xvalid, Xtrain, Ytrain, k);
    
    accuracy(Ypred, Yvalid, indsTest, files, d, flag);
end

