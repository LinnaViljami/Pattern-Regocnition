function [trained_w, errorrates, trained_relevances, relevance_values] =  train_lvq_relevance(w, Psi, nw,nr, examples, classes, prototype_classes, training_times, relevances)

%training
errorrate_before = 1;
current_errorrate = -1;
errorrates = [];
relevance_values = [];

%while errorrate_before ~= current_errorrate
for iterator = 1:training_times
    errorrate_before = current_errorrate;
    minDist = -1;
    winnerClassIndex = -1;
    
    %LVQ1 algorithm with euclidean distance
    [w, relevances] = lvq_relevance(examples, classes, w, prototype_classes, nw,nr, Psi, relevances);
    
    %determine misclassified training examples
    current_errorrate = calc_errorrate(examples, w, classes, prototype_classes);
    errorrates = [errorrates, current_errorrate];
    relevance_values = [relevance_values; relevances];
end

trained_w = w;
trained_relevances = relevances;
end

