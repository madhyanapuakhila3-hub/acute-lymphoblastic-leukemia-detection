function M   =SHAPEEXTRACTION (I)

threshold = graythresh(I);
bw = im2bw(I,threshold);
imshow(bw)
bw = bwareaopen(bw,30);

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