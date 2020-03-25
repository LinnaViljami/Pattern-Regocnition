clear
close all

%load data
load data_lvq_A(1).mat
load data_lvq_B(1).mat

% init constant variables
w = [2,6;8,4;3,3];
Psi = 1;
n = 0.01;
prototype_classes = [1;1;2];
training_times = 14;

%classificate data
class1Data = [matA ones(100,1)];
class2Data = [matB repmat(2,100,1)];

%shuffle data rows
class1Data = class1Data(randperm(size(class1Data,1)),:);
class2Data = class2Data(randperm(size(class1Data,1)),:);

%split data to ten pieces
%init struct with empty datafields
splittedData = struct;
for i = 1:10
    splittedData.(['P', num2str(i)]) = [];
end
%fill datafields
%add class1 data
for i = 1:size(class1Data,1)
    splittedData.(['P', num2str(rem(i, 10)+1)]) = [splittedData.(['P',num2str(rem(i, 10)+1)]); class1Data(i,:)];
end
%add class2 data
for i = 1:size(class2Data,1)
    splittedData.(['P', num2str(rem(i, 10)+1)]) = [splittedData.(['P',num2str(rem(i, 10)+1)]); class2Data(i,:)];
end

%10-fold cross validication
test_error_rates = [];
trained_w_values = [];
for i1 =1:10
    %define data for cross validication
    examples = [];
    classes = [];
    validation_data = [];
    for i2 = 1:10
        %extract one row for validation data
        if i1 == i2
            validation_data = splittedData.(['P', num2str(i2)]);
        %use other rows as training examples
        else
            examples = [examples; splittedData.(['P', num2str(i2)])(:,1:2)];
            classes = [classes;splittedData.(['P', num2str(i2)])(:,3)];
        end
    end
    %run lvq1 training algorithm
    [trained_w, error_rate] = cross_train_lvq1(w, Psi, n, examples, classes, prototype_classes, training_times, validation_data);
    %save error rate
    test_error_rates = [test_error_rates; error_rate];
    trained_w_values = [trained_w_values; trained_w];
end
%display test error rates
test_error_rates

%mean of error rates
mean_error = mean(test_error_rates)

%calculate training error rates
training_error_rates = [];
for i = 1:10
    training_error_rates = [training_error_rates;  calc_errorrate(examples,trained_w_values(((i-1)*3+1):(i*3),:), classes, prototype_classes)];
end
%display training error rates
training_error_rates

%make bar plot
figure
hold on
Y = round(training_error_rates'.*100,2);
b = bar(Y);
xtips = b(1).XEndPoints;
ytips = b(1).YEndPoints;
labels = string(b(1).YData);
text(xtips,ytips,labels,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
%yline(mean_error,'-',['Mean error: ', num2str(mean_error)]);
ylabel('Error-rates (%)');
for i = 1:10
    plot([i-0.4,i+0.4], [test_error_rates(i,1)*100, test_error_rates(i,1)*100], 'r');
    text(i, test_error_rates(i,1)*100+1, num2str(round(test_error_rates(i,1),2)), 'Color', 'red', 'HorizontalAlignment', 'center');
end
title({['Mean error rate: ', num2str(mean_error)], ''});