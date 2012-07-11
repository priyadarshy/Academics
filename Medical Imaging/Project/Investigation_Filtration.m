%% BME 4783 - Medical Imaging Modalities
%
%  Investigate Effects of Filtering Techniques on Intesity Histograms.
%
%  Daniel Amante, Jarel Cohen, Robert MacGregor, Ashutosh Priyadarshy
%  University of Virginia
%  Spring 2011

clear all
close all

%%% File loading
% Load an Image into a matrix I.
sample = imread('confluent.tif');
%sample = imread(filename);
originalSample = sample;

% Convert the Image to grayscale.
%sample = rgb2gray(sample);

%%% Conditioning parameters.
% Pixel Neighborhood Size for median filter.
nhood = [4 4];    % Note: change each iteration?
% No. times we will median and adaptive histogram filter succesively.
filterCycles = 4;
% Binary thresholding of the grayscale image.
gray2bin = 190;

I = []; 
color = ['bgrcmyk'];

% Perform the medfilt2 filtration filterCycles times.
for cycle = 1:filterCycles
    
    % Apply Median Filtration pixel-wise in a n'hood of dim nhood.
    medFiltLast = adapthisteq(sample);

    % Set the twice filtered image to be equal to the sample.
    sample = medFiltLast;
    
    % Calculate the intensity histogram.
    I = [I, imhist(sample)];
    
    % Display the intensity histogram.
    figure(1)
    subplot(filterCycles/2, 2, cycle);
    hold on
    plot(I(:,cycle),color(cycle))
    title('Intensity Histogram')
    text(20,20000,strcat('\color{black}Iteration:',num2str(cycle)))
    
    % Display the Image
    figure(2)
    subplot(filterCycles/2, 2, cycle);
    hold on
    imshow(sample)
    title('Histogram Equalization')
    text(20,20,strcat('\color{yellow}Iteration:',num2str(cycle)))
        
end
