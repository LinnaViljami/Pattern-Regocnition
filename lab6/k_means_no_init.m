function [k_means, q_error] = k_means_no_init(data,k_means)
%init k_means
%pick n random points from data -> set to k_mean starting values

old_kmeans = -1;
count = 0;
while ~isequal(old_kmeans, k_means) && count < 1000
    old_kmeans = k_means;
    count = count + 1;
    if(count == 50000)
        disp('farssi');
    end
    %assign every datapoint to nearest k_mean
    [~, cluster_indices] = pdist2(k_means, data, 'euclidean', 'Smallest',1);
    %update cluster means
    for i = 1:size(k_means,1)
        cluster_i_points = cluster_indices == i;
        k_means(i,:) = sum(data(cluster_i_points,:),1)/sum(cluster_i_points, 'all');
    end
end

%calc error
q_error = 1/2*sum(pdist2(k_means, data, 'squaredeuclidean', 'Smallest', 1), 'all');
    
 
end

