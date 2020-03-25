function [numerator, denominator] = spamFilter(email, words, probabilities)
    numerator = 1;
    denominator = 1;
    pSpam = 0.9
    pNotSpam = 0.1
    for m =1:size(words,1)
        word = lower(words(m,1));
        if size(strfind(lower(email), word),1) ~= 0
            denominator = denominator*probabilities(m,2);
            numerator = numerator*probabilities(m,1);
        end
    end
    denominator = denominator * pNotSpam;
    numerator = numerator* pSpam;
    printFormat = 'Numerator: %.15f \n Denominator: %.15f \n';
    fprintf(printFormat, numerator, denominator);
    
end

