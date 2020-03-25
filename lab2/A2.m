syms a b c d k;
ALLF = [a*k,b*k;c*k,d*k];

symCov = ALLF;
for j = 1:2
    for i = 1:2
        varr = 0;
        for s1 = 1:2
            varr = varr + ((ALLF(s1, i)-mean(ALLF(:,i)))*(ALLF(s1, j)-mean(ALLF(:,j))));
        end
        
        symCov(j,i) = varr;
    end
end
symCov
