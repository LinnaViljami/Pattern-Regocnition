clear
close all
addpath('./data')
load 'checkerboard.mat';
load 'clusterCentroids.mat'
[k_means, ~] = k_means_no_init(checkerboard, clusterCentroids);

figure
hold on
title('Kmeans - Epoch');
xlabel('Feature 1');
ylabel('Feature 2');
%fprintf(1,'%d / %d \r',i,epochs);
plot(checkerboard(:,1),checkerboard(:,2),'bo','markersize',3)
plot(k_means(:,1),k_means(:,2),'r.','markersize',10,'linewidth',3)
min(k_means, [], 'all')
% Plot decision boundaries
voronoi(k_means(:,1),k_means(:,2));
%pause
%or
%drawnow
hold off