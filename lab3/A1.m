%define normdistributions
MEAN1 = 5;
MEAN2 = 9;
VAR = 4;
boundary = 10;


%calc false alarm rate
falseAlarm = normcdf(boundary, MEAN1, sqrt(VAR), 'upper');
printFormat = 'False alarm rate = %.8f \n';
fprintf(printFormat, falseAlarm);

%calc hit rate
hit = normcdf(boundary, MEAN2, sqrt(VAR), 'upper');
printFormat = 'Hit rate = %.8f \n';
fprintf(printFormat, hit);


%calc discriminability with 5, 7, 4
d = abs(MEAN1 - MEAN2)/sqrt(VAR);
printFormat = 'Discriminability with 5, 7, 4 = %.8f \n';
fprintf(printFormat, d);


%calc discriminability with 5, 9, 4
MEAN1 = 5;
MEAN2 = 9;
VAR = 4;
d = abs(MEAN1 - MEAN2)/sqrt(VAR);
printFormat = 'Discriminability with 5, 9, 4 = %.8f \n';
fprintf(printFormat, d);

%find mean2 > mean1 so that d=3 with var=4 and mean1=5
%try to find with guessing
MEAN1 = 5;
VAR = 4;
MEAN2 = 11;
d = abs(MEAN1 - MEAN2)/sqrt(VAR);
printFormat = 'Discriminability with 5, 11, 4 = %.8f \n';
fprintf(printFormat, d);


%read data from file
data = load('lab3_1.mat');
data = data.outcomes;

%calculate hitrate
falseDetectionCount = 0;
trueDetectionCount = 0;
presentationCount = 0;
noPresentationCount = 0;
for i = 1:200
    signalPresented = data(i,1);
    signalDetected = data(i,2);
    if signalPresented == 1
        presentationCount = presentationCount +1;
        if signalDetected == 1
            trueDetectionCount = trueDetectionCount + 1;
        end
    else
        noPresentationCount = noPresentationCount +1;
        if signalDetected == 1
            falseDetectionCount = falseDetectionCount + 1;
        end
    end
end

%calc hit rate
hit = trueDetectionCount/presentationCount;
printFormat = 'Hit rate = %.8f \n';
fprintf(printFormat, hit);


%calc false rate
false = falseDetectionCount/noPresentationCount;
printFormat = 'False acceptance rate = %.8f \n';
fprintf(printFormat, false);

%{
%plot ROC curve
labels = data(:,1);
scores = data(:,2);
[X,Y,~,~,OPTROCPT] = perfcurve(labels,scores,1)
f1 = figure(1);
hold on
plot(X,Y);
plot(OPTROCPT(1), OPTROCPT(2), 'ro');
%}
%generate normal distributions with different variances
MEAN1 = 5;
MEAN2 = 8;
VAR = 0;
x = -1;
y = -1;
targetX = 0.1;
targetY = 0.8;

while abs(targetY-y) > 0.03
    x = -1;
    VAR = VAR + 0.01;
    %find point where x is near target
    boundary = 0.01;
    while abs(targetX-x) > 0.03
        x = normcdf(boundary, MEAN1, sqrt(VAR), 'upper');
        boundary = boundary + 0.01;
    end
    
    %calc hit rate in this boundary
    y = normcdf(boundary, MEAN2, sqrt(VAR), 'upper');
    
end

%print d
d = abs(MEAN1-MEAN2)/sqrt(VAR)
sqrt(VAR)
boundary
%plot ROC
X = [];
Y = [];
boundary = -1;
while boundary <=30
    X = [X normcdf(boundary, MEAN1, sqrt(VAR), 'upper')];
    Y = [Y normcdf(boundary, MEAN2, sqrt(VAR), 'upper')];
    boundary = boundary + 0.1;
end
f1 = figure(1);
hold on
plot(X,Y);
plot(targetX,targetY,'bO');
legend({'ROC-curve', '(0.1, 0.8)'})
title(['ROC curve, d=' num2str(d)]);
xlabel('Sensitivity');
ylabel('Specifity');