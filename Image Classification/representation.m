function [X, Y] = representation(files, d, flag)
%REPRESENTATION Summary of this function goes here
%   Detailed explanation goes here
    X = [];
    Y = [];
    
    for f = files'
        if ~f.isdir
            im = imread([d, '/', f.name]);
            if strcmp(flag, 'histogram')
                fv = imhist(im);
            else
                fv = gist(im);
            end
            X(end + 1, :) = fv;
            Y(end + 1, 1) = ~strcmp(f.name(1:3), 'neg');
        end
    end
end

