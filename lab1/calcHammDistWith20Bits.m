function normalizedDist = calcHammDistWith20Bits(file1Index, file2Index, row1Index, row2Index)
file1 = load(sprintf('lab1-data-new(1)/person%02d.mat',file1Index));
file2 = load(sprintf('lab1-data-new(1)/person%02d.mat',file2Index));
testfile = load('lab1-data-new(1)/testperson.mat');
row1Data = file1.iriscode(row1Index,:);
row2Data = file2.iriscode(row2Index,:);

hammingDistance = 0;
for i = 1:30    
    if testfile.iriscode(i)~=2 && row1Data(i) ~= row2Data(i)
        hammingDistance = hammingDistance + 1;
    end
    
end
normalizedDist = hammingDistance/20;
end

