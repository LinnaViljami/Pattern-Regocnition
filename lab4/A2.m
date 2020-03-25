clear
filename = 'cameraman.tif';
file = imread(filename);
edges = edge(file, 'Canny');
file_houghts_own = myhought(edges);
file_houghts_matlab = hough(edges);
fi = figure(1);
subplot(1,2,1);
imagesc(file_houghts_own);
title('self-made');
ylabel('rho_i');
xlabel('theta_i');
subplot(1,2,2);
imagesc(file_houghts_matlab);
title('ready-made');
ylabel('rho_i');
xlabel('theta_i');
sgtitle('Ready-made vs self-made hought transform')
