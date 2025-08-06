% Create a 180x180 black image
img = zeros(180, 180);

% Image center
cx = 90;
cy = 90;

% Radius of the circle
r = 90;

% Side of the square (diagonal = diameter of circle)
side = r * sqrt(2);
half_side = side / 2;

% Create a grid of coordinates
[x, y] = meshgrid(1:180, 1:180);

% Shift origin to center
x_shifted = x - cx;
y_shifted = y - cy;

% Condition for being inside the circle
in_circle = (x_shifted.^2 + y_shifted.^2) <= r^2;

% Condition for being inside the square (centered, axis-aligned)
in_square = (abs(x_shifted) <= half_side) & (abs(y_shifted) <= half_side);

% Set all pixels inside the circle to gray (to make the circle visible)
img(in_circle) = 0.3;

% Set pixels inside both the square and the circle to white
img(in_circle & in_square) = 1;

% Display the image
imshow(img);
