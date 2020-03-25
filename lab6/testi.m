clear
close all
addpath('./data')
load 'checkerboard.mat';

running_times = 10;
n_clusters = 100;
%run 10 times

min_values_plus = [];
min_values_normal = [];
for irun = 1:running_times
    %run 20 times with plusplus and normal and save quatization errors
    q_errors_plus = [];
    for i=1:20  
        [~, ~, ~, q_error]=k_means_cluster(checkerboard,100, true);
        q_errors_plus = [q_errors_plus, q_error];
    end

    q_errors_normal = [];
    for i=1:20  
        [~, ~, ~, q_error]=k_means_cluster(checkerboard,n_clusters, false);
        q_errors_normal = [q_errors_normal, q_error];
    end
    [min_qplus, min_qplus_index] = min(q_errors_plus);

    [min_q, min_q_index] = min(q_errors_normal);
    min_values_plus = [min_values_plus, min_qplus];
    min_values_normal = [min_values_normal, min_q];
end
std_normal = std(min_values_normal)
std_plus = std(min_values_plus)
mean_normal = mean(min_values_normal)
mean_plus = mean(min_values_plus)
[h, p]= ttest2(min_values_normal, min_values_plus)