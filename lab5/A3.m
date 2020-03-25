clear
close all

%load data
load data_lvq_A(1).mat
load data_lvq_B(1).mat

% init constant variables
w = [mean(matA(:,1)),mean(matA(:,2));mean(matA(:,1)),mean(matA(:,2));mean(matB(:,1)),mean(matB(:,2))];
Psi = 1;
nw = 0.015;
nr = 0.0015;
training_times = 13;
classes = [repmat(1,100,1);repmat(2,100,1)];
class_colors = ['r';'b'];
examples = [matA; matB];
prototype_classes = [1;1;2];
relevances = [0.5, 0.5];

%run training algorithm
[trained_w, errorrates, trained_relevances, relevance_values] = train_lvq_relevance(w, Psi, nw, nr, examples, classes, prototype_classes, training_times, relevances);

%plot data and prototypes
figure
hold on
scatter(matA(:,1), matA(:,2), 'r');
scatter(matB(:,1), matB(:,2), 'b');
scatter(trained_w(1,1), trained_w(1,2),150,'r', 'x', 'LineWidth', 3);
scatter(trained_w(2,1), trained_w(2,2),150,'r', 'x', 'LineWidth', 3);
scatter(trained_w(3,1), trained_w(3,2),150,'b', 'x', 'LineWidth', 3);
title({'Datapoints and prototypes trained by LVQ', '\eta{_w}=0.01, \eta{_\lambda}=0.0015', 'Training times: 13'});
hold off

figure
hold on
subplot(1,2,1);
hold on
%plot training error curve
x = linspace(1,size(errorrates,2), size(errorrates,2));
plot(x, errorrates);
xlabel('Training times');
ylabel('Training error');
hold off
subplot(1,2,2);
hold on
plot(x,relevance_values(:,1));
plot(x,relevance_values(:,2));
xlabel('Epochs');
ylabel('Relevance factor values')
legend('feature1-relevance', 'feature2-relevance');


% 10fold cross validation data initialize
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

%randomize class1 data with class 2 data
for i = 1:10
    splittedData.(['P', num2str(i)]) = splittedData.(['P', num2str(i)])(randperm(size(splittedData.(['P', num2str(i)]),1)),:);
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
    [trained_w, error_rate] = cross_train_lvq_relevance(w, Psi, nw,nr, examples, classes, prototype_classes, training_times, validation_data, relevances);
    %save error rate
    test_error_rates = [test_error_rates; error_rate];
    trained_w_values = [trained_w_values; trained_w];
end

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
Y = training_error_rates'.*100;
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
    text(i, test_error_rates(i,1)*100+1, num2str(test_error_rates(i,1)), 'Color', 'red', 'HorizontalAlignment', 'center');
end
title({['Mean error rate: ', num2str(mean_error)], ''});