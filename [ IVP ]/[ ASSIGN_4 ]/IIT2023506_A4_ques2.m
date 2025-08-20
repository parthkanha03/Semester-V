% IIT2023501_A4_ques2.m
% --------------------------------------------------------------
% Question 2: Perform histogram equalization on the grayscale
% image from Question 1 (photo(1).jpg). Show original and equalized
% images side by side.
% --------------------------------------------------------------

clc; clear; close all;

% ---- Read grayscale image (use same image from Q1) ----
imgPath = 'photo(1).jpg';
I = imread(imgPath);

% If RGB, convert to grayscale manually
if ndims(I) == 3
    I = double(I);
    R = I(:,:,1); G = I(:,:,2); B = I(:,:,3);
    Y = 0.299*R + 0.587*G + 0.114*B;  % manual grayscale conversion
    Gs = uint8(round(Y));
else
    Gs = I;
end

% ---- Histogram equalization (manual implementation) ----
[h, w] = size(Gs);
numPixels = h * w;

% 1. Compute histogram
histCounts = zeros(1,256);
for i = 1:h
    for j = 1:w
        val = Gs(i,j);
        histCounts(val+1) = histCounts(val+1) + 1;
    end
end

% 2. Compute normalized cumulative distribution function (CDF)
cdf = cumsum(histCounts) / numPixels;

% 3. Map old intensities to new ones using CDF
mapping = uint8(round(255 * cdf));
eqImg = zeros(h,w,'uint8');
for i = 1:h
    for j = 1:w
        eqImg(i,j) = mapping(Gs(i,j)+1);
    end
end

% ---- Show original and equalized images side by side ----
figure('Name','Histogram Equalization','NumberTitle','off');
subplot(1,2,1); imshow(Gs); title('Original Grayscale');
subplot(1,2,2); imshow(eqImg); title('Equalized Image');

% ---- Save outputs ----
outdir = 'A4_outputs';
if ~exist(outdir,'dir'), mkdir(outdir); end
imwrite(Gs, fullfile(outdir,'Q2_original.png'));
imwrite(eqImg, fullfile(outdir,'Q2_equalized.png'));

disp('Done. Saved histogram equalization results in A4_outputs folder.');
