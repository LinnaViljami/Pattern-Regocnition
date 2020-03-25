function normalizedDist = calcHammDistBtwTwoFiles(file1Index, file2Index, row1Index, row2Index)
file1 = load(sprintf('lab1-data-new(1)/person%02d.mat',file1Index));
file2 = load(sprintf('lab1-data-new(1)/person%02d.mat',file2Index));
row1Data = file1.iriscode(row1Index,:);
row2Data = file2.iriscode(row2Index,:);

hammingDistance = sum(bitxor(row1Data, row2Data));
normalizedDist = hammingDistance/numel(row1Data);
end


