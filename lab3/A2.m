%LOOCV error rate
clear all;
load lab3_2.mat;

data = lab3_2;
nr_of_classes = 2;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

error_rates = [];
for K=1:199
    %LOOCV
    error_counter = 0;
    for j=1:length(data)
        right_class = class_labels(j);
        extracted_point = data(j,:);
        one_out_data = data;
        one_out_data(j,:) = [];
        one_out_class_labels = class_labels;
        one_out_class_labels(:,j) = [];
        classification = KNN(extracted_point, K, one_out_data,one_out_class_labels);
        if classification ~= right_class
            error_counter = error_counter + 1;
        end

    end
    error_rate = error_counter/(length(data)-1);
    
    error_rates = [error_rates, error_rate];
end

Y = error_rates;
X = 1:1:length(error_rates);
f1 = figure(1);
hold on 
plot(X,Y);
title('LOOCV error rates')
xlabel('K')
ylabel('Error rate')
hold off