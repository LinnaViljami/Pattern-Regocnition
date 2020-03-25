S1 = [4,5,6];
S2 = [6,3,9];
S3 = [8,7,3];
S4 = [7,4,8];
S5 = [4,6,5];

ALLF = [S1; S2; S3; S4; S5];
MEANS = zeros(3,1);
%mean of features
for i = 1:3
    printFormat = 'Mean of feature %i is %.3f';
    MEANS(i) = mean(ALLF(:,i));
    fprintf(printFormat, i, mean(ALLF(:,i)));
    fprintf('\n')
end

biasCov = zeros(3);

for j = 1:3
    for i = 1:3
        varr = 0;
        for s1 = 1:5
            varr = varr + ((ALLF(s1, i)-mean(ALLF(:,i)))*(ALLF(s1, j)-mean(ALLF(:,j))))*(1/5);
        end
        
        biasCov(j,i) = varr;
    end
end

%print biased covariance matrix
biasCov
cov(ALLF)
%print propability of [5,5,6]
X = [5;5;6];
probX = mvnpdf(X,MEANS,biasCov);
printFormat = 'Probability of point [5,5,6] is %.8f';
fprintf(printFormat, probX);
fprintf('\n');

%print propability of [3,5,7]
X = [3;5;7];
probX = mvnpdf(X,MEANS,biasCov);
printFormat = 'Probability of point [3,5,7] is %.8f';
fprintf(printFormat, probX);
fprintf('\n');


%print propability of [4,6.5,1]
X = [4;6.5;1];
probX = mvnpdf(X,MEANS,biasCov);
printFormat = 'Probability of point [4,6.5,1] is %.8f';
fprintf(printFormat, probX);
fprintf('\n');

