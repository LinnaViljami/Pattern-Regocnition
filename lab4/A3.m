 clear
 I = rgb2gray(imread('chess.jpg'));
 BW = edge(I,'canny');


[H,T,R] = hough(BW);
P  = houghpeaks(H,15,'threshold',ceil(0.3*max(H(:)))); 
y = R(P(:,1));
x = T(P(:,2));
f1 = figure(1);
num_maxima = 15;

P  = houghpeaks(H,num_maxima);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho'), title('S4169921');
axis on, axis normal, colormap(gca,hot), hold on;
plot(T(P(:,2)),R(P(:,1)),'s','color','white');
%imshow(H,[],'XData', T,'YData',R,'InitialMagnification','fit');
%plot(x,y,'r+', 'MarkerSize', 10, 'LineWidth', 2);
hold off

lines = houghlines(BW, T, R, P);
f2 = figure(2);
imagesc(imread('chess.jpg'));
%for j =size(lines,2)
%    line(lines(j).point1, lines(j).point2,'Color','red');

%end
for j = 1:size(P,1)
    myhoughtline(I, R(1,P(j,1)), T(1,P(j,2)));
end