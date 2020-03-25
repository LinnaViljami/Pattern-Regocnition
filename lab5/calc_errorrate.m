function [errorrate] = calc_errorrate(examples,w, classes, prototype_classes)
    errors = 0;
    for i = 1:size(examples,1)
        example = examples(i,:);
        dist = pdist2(example, w, 'squaredeuclidean');
        [~, argmin_i] = min(dist);
        if(prototype_classes(argmin_i) ~= classes(i))
            errors = errors +1;
        end
        
    end
    errorrate = errors/size(examples,1);
end

