% Read your 8-bit grayscale image
img = imread('parth.png'); % Replace with your actual filename

% Make sure it's grayscale
if size(img,3) == 3
    img = rgb2gray(img);
end

% a. Transpose
img_transpose = img';

% b. Flip vertically (top to bottom)
img_flip_vertical = flipud(img);

% c. Flip horizontally (left to right)
img_flip_horizontal = fliplr(img);

% d. Flip diagonally (main diagonal, equivalent to transpose + vertical flip)
img_flip_diagonal = flipud(img');
% Alternatively, you can use: img_flip_diagonal = rot90(img, -1);

% Display all results
figure;
subplot(2,3,1); imshow(img); title('Original');
subplot(2,3,2); imshow(img_transpose); title('Transpose');
subplot(2,3,3); imshow(img_flip_vertical); title('Flip Vertical');
subplot(2,3,4); imshow(img_flip_horizontal); title('Flip Horizontal');
subplot(2,3,5); imshow(img_flip_diagonal); title('Flip Diagonal');

% Optionally, save the results
imwrite(img_transpose, 'yourpic_transpose.png');
imwrite(img_flip_vertical, 'yourpic_flip_vertical.png');
imwrite(img_flip_horizontal, 'yourpic_flip_horizontal.png');
imwrite(img_flip_diagonal, 'yourpic_flip_diagonal.png');
