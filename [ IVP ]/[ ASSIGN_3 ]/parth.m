% IVP Lab Assignment 3 - Image Processing Steps in MATLAB
% Name: PARTH AGRAWAL
% Roll No: IIT2023506
% Date: 13.08.2025

%% 1. Load the Image
img = imread('my_picture.jpg');
figure;
imshow(img);
title('Original Image');

%% Convert to RGB if image is grayscale
if size(img,3) == 1
    img_rgb = cat(3, img, img, img);
else
    img_rgb = img;
end

%% a. Crop head
% Adjust indices as per your image
head_crop = img_rgb(41:240, 101:300, :);
figure;
imshow(head_crop);
title('Cropped Head');
disp('Head crop parameters:');
disp(['y_start: 41, y_end: 240, x_start: 101, x_end: 300']);

%% b. Crop eyes
% Adjust indices as per your image
eyes_crop = img_rgb(91:140, 141:260, :);
figure;
imshow(eyes_crop);
title('Cropped Eyes');
disp('Eyes crop parameters:');
disp(['y_start: 91, y_end: 140, x_start: 141, x_end: 260']);

%% c. Square-root and Negative of Image
img_double = im2double(img_rgb);
sqrt_img = sqrt(img_double);
neg_img = 1 - img_double;

figure;
subplot(1,2,1);
imshow(sqrt_img);
title('Square-root Image');
subplot(1,2,2);
imshow(neg_img);
title('Negative Image');

%% d. Mean, Variance, and Histogram of Original Image
mean_val = mean(img_rgb(:));
var_val = var(double(img_rgb(:)));
disp(['Original image size: ', mat2str(size(img_rgb))]);
disp(['Original image mean: ', num2str(mean_val)]);
disp(['Original image variance: ', num2str(var_val)]);

% Histogram for Blue channel (MATLAB: 3rd channel for RGB)
figure;
subplot(1,2,1);
imshow(img_rgb);
title('Original Image');
subplot(1,2,2);
imhist(img_rgb(:,:,3));
title('Histogram (Blue Channel)');
xlabel('Pixel Value');
ylabel('Count');

%% e. Grayscale Conversion, Statistics, and Histogram
if size(img_rgb,3)==3
    gray = rgb2gray(img_rgb);
else
    gray = img_rgb;
end
gray_mean = mean(gray(:));
gray_var = var(double(gray(:)));
disp(['Grayscale image size: ', mat2str(size(gray))]);
disp(['Grayscale mean: ', num2str(gray_mean)]);
disp(['Grayscale variance: ', num2str(gray_var)]);

figure;
subplot(1,2,1);
imshow(gray);
title('Grayscale Image');
subplot(1,2,2);
imhist(gray);
title('Grayscale Histogram');
xlabel('Pixel Value');
ylabel('Count');
