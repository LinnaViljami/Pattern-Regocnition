function accumulator_array = myhought(edges)
    max_length = floor(sqrt(size(edges,1)^2 + size(edges,2)^2))+1; 
    RHO = -max_length:1:max_length;
    THETA = -90:1:89;

    accumulator_array = zeros(length(RHO), length(THETA));


    for j = 1:size(edges, 1)
        for i = 1:size(edges, 2)
            if edges(j,i) ~= 0
                for theta = THETA
                    rho = floor(calc_rho(i-1,j-1, theta));
                    y_index = (rho + max_length + 1);
                    x_index = (theta + 91);
                    accumulator_array(y_index, x_index) = accumulator_array(y_index, x_index) + 1;
                end
            end
        end
    end


    function rho = calc_rho(x,y,theta)
        rho = x*cosd(theta) + y*sind(theta);
    end
end
