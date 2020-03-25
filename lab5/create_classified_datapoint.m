function [datapoint] = create_classified_datapoint(coordinates, prototypes, prototype_classes, class_colors)
    datapoint.x = coordinates(1,1);
    datapoint.y = coordinates(1,2);
    dist = pdist2(coordinates, prototypes, 'squaredeuclidean');
    [~, argmin_i] = min(dist);
    determined_class = prototype_classes(argmin_i);
    datapoint.color = class_colors(determined_class);
end

