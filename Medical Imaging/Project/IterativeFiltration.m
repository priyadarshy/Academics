%% BME 4783 - Medical Imaging Modalities
%
%  Daniel Amante, Jarel Cohen, Robert MacGregor, Ashutosh Priyadarshy
%  University of Virginia
%  Spring 2011

%function [] = IterativeFiltration(filename, nhood, filterCycles, gray2bin)

tic
clear all
clc

%%% File loading
% Load an Image into a matrix I.
sample = imread('cell2.jpg');
%sample = imread(filename);
originalSample = sample;

% Convert the Image to grayscale.
sample = rgb2gray(sample);

%%% Conditioning parameters.
% Pixel Neighborhood Size for median filter.
nhood = [8 8];    % Note: change each iteration?
% No. times we will median and adaptive histogram filter succesively.
filterCycles = 4;
% Binary thresholding of the grayscale image.
gray2bin = 190;

% Perform the double filtration filterCycles times.
for cycle = 1:filterCycles
    disp(cycle)
    % Apply Median Filtration pixel-wise in a n'hood of dim nhood.
    medFiltLast = medfilt2(sample, nhood);
    % Apply Adaptive Histogram Equalization.
    adaptHistEqLast = adapthisteq(medFiltLast);
    % Set the twice filtered image to be equal to the sample.
    sample = adaptHistEqLast;
    
end

% Create a black and white image from the grayscale image.
binSample = sample > gray2bin;

% Median Filter the BinSample to remove speckling.
binSampleFiltered = medfilt2(binSample, nhood);

%% Image Display and Visualization

figure(1)
imshow(originalSample)
title('Original Image')

figure(2)
imshow(medFiltLast)
title('Final Median Filtered Picture')

figure(3)
imshow(adaptHistEqLast)
title('Final Adaptive Histogram Equalization Picture')

figure(4)
imshow(binSample);
title('Filtered Image with Binary Thresholding Applied')

figure(5)
imshow(binSampleFiltered);
title('Filtered Image with Binary Thresholding Applied')

%% Perform the Cell Counting.
figure(6)
%B = bwboundaries(binSampleFiltered);
B = bwboundaries(binSampleFiltered, 'noholes');
imshow(originalSample)
title('Original Image with "Found Cells" Overlaid from overconfluent.tif ');
text(10,10,strcat('\color{blue}Objects Found:',num2str(length(B))))
hold on

for k = 1:length(B)
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 0.4)
end

toc

%end


