%% BME 4783 - Medical Imaging Modalities
%
%  Investigate Effects of Commutivity of Filters.
%
%  Daniel Amante, Jarel Cohen, Robert MacGregor, Ashutosh Priyadarshy
%  University of Virginia
%  Spring 2011

clear all
close all

%%% File loading
% Load an Image into a matrix I.
sample = imread('cell2.jpg');
%sample = imread(filename);
originalSample = sample;

% Convert the Image to grayscale.
sample = rgb2gray(sample);
originalSample = sample;

%%% Conditioning parameters.
% Pixel Neighborhood Size for median filter.
nhood = [9 9];    % Note: change each iteration?
% No. times we will median and adaptive histogram filter succesively.
filterCycles = 4;
% Binary thresholding of the grayscale image.
gray2bin = 190;


%% Perform Cascading Filtration.
% Perform the medfilt2 filtration filterCycles times.
for cycle = 1:filterCycles
    
    % Apply Median Filtration pixel-wise in a n'hood of dim nhood.
    medFiltLast = medfilt2(sample, nhood);

    % Set the twice filtered image to be equal to the sample.
    sample = medFiltLast;

end

% Perform the adapthisteq filtration filterCycles times.
for cycle = 1:filterCycles
    
    % Apply Adaptive Histogram Equalization.
    adaptHistEqLast = adapthisteq(sample);

    % Set the twice filtered image to be equal to the sample.
    sample = adaptHistEqLast;

end
% Save the cascaded version as a seperate matrix.
sampleCascade = sample;
sampleCascadeBin = sampleCascade > gray2bin;


%% Perform back-to-back filtration (original method).
% Reset to the originalSample.
sample = originalSample;

% Perform the double filtration filterCycles times.
for cycle = 1:filterCycles
    
    % Apply Median Filtration pixel-wise in a n'hood of dim nhood.
    medFiltLast = medfilt2(sample, nhood);
    % Apply Adaptive Histogram Equalization.
    adaptHistEqLast = adapthisteq(medFiltLast);
    % Set the twice filtered image to be equal to the sample.
    sample = adaptHistEqLast;
    
end
% Save the back to back version as a seperate matrix.
sampleBack2Back = sample;
sampleBack2BackBin = sampleBack2Back > gray2bin;

hold on
plot(sum(sampleBack2BackBin == sampleCascadeBin)./768, 'b')
xlabel('Horizontal Pixel')
ylabel('Percent Match in Horizontal Row')
title('Matching Between Cascade Filtration and Back to Back Filtration');
axis([0 1024 0 1.1])



