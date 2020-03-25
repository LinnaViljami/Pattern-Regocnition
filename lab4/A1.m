clear

c= imread('cameraman.tif');
edges = edge(c, 'Canny');
%imshow(edges);
[hc, theta, rho] = hough(edges);
hcTh = hc;
hcTh(hcTh < 0.999 * max(hc(:))) = 0;

peaks = houghpeaks(hc, 5);
f1 = figure(1);
hold on
im = imagesc(hc);
ylabel('rho');
xlabel('theta');
for j = 1:size(peaks,1)
    plot(peaks(j,2), peaks(j,1), 'r+', 'MarkerSize', 20, 'LineWidth', 2);
end
hold off
f2 = figure(2);
hold on
imshow(c);
myhoughtline(c, rho(1,peaks(1,1)), theta(1,peaks(1,2)));
hold off