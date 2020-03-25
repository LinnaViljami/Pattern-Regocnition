function [prototypes, labeled_data, quantization_error] = k_means(data, k)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % INPUT
    %   data = array of data points; 1 data point per row; columns contain
    %   features
    %   k = number of desired clusters/prototypes
    % OUTPUT
    %   prototypes = array of prototypes; 1 prototype per row; same number 
    %   offeatures as (input) data has
    %   labeled_data{1} = original data
    %   labeled_data{2} = labels; label(i) corresponds to data(i)
    %   quantization_error = quantization error computed at end of training
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% Initialize variables
    data_length = length(data(:,1));
    num_features = length(data(1,:));
    prototypes = zeros(k, num_features); % One prototype per row
    labels = zeros(data_length,1); % label(i) corresponds to data(i,:)
    
    %%% Initialize algorithm (i.e. prototypes)
    
    % Pick randomly k data points from data as initial prototypes
    %range_of_indices = [1, data_length];
    %rand_indices = randi(range_of_indices, 1, k);
    %for i = 1:k
    %    prototypes(i, :) = data(rand_indices(i), :);
    %end
    
    disp('ATTENTION! PROTOTYPES INITIALIZED FROM FILE!')
    sbrace = @(x,y)(x{y});
    fromfile = @(x)(sbrace(struct2cell(load(x)),1));
    prototypes=fromfile('data/clusterCentroids.mat');
    k = length(prototypes(:,1));
    
    %%% Run algorithm
    changes = true;
    repetitions = 0
    while changes
        changes = false;
        repetitions = repetitions + 1
        % Re-assign data points to clusters
        for i = 1:data_length
            % Compute distances between data point and each prototype
            distances = zeros(k,1);
            for p = 1:k
                distances(p) = pdist2(prototypes(p,:), data(i,:)); % Euclidean
            end
            
            %Find argmin for distances, i.e. idx of closest prototype
            [val, idx] = min(distances); % idx = class of data point's closest prototype
            
            % Reassign label. If label has changed, changes=true & continue
            % algorithm
            if idx ~= labels(i)
                changes = true;
                labels(i) = idx;  % Doesn't need re-assignment otherwise
            end
        end
        
        % Rocompute prototypes as means per respective cluster
        summations = zeros(k, num_features);
        data_points_per_proto = zeros(k, 1);
        
        % First, sum values of all data points per cluster
        for i = 1:data_length
            summations(labels(i), :) = summations(labels(i), :) + data(i, :);
            data_points_per_proto(labels(i)) = data_points_per_proto(labels(i)) + 1;
        end
        
        % Re-compute prototypes by dividing summed values per cluster by
        % number of data points per cluster
        for p = 1:k
            prototypes(p, :) = summations(p, :) / data_points_per_proto(p);
        end
    end  % End of main training loop
    
    
    %%% Determine training outcome's quality and return final outcome
    
    % Compute final quantization error
    quantization_error = 0;
    for i = 1:data_length
            % Compute distances between data point and its prototype
            % Add such squared euclidean distance per datapoint to J (=QE)
            quantization_error = quantization_error + ...
                (pdist2(prototypes(labels(i),:), data(i,:)))^2;
    end
    
    labeled_data = {data, labels}; % label(i) corresponds to data(i,:)
    
end