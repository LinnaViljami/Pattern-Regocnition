function normalizedDist = calcHammDistBtwTestAndOther(fileIndex, row1Index)
file1 = load(sprintf('lab1-data-new(1)/person%02d.mat',fileIndex));
file2 = load('lab1-data-new(1)/testperson.mat');
row1Data = file1.iriscode(row1Index,:);
row2Data = file2.iriscode(1,:);

binaryAmount = numel(row1Data);
validBits = binaryAmount;
for i = 1:binaryAmount
    if (row2Data(i) == 2) 
        row1Data(i) = 0;
        row2Data(i) = 0;
        validBits = validBits - 1;
    end
end

hammingDistance = sum(bitxor(row1Data, row2Data));
normalizedDist = hammingDistance/validBits;
end


