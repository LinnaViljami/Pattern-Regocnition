dataFile = load('lab1-data-new(1)/lab1_1.mat');
dataVector = dataFile.lab1_1;
height = dataVector(:,1);
age = dataVector(:,2);
weight = dataVector(:,3);

cmHA = corrcoef(height, age);
cmHW = corrcoef(height, weight);
cmWA = corrcoef(weight, age);

HACorr = cmHA(2,1);
HWCorr = cmHW(2,1);
WACorr = cmWA(2,1);

disp(['Height and age correlation is: ', num2str(HACorr)]);
disp(['Height and weight correlation is: ', num2str(HWCorr)]);
disp(['Weight and age correlation is: ', num2str(WACorr)]);

figure(1);
hold on;
title(sprintf("Person's age versus weight. \n Correlation coefficient=%f", WACorr));
ylabel("Weight(kg)");
xlabel("Age(years)");
s1 = scatter(age, weight, 's');
s1.MarkerEdgeColor = 'g'

hold off;


figure(2);
hold on
title(sprintf("Person's weight versus height. \n Correlation coefficient=%f", HWCorr));
xlabel("Height(cm)");
ylabel("Weight(kg)");
s2 = scatter(height, weight);
s2.MarkerEdgeColor = 'r';
hold off;