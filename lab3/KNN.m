function classLabel = KNN(POINT, K, DATA, CLASS_LABELS)
    DIST = zeros(size(DATA,1));
    for j=1:size(DATA,1)
        DIST(j) = pdist([POINT;DATA(j,:)]);
    end
    [~ , SORTED_INDEXES] = sort(DIST, 'ascend');
    KSHORTEST_INDEXES = SORTED_INDEXES(1:K);
    KSHORTEST_CLASSES = arrayfun(@(index) CLASS_LABELS(index), KSHORTEST_INDEXES);
    classLabel = mode(KSHORTEST_CLASSES);

end

