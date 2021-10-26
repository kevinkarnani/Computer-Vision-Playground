%%% 2. Read in images and plot against exposure
clear;

fid = fopen('memorial/images.txt', 'r');
data = textscan(fid, '%s %f', 'headerlines', 1);
fclose(fid);
names = data{1};
exposures = data{2};
image_array = zeros(768, 512, 3, 16);
rng(5);

for i=1:numel(names)
    name = sprintf('memorial/%s', names{i});
    f = imread(name);
    image_array(:,:,:,i) = f;
end

rand_x = randsample(768, 3);
rand_y = randsample(512, 3);

y1 = zeros(16, 1);
y2 = zeros(16, 1);
y3 = zeros(16, 1);


for i=1:16
    y1(i) = image_array(rand_x(1), rand_y(1), 1, i);
    y2(i) = image_array(rand_x(2), rand_y(2), 1, i);
    y3(i) = image_array(rand_x(3), rand_y(3), 1, i);
end

figure; plot(exposures, y1, '-o', exposures, y2, '-o', exposures, y3, '-o');
legend('Pixel 1', 'Pixel 2', 'Pixel 3');

%%% 3. Plot against irradiance

D = 256; %number of possible values for z
N = 1024;
L = 16;
E = exposures;
Z = zeros(N, L);
rand_x_i = randsample(768, N, true);
rand_y_i = randsample(512, N, true);

for i = 1:N
    for j = 1:L
        Z(i, j) = image_array(rand_x_i(i), rand_y_i(i), 1, j);
    end
end

A = zeros(N * L + 1, D + N);
b = zeros(1, N * L + 1);

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
A(k, 127) = 1;
b(k) = 0;
x = A \ b';
g = x(1:D);

ln_r = zeros(3, L);


for i = 1:3
    for j = 1:L
        ln_r(i, j) = ln_r(i, j) + g(image_array(rand_x(i), rand_y(i), 1, j) + 1) - log(E(j));
    end
end

figure; plot(exposures, ln_r(1, :), '-o', exposures, ln_r(2, :), '-o', exposures, ln_r(3, :), '-o');
legend('Pixel 1', 'Pixel 2', 'Pixel 3');

%%% 4. Generate HDR Image and Tonemap

D = 256; %number of possible values for z
N = 1024;
L = 16;
E = exposures;

Z_red = Z;
Z_green = zeros(N, L);
Z_blue = zeros(N, L);

for i = 1:N
    for j = 1:L
        Z_green(i, j) = image_array(rand_x_i(i), rand_y_i(i), 2, j);
        Z_blue(i, j) = image_array(rand_x_i(i), rand_y_i(i), 3, j);
    end
end

A_red = zeros(N * L + 1, D + N);
A_green = zeros(N * L + 1, D + N);
A_blue = zeros(N * L + 1, D + N);
b = zeros(1, N * L + 1);

k = 1;
for loc = 1:N
    for exposure = 1:L
        z_red = Z_red(loc, exposure);
        z_green = Z_green(loc, exposure);
        z_blue = Z_blue(loc, exposure);
        A_red(k, z_red + 1) = 1; % assign a one to the location in g for z
        A_green(k, z_green + 1) = 1;
        A_blue(k, z_blue + 1) = 1;
        A_red(k, D + loc) = -1; %mark this location as -1 for pix location
        A_green(k, D + loc) = -1;
        A_blue(k, D + loc) = -1;
        b(k) = log(E(exposure)); %this pixel’s exposure length
        k = k + 1;
    end
end

A_red(k, 127) = 1;
A_green(k, 127) = 1;
A_blue(k, 127) = 1;
b(k) = 0;
x_red = A_red \ b';
g_red = x_red(1:D);
x_green = A_green \ b';
g_green = x_green(1:D);
x_blue = A_blue \ b';
g_blue = x_blue(1:D);

rows = 768;
cols = 512;

ln_r_red = zeros(rows, cols);
ln_r_green = zeros(rows, cols);
ln_r_blue = zeros(rows, cols);

for i = 1:rows
    for j = 1:cols
        for k = 1:L
            ln_r_red(i, j) = ln_r_red(i, j) + g_red(image_array(i, j, 1, k) + 1) - log(E(k));
            ln_r_green(i, j) = ln_r_green(i, j) + g_green(image_array(i, j, 2, k) + 1) - log(E(k));
            ln_r_blue(i, j) = ln_r_blue(i, j) + g_blue(image_array(i, j, 3, k) + 1) - log(E(k));
        end
    end
end

ln_r_red = ln_r_red / L;
ln_r_green = ln_r_green / L;
ln_r_blue = ln_r_blue / L;

r_red = exp(ln_r_red);
r_green = exp(ln_r_green);
r_blue = exp(ln_r_blue);

hdr = cat(3, r_red, r_green, r_blue);

sdr_naive = (hdr - min(hdr(:))) ./ (max(hdr(:)) - min(hdr(:)));

hdr_tone = hdr ./ (1 + hdr);

sdr_tone = (hdr_tone - min(hdr_tone(:))) ./ (max(hdr_tone(:)) - min(hdr_tone(:)));

figure; imshow(hdr);
figure; imshow(sdr_naive);
figure; imshow(sdr_tone);
