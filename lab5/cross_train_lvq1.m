function [trained_w, final_error_rate] = cross_train_lvq1(w, Psi, n, examples, classes, prototype_classes, training_times, validation_data)

for iterator = 1:training_times
    %LVQ1 algorithm with euclidean distance
    w = lvq1(examples, classes, w, prototype_classes, n, Psi);
end

%calculate error_rate
errors = 0;
    for i = 1:size(validation_data,1)
        test_point = validation_data(i,:);
        dist = pdist2([test_point(1,1), test_point(1,2)], w, 'squaredeuclidean');
        [~, argmin_i] = min(dist);
        if(prototype_classes(argmin_i) ~= validation_data(i,3))
            errors = errors +1;
        end
        
    end
final_error_rate = errors/size(validation_data,1);
trained_w = w;
end

