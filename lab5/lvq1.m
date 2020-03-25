function w = lvq1(examples,classes,w,prototype_classes, n, Psi)
 %LVQ1 algorithm with euclidean distance
    for i = 1:size(examples,1)
        example = examples(i,:);
        dist = pdist2(example, w, 'squaredeuclidean');
        [~, argmin_i] = min(dist);
        determined_class = prototype_classes(argmin_i);
        if(determined_class == classes(i))
            Psi = 1;
        else
            Psi = -1;
        end
        w(argmin_i,:) = w(argmin_i,:) + n*Psi*(example - w(argmin_i,:));
    end
end

