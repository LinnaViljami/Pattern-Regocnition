function [smallestFileIndex, smallestRowIndex, smallestDist] = findSmallestDistance()
    smallestDist = 1000;
    smallestFileIndex = -1;
    smallestRowIndex = -1;
    fileTest = load('lab1-data-new(1)/testperson.mat');
    for fileIndex = 1:20
       file = load(sprintf('lab1-data-new(1)/person%02d.mat',fileIndex));
       for rowIndex = 1:20
        testFileData = fileTest.iriscode(1,:);
        rowData = file.iriscode(rowIndex,:);       
        binaryAmount = numel(rowData);
        validBits = binaryAmount;
        for i = 1:binaryAmount
            if (testFileData(i) == 2) 
                rowData(i) = 0;
                testFileData(i) = 0;
                validBits = validBits - 1;
            end
        end
        
        hammingDistance = sum(bitxor(rowData, testFileData));
        normalizedDist = hammingDistance/validBits;
        if normalizedDist < smallestDist
            smallestDist = normalizedDist;
            smallestFileIndex = fileIndex;
            smallestRowIndex = rowIndex;
        end
       end   
    end
end

