clc;
clear;

img = imread('modi.jpg');
[M, N, C] = size(img);

gray = zeros(M, N);
if C == 3
    for i = 1:M
        for j = 1:N
            r = double(img(i,j,1));
            g = double(img(i,j,2));
            b = double(img(i,j,3));
            gray(i,j) = 0.2989*r + 0.5870*g + 0.1140*b;
        end
    end
else
    gray = double(img);
end

avg_kernel = ones(3,3) / 9;
avg_filtered = conv2_manually(gray, avg_kernel);

sigma = 1;
gaussian_kernel = fspecial_gaussian(3, sigma);
gaussian_filtered = conv2_manually(gray, gaussian_kernel);

laplacian_kernel = [0 -1 0; -1 4 -1; 0 -1 0];
laplacian_filtered = conv2_manually(gray, laplacian_kernel);

sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = sobel_x';
gx = conv2_manually(gray, sobel_x);
gy = conv2_manually(gray, sobel_y);
sobel_filtered = sqrt(gx.^2 + gy.^2);

median_filtered = median_filter(gray, 3);

figure;
subplot(2,3,1); imshow(uint8(gray)); title('Grayscale');
subplot(2,3,2); imshow(uint8(avg_filtered)); title('Average Filter');
subplot(2,3,3); imshow(uint8(gaussian_filtered)); title('Gaussian Filter');
subplot(2,3,4); imshow(uint8(laplacian_filtered)); title('Laplacian Filter');
subplot(2,3,5); imshow(uint8(sobel_filtered)); title('Sobel Filter');
subplot(2,3,6); imshow(uint8(median_filtered)); title('Median Filter');

function output = conv2_manually(img, kernel)
    [m, n] = size(img);
    [km, kn] = size(kernel);
    pad_m = floor(km / 2);
    pad_n = floor(kn / 2);
    padded = padarray(img, [pad_m, pad_n], 'replicate', 'both');
    output = zeros(m, n);
    for i = 1:m
        for j = 1:n
            region = padded(i:i+km-1, j:j+kn-1);
            output(i,j) = sum(sum(region .* kernel));
        end
    end
end

function kernel = fspecial_gaussian(size, sigma)
    [x, y] = meshgrid(-floor(size/2):floor(size/2), -floor(size/2):floor(size/2));
    kernel = exp(-(x.^2 + y.^2) / (2*sigma^2));
    kernel = kernel / sum(kernel(:));
end

function output = median_filter(img, win_size)
    [m, n] = size(img);
    pad = floor(win_size / 2);
    padded = padarray(img, [pad, pad], 'replicate', 'both');
    output = zeros(m, n);
    for i = 1:m
        for j = 1:n
            window = padded(i:i+win_size-1, j:j+win_size-1);
            output(i,j) = median(window(:));
        end
    end
end
