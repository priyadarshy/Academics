% BME 4783 - Medical Imaging Modalities
%
%  Daniel Amante, Jarel Cohen, Robert MacGregor, Ashutosh Priyadarshy
%  University of Virginia
%  Spring 2011

function [cellCount, MN_bounds]= CellCounterFinal(image,fine_tune_knob,cell_define)
% CellCounterFinal This function counts the number of cells in an image of
% cells. It displays the original grayscale image with overlays of counted
% cell boundaries.
% image is the image's file directory location.
% fine_tune_knob sets a desired ratio between mean and standard deviation.
% cell_define sets the threshold to go from 8 bit grayscale to binary.

% Notes:
%fine_tune_knob: turn down to lower speckle, up to get more accurate cell
%outlines
%cell_define: turn up on low contrast images, default 190

% Start a timer to measure the speed at which the code runs.
tic

% Load an Image into a matrix I.
sample = imread(image);
% Convert the Image to grayscale call it sample.
sample = rgb2gray(sample);
% Store in memory a un-modified copy of the grayscale image.
originalSample = sample;

% Filtration paramaters.
filterCycles = 4;     % Number of times image is filtered.
nhoodsize = 4;      % Neighberhood size for median filter. 
% Binary thresholding of the grayscale image.
gray2bin = cell_define;
% Set up parameters for the statistical pattern recognition.
stddev = 10; avg = 1; ratio = stddev/avg;
% Initialize the number of cells in the image to 0.
cells = 0;

% Visualization parameters.
doubleCountColor = '';
singleCountColor = '';
uncountedColor = '';

% Begin the routine that converges to an accurate cell count.
% Continue varying parameters and counting cells until ratio is greater
% than the desired ratio.
while(ratio > fine_tune_knob)
    
    % Increment the neighborhood size of the median filter.
    nhoodsize = nhoodsize+1;
    % Re-initialize the histdata to 0 everytime the loop runs.
    cellSizeData = 0;
    
    while(avg ~= mean(cellSizeData))
        %%% Conditioning parameters.
        % Square Pixel Neighborhood Size for median filter.
        nhood = [nhoodsize nhoodsize];  
        % TODO
        area = avg-stddev/4;
        % Reset sample to be the original grayscale image again.
        sample = originalSample;
        
        %%% Begin Filtering Block
        % Perform the double filtration filterCycles times.
        for cycle = 1:filterCycles
            % Apply Median Filtration pixel-wise in a n'hood of dim nhood.
            medFiltLast = medfilt2(sample, nhood);
            % Apply Adaptive Histogram Equalization.
            adaptHistEqLast = adapthisteq(medFiltLast);
            % Set the twice filtered image to be equal to the sample.
            sample = adaptHistEqLast;
        end
        
        %%% Begin Thresholding Block
        % Create a black and white image from the grayscale image.
        binSample = sample > gray2bin;
        % Median Filter the BinSample to remove speckling.
        binSampleFiltered = medfilt2(binSample, nhood);
        
        %%% Beging Moore-Neighbor Block
        % Perform the Moore-Neighbor method, disallow enclosed boundaries.
        MN_bounds = bwboundaries(binSampleFiltered,'noholes');
        [t1 t2] = BoundaryExtractionTest(MN_bounds);
        
        % Clear the console. 
        clc
        
        %%% Begin Statistical Pattern Recognition Block.
        % Initialize a vector to hold the areas of counted cells.
        cellSizeData = zeros(length(MN_bounds),1);
        
        % Iterate through every counted boundary in MN_bounds. 
        for k = 1:length(MN_bounds)
            % Extract the k-th cell and store it in a matrix. 
            boundary = MN_bounds{k};
            % Use trapezoidal integration to find the area enclosed by the
            % kth boundary.
            currentCellArea = abs(trapz(boundary(:,1),boundary(:,2)));
            % Place the currentCellArea value in the cell area data vector.
            cellSizeData(k) = currentCellArea;
        end
        
        % Compute Statistics from the accumulated cellSizeData. 
        avg = mean(cellSizeData);       % Average Size.
        deviation = std(cellSizeData);  % Average standard deviation.
        
        % TODO - what the fuck?
        nhoodsize = nhoodsize;
        % Display and calculate the current ratio.
        ratio = deviation/avg
        
    end
end

% End the timing of the routine and display it. 
toc

%%% Begin Result Visualization block.
figure                  % Create a new figure handle. 
imshow(originalSample)  % Show the original bw image.
hold on                 % Enable superimposed display.

% TODO
doublecellSizeData = zeros((2*length(MN_bounds))+1,1);

% Iterate through all the boundaries identified by Moore-Neighbor.
for k = 1:length(MN_bounds)
    
    % Explicitly de-reference the k-th cell and store it in a Matrix.
    boundary = MN_bounds{k}; 
    % Use trapezoidal integration to calculate the area enclosed by the
    % current boundary.
    currentCellArea = abs(trapz(boundary(:,1), boundary(:,2)));
   
    % Draw a white-outline on the image for the current cell's boundary. 
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 0.4)
    
    % If it is likely that the current boundary comprises two real cells. 
    if currentCellArea > area && currentCellArea <= 3*avg;
        % Then plot this boundary in 
        plot(boundary(:,2), boundary(:,1), 'k', 'LineWidth', 2)
        doubleCellSizeData(k) = currentCellArea;
    end
    
    % If it is likey the current boundary comprises petri-dish.
    if currentCellArea > 3*avg && currentCellArea < 6*avg;
        % Then plot this boundary in white. 
        plot(boundary(:,2), boundary(:,1), 'y', 'LineWidth', 1.5)
        doubleCellSizeData(2*k) = currentCellArea;
    end
    
end

% Keep all the non-zero entries in doubleCellSizeData (valid entries).
doubleCellSizeData = doubleCellSizeData(doubleCellSizeData~=0);

% Display some final values on the image and title the image. 
text(10,10,strcat('\color{green}Initial Cell Count:', num2str(length(cellSizeData))))
text(10,30,strcat('\color{yellow}Filtered Cell Count:', num2str(length(doubleCellSizeData))))
title('Original Image with "Found Cells" Overlaid');

% Save the total cell count in cellCount.
cellCount = length(doubleCellSizeData);
