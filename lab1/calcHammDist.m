function normalizedDist = calcHammDist(fileIndex, row1Index, row2Index)
file = load(sprintf('lab1-data-new(1)/person%02d.mat',fileIndex));
row1Data = file.iriscode(row1Index,:);
row2Data = file.iriscode(row2Index,:);

hammingDistance = sum(bitxor(row1Data, row2Data));
normalizedDist = hammingDistance/numel(row1Data);
end

