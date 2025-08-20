% A4_bitplanes.m
% --------------------------------------------------------------
% Question 1 (Image bit-planes & compression without bitget/bitset/rgb2gray)
% Reads a 256x256 face image, converts to grayscale (manual formula),
% extracts 8 bit-planes, zeroes the 4 LSB planes to "compress", computes
% the difference image, and shows all 12 images in a single figure.
% --------------------------------------------------------------

clc; clear; close all;

% ---- Read image (expects 256x256). If not found, prompt user. ----
imgPath = 'photo(1).jpg';
if ~exist(imgPath, 'file')
    [f, p] = uigetfile({'*.jpg;*.png;*.bmp;*.jpeg','Image Files'}, 'Select 256x256 facial image');
    if isequal(f,0)
        error('No image selected.');
    end
    imgPath = fullfile(p,f);
end

I = imread(imgPath);

% ---- If RGB, convert to grayscale manually (Y = 0.299R + 0.587G + 0.114B) ----
if ndims(I) == 3
    I = double(I);
    R = I(:,:,1); G = I(:,:,2); B = I(:,:,3);
    Y = 0.299*R + 0.587*G + 0.114*B;  % double
    Gs = uint8(round(Y));
else
    Gs = I;            % already grayscale
end

% ---- Ensure size is 256 x 256 (assignment says image is already 256x256) ----
[h,w] = size(Gs);
if h~=256 || w~=256
    warning('Image is %dx%d, but assignment expects 256x256.', h, w);
end

% ---- Compute 8 bit-planes without bitget/bitset ----
bitplanes = cell(1,8);
GsD = double(Gs);
for k = 0:7
    % Extract bit k: (floor(Gs/2^k) mod 2)
    plane = mod(floor(GsD / 2^k), 2);
    bitplanes{k+1} = uint8(plane * 255);  % scale to [0,255] for viewing
end

% ---- Zero out the 4 LSBs (bits 0..3) to "compress" ----
compressedD = zeros(size(GsD));
for k = 4:7    % keep bits 4..7 (0-based index)
    compressedD = compressedD + 2^k * mod(floor(GsD / 2^k), 2);
end
compressed = uint8(compressedD);

% ---- Difference between original gray and compressed (absolute) ----
diffImg = uint8(abs(double(Gs) - double(compressed)));

% ---- Make a 12-image figure ----
figure('Name','Assignment 4 - Bit Planes & Compression','NumberTitle','off');
tiledlayout(3,4,'Padding','compact','TileSpacing','compact');

% 1) Original (if color available) else grayscale
nexttile;
origDisplay = imread(imgPath);
imshow(origDisplay);
title('Original');

% 2) Grayscale
nexttile;
imshow(Gs);
title('Grayscale');

% 3..10) Bit-planes from LSB (0) to MSB (7)
for k = 1:8
    nexttile;
    imshow(bitplanes{k});
    title(sprintf('Bit-plane %d', k-1));  % label with actual bit index
end

% 11) Compressed (4 LSBs zeroed)
nexttile;
imshow(compressed);
title('Compressed (4 LSB=0)');

% 12) Difference
nexttile;
imshow(diffImg, []);
title('Difference |Gs - Comp|');

% ---- Save outputs in folder ----
outdir = 'A4_outputs';
if ~exist(outdir,'dir'), mkdir(outdir); end

imwrite(Gs, fullfile(outdir,'01_grayscale.png'));
for k = 1:8
    imwrite(bitplanes{k}, fullfile(outdir, sprintf('plane_%d.png', k-1)));
end
imwrite(compressed, fullfile(outdir,'11_compressed.png'));
imwrite(diffImg, fullfile(outdir,'12_difference.png'));

% Save montage (optional)
frame = getframe(gcf);
imwrite(frame.cdata, fullfile(outdir,'_montage.png'));

disp('Done. Saved all outputs in folder: A4_outputs');
