clc; clear; close all;
img1 = imread('first_name.png');
img2 = imread(['last_name.png']);
img1 = rgb2gray(img1);
img2 = rgb2gray(img2);
img1 = imresize(img1, [180 180]);
img2 = imresize(img2, [180 180]);
img1_d = double(img1);
img2_d = double(img2);
complement1 = zeros(180, 180);
complement2 = zeros(180, 180);
union_img = zeros(180, 180);
intersect_img = zeros(180, 180);
for i = 1:180
    for j = 1:180
        complement1(i,j) = 255 - img1_d(i,j);
        complement2(i,j) = 255 - img2_d(i,j);
        if img1_d(i,j) > img2_d(i,j)
            union_img(i,j) = img1_d(i,j);
        else
            union_img(i,j) = img2_d(i,j);
        end
        if img1_d(i,j) < img2_d(i,j)
            intersect_img(i,j) = img1_d(i,j);
        else
            intersect_img(i,j) = img2_d(i,j);
        end
    end
end
complement1 = uint8(complement1);
complement2 = uint8(complement2);
union_img = uint8(union_img);
intersect_img = uint8(intersect_img);
imwrite(complement1, 'complement_img1.png');
imwrite(complement2, 'complement_img2.png');
imwrite(union_img, 'union_img.png');
imwrite(intersect_img, 'intersect_img.png');
figure, subplot(2,3,1), imshow(img1), title('Img1');
subplot(2,3,2), imshow(complement1), title('Complement Img1');
subplot(2,3,3), imshow(img2), title('Img2');
subplot(2,3,4), imshow(complement2), title('Complement Img2');
subplot(2,3,5), imshow(union_img), title('Union');
subplot(2,3,6), imshow(intersect_img), title('Intersection');