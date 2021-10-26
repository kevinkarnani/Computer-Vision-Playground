function cannyEdgeDetector(image_path, low, high, N, sig)
    % 2. Apply gaussian smoothing
    img = rgb2gray(imread(image_path));
    figure; imshow(img); title('Original'); %1

    s1 = smoothing(img, N, sig);
    figure; imshow(uint8(s1)); title('Smoothing, NxN, sig=1'); %2

    % 3. Applying Gradient

    grad_x = [0, 0, 0; 1, 0, -1; 0, 0, 0] / 2;
    gx = abs(convolve(img, grad_x));
    figure; imshow(uint8(gx)); title('Gradient X'); %6

    grad_y = [0, 1, 0; 0, 0, 0; 0, -1, 0] / 2;
    gy = abs(convolve(img, grad_y));
    figure; imshow(uint8(gy)); title('Gradient Y'); %7

    grad = grad_y + grad_x;
    g = abs(convolve(img, grad));
    figure; imshow(uint8(g)); title('Gradient X + Gradient Y'); %8

    gx_smooth = smoothing(gx, N, sig);
    figure; imshow(uint8(gx_smooth)); title('Smoothing, NxN, sig=1 + Gradient X'); %9

    gy_smooth = smoothing(gy, N, sig);
    figure; imshow(uint8(gy_smooth)); title('Smoothing, NxN, sig=1 + Gradient Y'); %10

    g_smooth = smoothing(g, N, sig);
    figure; imshow(uint8(g_smooth)); title('Smoothing, NxN, sig=1 + Gradient X + Gradient Y'); %11

    % 4. Threshold

    g_smooth_01 = zeros(size(g_smooth));
    g_smooth_01(g_smooth / 255 > .1) = 255;
    figure; imshow(uint8(g_smooth_01)); title('Binary 10%');%12

    g_smooth_30 = zeros(size(g_smooth));
    g_smooth_30(g_smooth / 255 > .3) = 255;
    figure; imshow(uint8(g_smooth_30)); title('Binary 30%'); %13

    g_smooth_99 = zeros(size(g_smooth));
    g_smooth_99(g_smooth / 255 > .99) = 255;
    figure; imshow(uint8(g_smooth_99)); title('Binary 99%'); %14

    % 5. Hysterisis

    g_hys = hysterisis(g_smooth, low, high);
    figure; imshow(uint8(g_hys)); title('Hysterisis'); %15

    % 6. Non-Max Suppression
    g_new = convolve(img, grad_y) + convolve(img, grad_x);
    thetas = atan(convolve(img, grad_y) ./ convolve(img, grad_x));
    g_nms = NMS(g_hys, g_new, thetas + pi / 2);
    figure; imshow(uint8(g_nms)); title('Non-Max Suppression'); %16
end