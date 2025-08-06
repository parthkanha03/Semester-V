%% IVP Lab Assignment 1
% Name: PARTH AGRAWAL
% Roll No: IIT2023506
% Date: 06.08.2025

%% 1. Basic Arithmetic Operations
a = 15;
b = 5;

sum_ab = a + b;
diff_ab = a - b;
prod_ab = a * b;
div_ab = a / b;

disp('--- Basic Arithmetic Operations ---');
fprintf('Sum: %d\n', sum_ab);
fprintf('Difference: %d\n', diff_ab);
fprintf('Product: %d\n', prod_ab);
fprintf('Division: %.2f\n\n', div_ab);

%% 2. Read and Display an Image from Computer
img = imread('parth.png');  % Replace with your image file
figure;
imshow(img);
title('Original Image');

%% 3. Convert to Grayscale and Show Side-by-Side
if size(img, 3) == 3
    gray_img = rgb2gray(img);
else
    gray_img = img;
end

figure;
subplot(1,2,1);
imshow(img);
title('Original Image');

subplot(1,2,2);
imshow(gray_img);
title('Grayscale Image');

%% 4. Plot Histogram of the Image
figure;
if size(img, 3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

imhist(img_gray);
title('Histogram of Grayscale Image');

%% 5. Rotate Image by 45 Degrees
rotated_img = imrotate(img, 45, 'bilinear', 'crop');
figure;
imshow(rotated_img);
title('Image Rotated by 45 Degrees');
