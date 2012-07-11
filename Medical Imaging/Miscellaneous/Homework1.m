%% Homework 1

% Define the number of random vectors desired.
numberOfVectors = [64 256 4096];

% Compute the final length and expectedLength for each cardinality of
% random vectors.
for iSizes = 1:length(numberOfVectors)
    currentNumberOfVectors = numberOfVectors(iSizes)
    finalLength = sumVectors(numberOfVectors(iSizes))
    expectedLength = numberOfVectors(iSizes)/sqrt(2)
end
