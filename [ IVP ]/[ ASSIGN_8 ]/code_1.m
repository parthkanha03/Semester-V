clc; clear; close all;

% 1. Create a 256x256 image with your name
img = uint8(ones(256, 256) * 255); % White background
img = insertText(img, [30, 110], 'Parth Agrawal', ...
    'FontSize', 32, 'BoxOpacity', 0, 'TextColor', 'black');
img = rgb2gray(img);
img = imbinarize(img);

figure, imshow(img); title('Original Image (Parth Agrawal)');

% ---- Custom Erosion and Dilation Functions ----
% Erosion
function out = custom_erode(I, SE)
    [m, n] = size(I);
    [se_m, se_n] = size(SE);
    pad_m = floor(se_m/2);
    pad_n = floor(se_n/2);
    Ipad = padarray(I, [pad_m pad_n], 1); % pad with 1 (white for binary)
    out = false(size(I));
    for i=1:m
        for j=1:n
            region = Ipad(i:i+se_m-1, j:j+se_n-1);
            out(i,j) = all(region(SE==1)==1);
        end
    end
end

% Dilation
function out = custom_dilate(I, SE)
    [m, n] = size(I);
    [se_m, se_n] = size(SE);
    pad_m = floor(se_m/2);
    pad_n = floor(se_n/2);
    Ipad = padarray(I, [pad_m pad_n], 0); % pad with 0 (black for binary)
    out = false(size(I));
    for i=1:m
        for j=1:n
            region = Ipad(i:i+se_m-1, j:j+se_n-1);
            out(i,j) = any(region(SE==1)==1);
        end
    end
end

% 2. Erosion: Linear structuring element (length 10, angle 60)
SE_line = zeros(10,10);
for k = 1:10
    x = k;
    y = round(1 + (k-1)*tand(60));
    if y > 0 && y <= 10
        SE_line(y,x) = 1;
    end
end
SE_line = SE_line | SE_line'; % Make it symmetric if needed

img_eroded_line = custom_erode(img, SE_line);
figure, imshow(img_eroded_line); title('Erosion: Custom Linear SE (len=10, angle=60)');

% 3. Erosion: Square structuring element (4x4)
SE_square = ones(4,4);
img_eroded_square = custom_erode(img, SE_square);
figure, imshow(img_eroded_square); title('Erosion: Custom Square SE (4x4)');

% 4. Dilation: SE1
SE1 = [0 1 1; 1 1 1; 0 1 0];
img_dilated_se1 = custom_dilate(img, SE1);
figure, imshow(img_dilated_se1); title('Dilation: Custom SE1');

% 5. Dilation: SE2
SE2 = [0 1 0; 1 0 1; 0 1 0];
img_dilated_se2 = custom_dilate(img, SE2);
figure, imshow(img_dilated_se2); title('Dilation: Custom SE2');

% ---- End of Script ----