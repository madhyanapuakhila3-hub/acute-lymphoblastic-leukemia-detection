
function [M,I]   =ANALYZES_DETECTION(rgb)
 
    rgb = double(rgb(:,:,1:3)) / 255;   % Normalize to [0,1]

    R = rgb(:,:,1);
    G = rgb(:,:,2);
    B = rgb(:,:,3);

    K = 1 - max(max(R, G), B);

    C = (1 - R - K) ./ (1 - K);
    M = (1 - G - K) ./ (1 - K);
    Y = (1 - B - K) ./ (1 - K);

    % Handle division by zero (when K = 1)
    C(K == 1) = 0;
    M(K == 1) = 0;
    Y(K == 1) = 0;

    cmyk = cat(3, C, M, Y, K);
 
 Cout=C;
 I=Cout; 
 level = graythresh(I);

% Apply threshold
BW = imbinarize(I, level);
 

I=rgb;

I1=BW;

BW = bwareaopen(I1, 50);

% Label connected components
CC = bwconncomp(BW);

% Measure properties
stats = regionprops(CC, 'Centroid', 'EquivDiameter','BoundingBox');

% Extract diameters
diameters = [stats.EquivDiameter];

% Find maximum diameter
[~, idx] = max(diameters);

% Get centroid and radius
center = stats(idx).Centroid;
radius = stats(idx).EquivDiameter / 2;
bbox = stats(idx).BoundingBox;

imshow(I);
hold on;

% Draw circle
viscircles(center, radius, 'EdgeColor', 'r', 'LineWidth', 2);

title('WBC Detection');
hold off;
% Extract ROI
I = imcrop(I, bbox);

% Convert to grayscale if RGB
if size(I,3) == 3
    Igray = rgb2gray(I);
else
    Igray = I;
end

% Otsu threshold
level = graythresh(Igray);
BW = imbinarize(Igray, level);

% Remove small noise
bw = bwareaopen(BW, 50);
se = strel('disk',2);
bw = imclose(bw,se); 
bw = imfill(bw,'holes'); 
[B,L] = bwboundaries(bw,'noholes');
stats = regionprops(L, 'Area', 'MajorAxisLength', 'MinorAxisLength', 'Perimeter', 'Eccentricity', 'Extent', 'EquivDiameter');
area = cat(1, stats.Area);
maxLength = cat(1, stats.MajorAxisLength);
minLength = cat(1, stats.MinorAxisLength);
perimeter = cat(1, stats.Perimeter);
ecc = cat(1, stats.Eccentricity);
extent = cat(1, stats.Extent);
diameter = cat(1, stats.EquivDiameter);

M = [area maxLength minLength perimeter ecc extent diameter];

