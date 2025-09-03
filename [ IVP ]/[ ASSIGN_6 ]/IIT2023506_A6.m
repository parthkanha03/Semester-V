


img = imread('apj_sir_1.jpg'); % Change 'face.jpg' to your filename
if size(img,3) == 3
    gray = rgb2gray(img);
else
    gray = img;
end
imwrite(gray, 'gray_face.jpg');
figure, imshow(gray), title('Grayscale Image');


gaussian_noisy = imnoise(gray, 'gaussian', 0, 0.01);
imwrite(gaussian_noisy, 'gaussian_noisy.jpg');
figure, imshow(gaussian_noisy), title('Gaussian Noisy Image');

lowpass_filtered = imgaussfilt(gaussian_noisy, 2); 
imwrite(uint8(lowpass_filtered), 'lowpass_filtered.jpg');
figure, imshow(lowpass_filtered, []), title('Low-pass Filtered (Denoised)');


sp_noisy = imnoise(gray, 'salt & pepper', 0.02); 
imwrite(sp_noisy, 'sp_noisy.jpg');
figure, imshow(sp_noisy), title('Salt & Pepper Noisy Image');

median_filtered = medfilt2(sp_noisy, [3 3]);
imwrite(median_filtered, 'median_filtered.jpg');
figure, imshow(median_filtered), title('Median Filtered Image');


hpf_kernel = [-1 -1 -1; -1 8 -1; -1 -1 -1]; 
highpass_filtered = imfilter(double(gray), hpf_kernel, 'replicate');

highpass_filtered_norm = mat2gray(highpass_filtered);
imwrite(uint8(highpass_filtered_norm * 255), 'highpass_filtered.jpg');
figure, imshow(highpass_filtered, []), title('High-pass Filtered Image');
