%define mean and cov
mean = [3;4];
cov = [1,0;0,2];


%draw mesh
[X,Y] = meshgrid(-10:1:10);
XYPOINTS = [reshape(X,[],1),reshape(Y,[],1)];
Z = reshape(mvnpdf(XYPOINTS,mean',cov), size(X,1),size(X,2));
mesh(X,Y,Z)


%calculate mahalanobis distance from mean to [10, 10]
points = [10,0,3,6;10,0,4,8];

distances = zeros(4,1);
for i = 1:size(distances,1)
    distances(i) = sqrt((mean-points(:,i))'*inv(cov)*(mean-points(:,i)));
end


for i = 1:size(distances,1)
    printFormat = 'Mahalanobis distance between point [%i; %i] and mean is %.5f';
    fprintf(printFormat, points(1,i), points(2,i), distances(i));
    fprintf('\n');
end
