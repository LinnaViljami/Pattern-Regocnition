clear
close all
addpath('./data')
load 'kmeans1.mat';


%plot visualizations
figure
hold on
sb1 = subplot(1,3,1);
hold on

[kmeans2,c_plot2, mp2, ~]=k_means_cluster(kmeans1,2, false);

hold off

sb2 = subplot(1,3,2);
hold on
[kmeans4,c_plot4, mp4, ~]=k_means_cluster(kmeans1,4, false);

hold off

sb3 = subplot(1,3,3);
hold on
[kmeans8,c_plot8, mp8, ~]=k_means_cluster(kmeans1,8, false);
hold off
hold off
%{
%plot means histories
figure
hold on

sb1 = subplot(2,2,1);

hold on
title('Intermediate means with 2 clusters');
copyobj(mp2, sb1);
hold off

sb2 = subplot(2,2,2);
hold on
title('Intermediate means with 4 clusters');
copyobj(mp4, sb2);
hold off

sb3 = subplot(2,2,3);
hold on
title('Intermediate means with 8 clusters');
copyobj(mp8, sb3);
hold off

sb4 = subplot(2,2,4);
hold on
plot(NaN,NaN,'*r', 'MarkerSize', 15);
plot(NaN,NaN,'.b', 'MarkerSize', 25);
plot_arrow(NaN, NaN, NaN, NaN);
legend('Final cluster mean','Cluster mean init value', 'Cluster mean moving route');
hold off
hold off

%}

%find optimal k
highest_k = 100;
[~,~, ~, j_1]=k_means_cluster(kmeans1,1);

%calc first quantization errors
j_values = [];
for i =1:highest_k
    [~,~, ~, error_rate]=k_means_cluster(kmeans1,i);
    j_values = [j_values, error_rate];
end

%calc d_values
d_values = j_values;
for i =1:highest_k
    d_values(1,i) = (j_1*i^(-2/2))/d_values(1,i);
end

%calc r_values
r_values = j_values;
for i =1:highest_k
    r_values(1,i) = (j_1*i^(-1));
end

%find k_opt
[maxium_value, max_index] = max(d_values);

%plot d_values and k_opt
x = linspace(1,highest_k,highest_k);
figure
hold on
title([join(["Maxium R(k)=", num2str(maxium_value)]), join([",when k=", num2str(x(1,max_index))])]);
plot(x(1,max_index), maxium_value, 'r*')
plot(x,d_values);
xlabel('k');
ylabel('d');
legend('k_{opt}');
hold off

%plot j_values, r_values and k_opt
figure
semilogy(r_values);
hold on
semilogy(x,j_values);
xlabel('k');
xline(max_index);
legend('R(k)','J(k)','k_{opt}');
