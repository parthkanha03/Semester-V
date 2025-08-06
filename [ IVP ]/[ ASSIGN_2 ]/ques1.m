% Size of the image
rows = 180;
cols = 180;

% Create a 1D ramp: 
% First half from 0 to 255, second half from 255 to 0
left_ramp = linspace(0, 255, cols/2);     % 90 values from 0 to 255
right_ramp = linspace(255, 0, cols/2);    % 90 values from 255 to 0

% Combine into a full row
ramp_row = [left_ramp, right_ramp];       % 1 x 180 row

% Replicate the row to form a 180x180 image
ramp_image = repmat(ramp_row, rows, 1);

% Convert to uint8 for image display
ramp_image = uint8(ramp_image);

% Display the image
imshow(ramp_image);
title('Grayscale Ramp: Black→White | White→Black');

% Optionally, save the image
imwrite(ramp_image, 'grayscale_ramp.png');
