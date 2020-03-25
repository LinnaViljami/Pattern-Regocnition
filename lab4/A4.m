clear
filename = 'HeadTool0002.bmp';
file = im2double(imread(filename));
histeq_file = adapthisteq(file);
[centers, radius, metric] = imfindcircles(histeq_file, [20,40], 'Sensitivity', 0.9);
f1 = figure(1);
hold on
%subplot(1,2,1);
%imshow(file);
%subplot(1,2,2);
imshow(histeq_file);
viscircles(centers(1:2,:), radius(1:2));
hold off