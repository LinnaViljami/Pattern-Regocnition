clear
I = imread('dogGrayRipples.png');
I = im2double(I);
f = fft2(I); 
fs= fftshift(f);
f = abs(fs);
f = log(1+f);
f1 = figure(1)
hold on
imshow(f,[]);
hold off
%[x, y] = getpts(f1)



[B,In] = sort(f(:),1,'descend');
max_indices = In(1:3);
[y,x] = ind2sub(size(f), max_indices);
y(1) = [];
x(1) = [];
mask=zeros(size(f));
rows = size(f,1);
cols = size(f,2);
radius = 10;
center = [x'; y'];  
[xMat,yMat] = meshgrid(1:cols,1:rows);

for i =1:size(center,2)
    distFromCenter = sqrt((xMat-center(1,i)).^2 + (yMat-center(2,i)).^2);
    mask(distFromCenter<=radius)=1;
end
%figure(1);
%hold on
%imshow(~mask,[]);title('Mask');
%hold off

fs=fs.*(~mask);
f = ifftshift(fs);
I = real(ifft2(f));

figure(2);
hold on
imshow(I, []);
title('S4169921');
hold off

