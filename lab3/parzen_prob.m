function probability = parzen_prob(POINT, CLASS_POINTS, h)
    probability = 0;
    for j=1:size(CLASS_POINTS,1)
        
        
        %parzen window to j:th data feature i    
        nominator = 0;
        for i=1:length(POINT)
            nominator = nominator + (POINT(i)-CLASS_POINTS(j,i))^2;
        end
        window = exp(-(nominator/(2*h^2)));
        probability = probability + window;
        
    end
    probability = (probability/size(CLASS_POINTS,1))/((h*sqrt(2*pi))^3);
    
end

