function Ypred = train(Xvalid, Xtrain, Ytrain, k)
%TRAIN Summary of this function goes here
%   Detailed explanation goes here
    Ypred = zeros(size(Xvalid, 1), 1);
    
    for i = 1:size(Xvalid, 1)
        distances = zeros(size(Xtrain, 1), 1);
        for j = 1:size(Xtrain, 1)
            distances(j, 1) = sum(min(Xvalid(i, :), Xtrain(j, :)));
        end

        [~, indices] = sort(distances, 'descend');
        Ypred(i, 1) = mode(Ytrain(indices(1:k), :));
    end
end

