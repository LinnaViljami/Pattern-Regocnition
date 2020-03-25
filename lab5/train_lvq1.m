function [trained_w, errorrates] =  train_lvq1(w, Psi, n, examples, classes, prototype_classes, training_times)

%training
errorrate_before = 1;
current_errorrate = -1;
errorrates = [];

%while errorrate_before ~= current_errorrate
for iterator = 1:training_times
    errorrate_before = current_errorrate;
    minDist = -1;
    winnerClassIndex = -1;
    
    %LVQ1 algorithm with euclidean distance
    w = lvq1(examples, classes, w, prototype_classes, n, Psi);
    
    %determine misclassified training examples
   
    current_errorrate = calc_errorrate(examples, w, classes, prototype_classes);
    errorrates = [errorrates, current_errorrate];
end

trained_w = w;
end

