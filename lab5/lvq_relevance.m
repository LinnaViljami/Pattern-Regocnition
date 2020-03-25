function [w, relevances] = lvq_relevance(examples,classes,w,prototype_classes, nw,nr, Psi, relevances)
 %LVQ1 algorithm with euclidean distance
    for i = 1:size(examples,1)
        example = examples(i,:);
        %calc weighted euclidean distance
        dist = pdist2(example, w.*relevances, 'squaredeuclidean');
        [~, argmin_i] = min(dist);
        determined_class = prototype_classes(argmin_i);
        if(determined_class == classes(i))
            Psi = 1;
        else
            Psi = -1;
        end
        %update winner
        w(argmin_i,:) = w(argmin_i,:) + nw*Psi*(example - w(argmin_i,:));
        %update relevances
        for j = 1:size(relevances,2)
            relevances(1,j) = relevances(1,j) - nr*Psi*abs(example(1,j) - w(argmin_i,j));
        end
        %filter negative values
        relevances(relevances < 0) = 0;
        %normalize relevances
        relevances = relevances/sum(relevances, 'all');
    end
end

