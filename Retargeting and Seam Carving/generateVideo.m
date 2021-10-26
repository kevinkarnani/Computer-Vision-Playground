function I = generateVideo(I, filename)
    %GENERATEVIDEO Summary of this function goes here
    %   Detailed explanation goes here
    writer = VideoWriter(filename, 'MPEG-4');
    writer.FrameRate = 60;
    open(writer);
    img = I;
    
    for i = 1:size(I, 2) - 1
        seam = findOptimalSeam(energy(img));
        writeVideo(writer, horzcat(uint8(imposeSeam(img, seam)), zeros(size(I, 1), i - 1, 3)));
        img = seamCarving(img, seam);
    end
    
    close(writer);
end


