function [cells, B]= MIMSProjectRevC(image,fine_tune_knob,cell_define)
% BME 4783 - Medical Imaging Modalities
%
%  Daniel Amante, Jarel Cohen, Robert MacGregor, Ashutosh Priyadarshy
%  University of Virginia
%  Spring 2011

%fine tune knob: (turn down to lower speckle, up to get more accurate cell
%outlines

%cell_define: turn up on low contrast images, default 190

%cell 1 = 148 cells
%cell 2 = 200-225 cells
%cell 3 = 103ish
tic
%%% File loading
% Load an Image into a matrix I.
cells=0;
sample = imread(image);
% Binary thresholding of the grayscale image.
gray2bin = cell_define;
% Convert the Image to grayscale.
sample = rgb2gray(sample);
originalSample = sample;
stddev= 10; avg = 1; ratio=stddev/avg;
nhoodsize=4;
while(ratio>fine_tune_knob)
    nhoodsize=nhoodsize+1;
    histdata=0;
    while(avg~=mean(histdata))
        %%% Conditioning parameters.
        % Pixel Neighborhood Size for median filter.
        nhood = [nhoodsize nhoodsize];    % Note: change each iteration?
        area = avg-stddev/4
        sample=originalSample;
        % Perform the double filtration filterCycles times.
        for cycle=1:4
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
        % Perform the Cell Counting.
        B = bwboundaries(binSampleFiltered,'noholes');
        clc
        histdata=zeros(length(B),1);
        
        for k = 1:length(B)
            boundary = B{k};
            X= abs(trapz(boundary(:,1),boundary(:,2)));
            histdata(k)=X;
        end
        avg= mean(histdata); deviation= std(histdata);
        nhoodsize=nhoodsize
        ratio= deviation/avg
        
    end
end
toc
figure()
imshow(originalSample)
title('Original Image with "Found Cells" Overlaid');
hold on
doublehistdata=zeros((2*length(B))+1,1);
for k = 1:length(B)
    
    boundary = B{k}; X = abs(trapz(boundary(:,1),boundary(:,2)));
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 0.4)
    
    if X > area && X <= 3*avg;
        plot(boundary(:,2), boundary(:,1), 'k', 'LineWidth', 2)
        doublehistdata(k) = X;
    end
    
    if X > 3*avg && X < 6*avg;
        plot(boundary(:,2), boundary(:,1), 'y', 'LineWidth', 1.5)
        doublehistdata(2*k)=X;
    end
end
doublehistdata=doublehistdata(doublehistdata~=0);
text(10,10,strcat('\color{green}Initial Cell Count:',num2str(length(histdata))))
text(10,30,strcat('\color{yellow}Filtered Cell Count:',num2str(length(doublehistdata))))
cells=length(doublehistdata);
