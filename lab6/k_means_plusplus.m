function [k_means, c_plot, means_plot, q_error] = k_means_plusplus(data,n_clusters)
%init k_means

%randomly pick the centroid of the first cluster
k_means = [];
k_means = [k_means; data(ceil(rand * size(data,1)), :)];

%pick the other centroids until all selected
while size(k_means,1) < n_clusters
    %calc distances to the centroid for every data point
    distances = pdist2(k_means, data, 'euclidean', 'Smallest', 1);
    %convert distances to probability weights
    weights = distances/sum(distances);
    %pick n random points from data -> set to k_mean starting values
    new_mean = datasample(data, 1, 'Weights', weights);
    k_means = [k_means; new_mean];
end
%random_indexes = randperm(size(data,1), n_clusters);
%k_means = data(random_indexes,:);
k_means_history = k_means;
k_means
old_kmeans = -1;
count = 0;
while ~isequal(old_kmeans, k_means)
    old_kmeans = k_means;
    count = count + 1;
    %assign every datapoint to nearest k_mean
    [~, cluster_indices] = pdist2(k_means, data, 'euclidean', 'Smallest', 1);
    %update cluster means
    for i = 1:size(k_means,1)
        cluster_i_points = cluster_indices == i;
        k_means(i,:) = sum(data(cluster_i_points,:),1)/sum(cluster_i_points, 'all');
    end
    %k_means
    k_means_history = [k_means_history; k_means];
end
count
c_plot= [];
means_plot = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% plot data points and clusters %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %init legends
    cluster_names = string(cluster_indices);
    cluster_names = string(arrayfun(@(x) join(['Group ', x]),cluster_names, 'UniformOutput', false));

    cluster_mean_names = [];
    for i = 1:size(k_means,1)
        cluster_mean_names = [cluster_mean_names; join(['Mean ', num2str(i)])];
    end
    cluster_mean_names = string(cluster_mean_names);

    %combine data and clusters in one dataset
    x = [data(:,1); k_means(:,1)];
    y = [data(:,2); k_means(:,2)];
    groups = [cluster_names';cluster_mean_names];

    %define markers
    markers = [repmat('.',1,n_clusters),repmat('.',1,n_clusters)];

    %define marker sizes
    sizes = [repmat(15,1,n_clusters),repmat(30,1,n_clusters)];
    %make scatter
    figure;
    hold on
    c_plot = gscatter(x,y,groups, '', markers, sizes);
    hold off
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% plot cluster_mean history %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    means_plot = [];
    figure
    hold on
    %plot starting points
    for i =1:size(k_means,1)
        means_plot = [means_plot, plot(k_means_history(i,1),k_means_history(i,2), 'b.', 'MarkerSize', 25)];
    end
    % plot final points
    for i =1:size(k_means,1)
        means_plot = [means_plot, plot(k_means(i,1),k_means(i,2), 'r*', 'MarkerSize', 15)];
    end
    %legend('asd','dddd', 'ddd', 'dddsa', 'dasdsa', 'asd')
    
    %plot routes of the means
    for i = 1:(size(k_means_history,1) - n_clusters)
        x0 = k_means_history(i,1);
        y0 = k_means_history(i,2);
        x1 = k_means_history(i + n_clusters,1);
        y1 = k_means_history(i + n_clusters,2);
        means_plot = [means_plot, plot_arrow(x0, y0, x1, y1)];
    end
    
    
    
    hold off
  
    %calc error
    q_error = 1/2*sum(pdist2(k_means, data, 'squaredeuclidean', 'Smallest', 1), 'all');
    
    
end

