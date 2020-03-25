%load data
clear
close all
load data_lvq_A(1).mat
load data_lvq_B(1).mat

%init common LVQ1 variables
Psi = 1;
n = 0.01;
classes = [repmat(1,100,1);repmat(2,100,1)];
class_colors = ['r';'b'];
examples = [matA; matB];
training_times = 14;

%init LVQ1 prototypes 1-1
w1 = [2,6];
w2 = [8,4];
prototype_classes11 = [1;2];
w11 = [w1;w2];

%train and plot LVQ1-1
[trained_w11, errorrates11] = train_lvq1(w11, Psi, n, examples, classes, prototype_classes11, training_times);


%init LVQ1 prototypes 2-1
w1 = [2,6];
w2 = [8,4];
w3 = [3,3];
prototype_classes21 = [1;1;2];
w21 = [w1;w2;w3];

%train and plot LVQ2-1
[trained_w21, errorrates21] = train_lvq1(w21, Psi, n, examples, classes, prototype_classes21, training_times);

%init LVQ1 prototypes 2-2
w1 = [2,6];
w2 = [8,4];
w3 = [5,3];
w4 = [5,7];
prototype_classes22 = [1;1;2;2];
w22 = [w1;w2;w3;w4];

%train and plot LVQ2-2
[trained_w22, errorrates22] =  train_lvq1(w22, Psi, n, examples, classes, prototype_classes22, training_times);


%init LVQ1 prototypes 1-2
w1 = [2,6];
w2 = [5,3];
w3 = [5,7];
prototype_classes12 = [1;2;2];
w12 = [w1;w2;w3];

%train and plot LVQ1-2
[trained_w12, errorrates12] = train_lvq1(w12, Psi, n, examples, classes, prototype_classes12, training_times);

%plot 2-1 errorrates with n = 0.01
figure
hold on
title('2-1 error-rates, n=0.01');
x = linspace(1,training_times, training_times);
plot(x,errorrates21);
xlabel('Training times');
ylabel('Error-rate');
hold off
%plot all errorrates
figure
hold on
title('error-rates');
x = linspace(1,training_times, training_times);
plot(x,errorrates11);
plot(x,errorrates12);
plot(x,errorrates21);
plot(x,errorrates22);
legend('1-1', '1-2', '2-1', '2-2', 'Location', 'southwest');


%plot prototypes and data classifications after training
figure;
hold on
%plot 1-1
subplot(2,2,1);
hold on
for i = 1:size(examples, 1)
    datapoint = create_classified_datapoint(examples(i,:), trained_w11, prototype_classes11, class_colors);
    scatter(datapoint.x, datapoint.y, datapoint.color);
end
scatter(trained_w11(1,1), trained_w11(1,2),150,'r', 'x', 'LineWidth', 3);
scatter(trained_w11(2,1), trained_w11(2,2),150,'b', 'x', 'LineWidth', 3);
hold off
%plot 1-2
subplot(2,2,2);
hold on
for i = 1:size(examples, 1)
    datapoint = create_classified_datapoint(examples(i,:), trained_w12, prototype_classes12, class_colors);
    scatter(datapoint.x, datapoint.y, datapoint.color);
end
scatter(trained_w12(1,1), trained_w12(1,2),150,'r', 'x', 'LineWidth', 3);
scatter(trained_w12(2,1), trained_w12(2,2),150,'b', 'x', 'LineWidth', 3);
scatter(trained_w12(3,1), trained_w12(3,2),150,'b', 'x', 'LineWidth', 3);
hold off
%plot 2-1
subplot(2,2,3);
hold on
for i = 1:size(examples, 1)
    datapoint = create_classified_datapoint(examples(i,:), trained_w21, prototype_classes21, class_colors);
    scatter(datapoint.x, datapoint.y, datapoint.color);
end
scatter(trained_w21(1,1), trained_w21(1,2),150,'r', 'x', 'LineWidth', 3);
scatter(trained_w21(2,1), trained_w21(2,2),150,'r', 'x', 'LineWidth', 3);
scatter(trained_w21(3,1), trained_w21(3,2),150,'b', 'x', 'LineWidth', 3);
hold off
%plot 2-2
subplot(2,2,4);
hold on
for i = 1:size(examples, 1)
    datapoint = create_classified_datapoint(examples(i,:), trained_w22, prototype_classes22, class_colors);
    scatter(datapoint.x, datapoint.y, datapoint.color);
end
scatter(trained_w22(1,1), trained_w22(1,2),150,'r', 'x', 'LineWidth', 3);
scatter(trained_w22(2,1), trained_w22(2,2),150,'r', 'x', 'LineWidth', 3);
scatter(trained_w22(3,1), trained_w22(3,2),150,'b', 'x', 'LineWidth', 3);
scatter(trained_w22(4,1), trained_w22(4,2),150,'b', 'x', 'LineWidth', 3);
hold off
hold off
