close all;
clear all;

% Read in data
load data/checkerboard.mat
data = checkerboard;
clear checkerboard;

%% Q3
% %%%%%%%%%%%%%%%%%%%%%%
% Test run of k-Means:
k = 100;
[prototypes, labeled_data, quantization_error] = k_means(data, k);

% Returned from k_means:
%  prototypes -- One per row
%  labeled_data{1} == data
%  labeled_data{2} == labels, where labels(i) == data(i)
%  quantization_error -- QE computed at end of training
% %%%%%%%%%%%%%%%%%%%%%%

% Plot results: data, prototypes, decision boundaries
figure(1)
hold on;
title(['Outcome k-Means Clustering, k = ' num2str(k), ...
       newline 'Feature 2 versus Feature 1', ...
       newline 'Quantization error = ' num2str(quantization_error)])
xlabel('Feature 1');
ylabel('Feature 2');
xdim=1; ydim=2; % On which axis which dimension of data points should be shown
plot(data(:,xdim),data(:,ydim),'bo','markersize',3)
% Plot prototypes
plot(prototypes(:,xdim),prototypes(:,ydim),'r.','markersize',10,'linewidth',3)
% Plot decision boundaries
voronoi(prototypes(:,1),prototypes(:,2));
hold off;

%% Q2
close all;
% %%%%%%%%%%%%%%%%%%%%%%
% Test run of Batch Neural Gas:
n = 100 % Number of rototypes; Overwritten if centroid file is read in
epochs = 500
prototypes = batchNG_plotting(data, n, epochs)

% Returned from Batch neural gas:
%  prototypes -- One per row
% %%%%%%%%%%%%%%%%%%%%%%

%% JFF - Observe full training
close all;
% %%%%%%%%%%%%%%%%%%%%%%
% Test run of Batch Neural Gas:
n = 100 % Number of rototypes; Overwritten if centroid file is read in
epochs = 500
prototypes = batchNG(data, n, epochs)

% Returned from Batch neural gas:
%  prototypes -- One per row
% %%%%%%%%%%%%%%%%%%%%%%
