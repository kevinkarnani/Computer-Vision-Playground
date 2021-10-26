### 3. Read in Image, Convert to Grayscale

im = double(imread('CS435HW1.jpeg'))/255;
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

figure; imshow(uint8(im * 255));

gray_image = 0.2989 * R + 0.5870 * G + 0.1140 * B;

figure; imshow(uint8(gray_image * 255));

### 4. Grayscale to Binary

gray_25 = zeros(size(gray_image));
gray_25(gray_image > .25) = 255;
figure; imshow(uint8(gray_25));

gray_50 = zeros(size(gray_image));
gray_50(gray_image > .5) = 255;
figure; imshow(uint8(gray_50));

gray_75 = zeros(size(gray_image));
gray_75(gray_image > .75) = 255;
figure; imshow(uint8(gray_75));

### 5. Gamma Correction

c = 1;
s_R_2 = c * R.^(.2);
s_G_2 = c * G.^(.2);
s_B_2 = c * G.^(.2);

s_im_2 = cat(3, s_R_2, s_G_2, s_B_2);
figure; imshow(s_im_2);

s_R_10 = c * R.^(1);
s_G_10 = c * G.^(1);
s_B_10 = c * G.^(1);

s_im_10 = cat(3, s_R_10, s_G_10, s_B_10);
figure; imshow(s_im_10);

s_R_500 = c * R.^(50);
s_G_500 = c * G.^(50);
s_B_500 = c * G.^(50);

s_im_500 = cat(3, s_R_500, s_G_500, s_B_500);
figure; imshow(s_im_500);

### 6. Changing Hue

# ez solution - not sure if we can use hsv2rgb - commented it out

% hsv = rgb2hsv(im);
% hsv(:,:,1) = mod(hsv(:,:,1) * 360 + 50, 360) / 360;
% rgb = hsv2rgb(hsv);
% figure; imshow(rgb);

# harder solution - way more inefficient... whatever, result matches solution above

[rows, cols, _] = size(im);
rgb = zeros(size(im));

for row = 1: rows
    for col = 1: cols
        h = 0;
        s = 0;
        r = im(row, col, 1);
        g = im(row, col, 2);
        b = im(row, col, 3);
        
        cmax = max([r, g, b]);
        cmin = min([r, g, b]);
        diff = cmax - cmin;
        
        if cmax == cmin
           h = 0;
        elseif cmax == r
           h = 60 * (g - b) / diff;
           if h < 0
              h = h + 360;
           end
        elseif cmax == g
           h = 120 + 60 * (b - r) / diff;
        elseif cmax == b
           h = 240 + 60 * (r - g) / diff;
        end
        
        if cmax == 0
           s = 0;
        else
           s = diff / cmax;
        end
        
        v = cmax;
        
        h = mod(h + 50, 360);
        
        if h >= 0 && h < 60
            rgb(row, col, 1) = v;
            rgb(row, col, 2) = h/60 * diff + v - diff;
            rgb(row, col, 3) = v - diff;
        elseif h >= 60 && h < 120
            rgb(row, col, 1) = v - diff - ((h - 120) * diff / 60);
            rgb(row, col, 2) = v;
            rgb(row, col, 3) = v - diff;
        elseif h >= 120 && h < 180
            rgb(row, col, 1) = v - diff;
            rgb(row, col, 2) = v;
            rgb(row, col, 3) = (h - 120) * diff / 60 + v - diff;
        elseif h >= 180 && h < 240
            rgb(row, col, 1) = v - diff;
            rgb(row, col, 2) = v - diff - ((h - 240) * diff/60);
            rgb(row, col, 3) = v;
        elseif h >= 240 && h < 300
            rgb(row, col, 1) = (h - 240) * diff / 60 + v - diff;
            rgb(row, col, 2) = v - diff;
            rgb(row, col, 3) = v;
        else
            rgb(row, col, 1) = v;
            rgb(row, col, 2) = v - diff;
            rgb(row, col, 3) = v - diff - ((h - 360) * diff/60);
        end
    end
end

figure; imshow(rgb);


### 7. Histograms

bins_gray = zeros(1, 256);
bins_R = zeros(1, 256);
bins_G = zeros(1, 256);
bins_B = zeros(1, 256);

gray_image = uint8(gray_image * 255);
R = uint8(R * 255);
G = uint8(G * 255);
B = uint8(B * 255);

flatX_gray = reshape(gray_image, 1, numel(gray_image));
flatX_R = reshape(R, 1, numel(R));
flatX_G = reshape(G, 1, numel(G));
flatX_B = reshape(B, 1, numel(B));

for val = 0:255
    bins_gray(val + 1) = sum(flatX_gray == val);
    bins_R(val + 1) = sum(flatX_R == val);
    bins_G(val + 1) = sum(flatX_G == val);
    bins_B(val + 1) = sum(flatX_B == val);
end
bins_gray = bins_gray/sum(bins_gray);
bins_R = bins_R/sum(bins_R);
bins_G = bins_G/sum(bins_G);
bins_B = bins_B/sum(bins_B);

figure; bar(1:256, bins_gray);
figure; bar(1:256, bins_R);
figure; bar(1:256, bins_G);
figure; bar(1:256, bins_B);