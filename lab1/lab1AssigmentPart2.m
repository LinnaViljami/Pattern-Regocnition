repeatTimes = 15000;
binarySize = 30;


%calculate S
randomIndexes = randi([1 20],[repeatTimes,3]);
S = double.empty(repeatTimes,0);
for selector = 1:repeatTimes
    i = randomIndexes(selector,:);
    S(selector) = calcHammDist(i(1),i(2),i(3));
end


%calculate D
randomIndexes = randi([1 20],[repeatTimes,4]);
D = double.empty(repeatTimes,0);
for selector = 1:repeatTimes
    i = randomIndexes(selector,:);
    while(i(1) == i(2))
       i(2) = randi(20);
    end
    D(selector) = calcHammDistBtwTwoFiles(i(1),i(2),i(3),i(4));
end


%print means
printFormat = "Mean of S=%0.4f, mean of D=%0.4f. \n";
fprintf(printFormat, mean(S), mean(D));
DDist = fitdist(D.', 'Normal');
SDist = fitdist(S.', 'Normal');

%plot histogram and distributions from S and D data
x = [-0.1:.01:1];
yD = normpdf(x,DDist.mu, DDist.sigma).*(repeatTimes/binarySize);
yS = normpdf(x,SDist.mu, SDist.sigma).*(repeatTimes/binarySize);
figure(1);
hold on;
histogram(D);
histogram(S);
plot(x,yD,'b');
plot(x,yS,'r');

hold off

%print degree of freedom 
printFormat = "Estimated degrees of freedom of irisCode is %d \n";
freedomEstimate = mean(D)*(1-mean(D))/(var(D)*var(D));
fprintf(printFormat, freedomEstimate)

%print variances
printFormat = "Variance of S=%0.5f, variance of D=%0.5f. \n";
fprintf(printFormat, var(S), var(D));

%iterate to find d value
targetErrorRate = 0.0005;
d = 0;
currentErrorRate = -1;
iterateStep = 0.00003;
maxiumSuitableDifference = 0.00001;
while abs(targetErrorRate - currentErrorRate) > maxiumSuitableDifference
    d = d + iterateStep;
    currentErrorRate = normcdf(d, DDist.mu, DDist.sigma);
end


%print propability of error
printFormat = "When d=%0.5f, the false acceptance rate is %0.5f \n";
fprintf(printFormat, d, currentErrorRate);

%print propability of false rejection
printFormat = "When d=%0.5f, the false rejection rate is %0.5f \n";
fprintf(printFormat, d, normcdf(d, SDist.mu, SDist.sigma, 'upper'));


%find smallest normalized hamming distance of testperson
[smallestFileIndex, smallestRowIndex, smallestNormDist] = findSmallestDistance();


%calculate HD with 20 bits
randomIndexes = randi([1 20],[repeatTimes,4]);
HD20 = double.empty(repeatTimes,0);
for selector = 1:repeatTimes
    i = randomIndexes(selector,:);
    while(i(1) == i(2))
       i(2) = randi(20);
    end
    HD20(selector) = calcHammDistWith20Bits(i(1),i(2),i(3),i(4));
end

m20 = mean(HD20)
n = 1/(4*var(HD20));
var20 = m20*(1-m20)/n;
figure(2);
hold on
x = [-0.2:.01:1];
yHD20 = normpdf(x,m20, sqrt(var20));
plot(x,yHD20);


normcdf(0, m20,sqrt(var20))
hold off



