M1 = [3;5];
M2 = [2;1];
COV1 = [1,0;0,4];
COV2 = [2,0;0,1];

syms x1 x2 real;
sympref('FloatingPointOutput', false);

%calc g1 in point [x;y]
point1 = [x1;x2];
distance1 = (-1/2)*(point1 - M1)'*inv(COV1)*(point1 - M1);
g1 = distance1 - (size(point1, 1)/2)*log(2*pi) - (1/2)*log(det(COV1)) + log(0.3);
ans1 = expand(g1);
printFormat = 'g1 = %s \n';
fprintf(printFormat, ans1);

%calc g2 in point [x;y]
point2 = [x1;x2];
distance2 = (-1/2)*(point2 - M2)'*inv(COV2)*(point2 - M2);
g2 = distance2 - (size(point2, 1)/2)*log(2*pi) - (1/2)*log(det(COV2)) + log(0.7);
ans2 = expand(g2);
printFormat = 'g2 = %s \n';
fprintf(printFormat, ans2);


%decision boundary
DB = expand(g1-g2)

%plot decision boundary
%{
x = -10:1:20;
y = x;
[X, Y] = meshgrid(x,y);
Z = subs(DB, {x1,x2}, {X,Y});
figure(1);
hold on
[M, c] = contour(X,Y,Z,[0 0], 'ShowText', 'on');
c.LineWidth = 3;
hold off

figure(2);
hold on

mesh(X,Y,arrayfun(@(a) double(a), Z));
hold off
%}