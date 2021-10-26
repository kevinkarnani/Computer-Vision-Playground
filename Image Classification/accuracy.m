function accuracy(Ypred, Yvalid, indsTest, files, d, flag)
%ACCURACY Summary of this function goes here
%   Detailed explanation goes here
    fprintf('Accuracy: %.2f\n', 100 * sum(Ypred == Yvalid, 'all') / size(Yvalid, 1));

    correct_car = files(indsTest(find(Ypred == Yvalid & Yvalid == 1, 1)) + 2).name;
    correct_not_car = files(indsTest(find(Ypred == Yvalid & Yvalid == 0, 1)) + 2).name;

    incorrect_car = files(indsTest(find(Ypred ~= Yvalid & Yvalid == 0, 1)) + 2).name;
    incorrect_not_car = files(indsTest(find(Ypred ~= Yvalid & Yvalid == 1, 1)) + 2).name;
    
    if strcmp(flag, 'histogram')
        imwrite(imread([d, '/', correct_car]), 'correct_car.png');
        imwrite(imread([d, '/', correct_not_car]), 'correct_not_car.png');
        imwrite(imread([d, '/', incorrect_car]), 'incorrect_car.png');
        imwrite(imread([d, '/', incorrect_not_car]), 'incorrect_not_car.png');
    else
        imwrite(imread([d, '/', correct_car]), 'correct_car1.png');
        imwrite(imread([d, '/', correct_not_car]), 'correct_not_car1.png');
        imwrite(imread([d, '/', incorrect_car]), 'incorrect_car1.png');
        imwrite(imread([d, '/', incorrect_not_car]), 'incorrect_not_car1.png');
    end
end


