function [prototypes] = batchNG(Data, n, epochs, xdim, ydim)

% Batch Neural Gas
%   Data: contains data (set),
%   n: is the number of clusters/prototypes,
%   epoch: the number of iterations,
%   xdim and ydim: are the dimensions to be plotted, default xdim=1,ydim=2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Init

figure(20)

error(nargchk(3, 5, nargin));  %#ok<NCHKN> % check the number of input arguments
if (nargin<4)
  xdim=1; ydim=2;   % default plot values
end

% dlen = length of data; 
% dim  = mumber of features
[dlen,dim] = size(Data);

%prototypes =  % small initial values
% % or
sbrace = @(x,y)(x{y});
fromfile = @(x)(sbrace(struct2cell(load(x)),1));
prototypes=fromfile('data/clusterCentroids.mat');
n = length(prototypes(:,1));

% Rank-variable and array of ordered indices - For ranking
ranks = zeros(n,1);
ordered_indices = 1:n;

% Initial neighborhood value
lambda0 = n/2; 
% Precompute lambdas for all upcoming epochs
lambda = lambda0 * (0.01/lambda0).^([0:(epochs-1)]/epochs);
% NOTE: the lecture slides refer to this parameter as sigma^2
%       instead of lambda (!!!)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main loop

for i=1:epochs
  D_prototypes = zeros(n,dim);   % Accumulated update term - Numerator
  D_prototypes_av = zeros(n,1);  % Normalization factor - Denominator
  
  for j=1:dlen  % consider all points at once for the batch update
    
    % Select current data point
    x = Data(j,:);       % Current data point
    X = x(ones(n,1),:);  % Repeat data point over n(=num of prototypes) rows
    
    % Compute neighborhood ranking
    % 1. Compute distance from data point to each prototype:
    % d(i) = squared eucldean distance(prototypes(i),data_point)
    d = sum((X - prototypes).^2,2);
    
    % 2. Compute ranks based on distances
    % ranks(i) = rank of prototypes(i) for data point j; lower value(=distance) -> higher rank; 
    % rank == how many'th BMU (Best Matching Unit) a prototype is for a given data point j
    [~, sorted_indices] = sort(d,'ascend');
    %[~, ranks] = sort(sorted_indices,'ascend'); % Comoutationally more inefficient
    ranks(sorted_indices) = ordered_indices;
    
    % Update's accumulation step
    D_prototypes = D_prototypes + X .* exp(-ranks/lambda(i)); % i = epoch
    D_prototypes_av = D_prototypes_av + exp(-ranks/lambda(i));
    
  end
  
  if sum(D_prototypes_av(:) == 0) > 0 
     disp(['ZERO-DIVISION-WARNING!!!! After epoch: ' num2str(i)])
     D_prototypes
     D_prototypes_av
     return
  end
  
  % Normalize newly computed accumulated prototype values
  D_prototypes = D_prototypes ./ D_prototypes_av;
  
  % Update prototypes
  prototypes = D_prototypes;
  
  % Plot current state
  if i == 20 || i == 100 || i == 200 || i == 500   %plot each epoch
    if i == 20
        subplot(2,2,1)
        hold on;
    elseif i == 100
        subplot(2,2,2)
        hold on;
    elseif i == 200
        subplot(2,2,3)
        hold on;
    elseif i == 500
        subplot(2,2,4)
        hold on;
    end
    title(['BatchNG - Epoch = ' num2str(i)])
    xlabel('Feature 1');
    ylabel('Feature 2');
    fprintf(1,'%d / %d \r',i,epochs);
    plot(Data(:,xdim),Data(:,ydim),'bo','markersize',3)
    plot(prototypes(:,xdim),prototypes(:,ydim),'r.','markersize',10,'linewidth',3)
    % Plot decision boundaries
    voronoi(prototypes(:,1),prototypes(:,2));
    %pause
    %or
    %drawnow
    hold off;
  end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%