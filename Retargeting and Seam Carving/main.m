clear;

im1 = imread('im1.jpeg');
im2 = imread('im2.jpeg');

display(['Size of Image 1: ', int2str(size(im1))]);
display(['Size of Image 2: ', int2str(size(im2))]);
w_1 = input('New Width 1:\n');
h_1 = input('New Height 1:\n');
w_2 = input('New Width 2:\n');
h_2 = input('New Height 2:\n');

imwrite(uint8(nearestNeighbor(im1, w_1, h_1)), 'NearestNeigbor1.png');
imwrite(uint8(nearestNeighbor(im1, w_2, h_2)), 'NearestNeigbor2.png');
imwrite(uint8(nearestNeighbor(im2, w_1, h_1)), 'NearestNeigbor3.png');
imwrite(uint8(nearestNeighbor(im2, w_2, h_2)), 'NearestNeigbor4.png');

imwrite(uint8(linearInterpolation(im1, w_1, h_1)), 'LinearInterpolation1.png');
imwrite(uint8(linearInterpolation(im1, w_2, h_2)), 'LinearInterpolation2.png');
imwrite(uint8(linearInterpolation(im2, w_1, h_1)), 'LinearInterpolation3.png');
imwrite(uint8(linearInterpolation(im2, w_2, h_2)), 'LinearInterpolation4.png');

energy_1 = energy(im1);
energy_2 = energy(im2);
imwrite(uint8(energy_1), 'Energy1.png');
imwrite(uint8(energy_2), 'Energy2.png');

seam_1 = findOptimalSeam(energy_1);
im1_seam = imposeSeam(im1, seam_1);

seam_2 = findOptimalSeam(energy_2);
im2_seam = imposeSeam(im2, seam_2);

imwrite(uint8(im1_seam), 'Seam1.png');
imwrite(uint8(im2_seam), 'Seam2.png');

generateVideo(im1, 'anime');
generateVideo(im2, 'tree');