%% BME 4783 - Medical Imaging Modalities
%
%  Daniel Amante, Jarel Cohen, Robert MacGregor, Ashutosh Priyadarshy
%  University of Virginia
%  Spring 2011
%cell 1 = 148 cells
%cell 2 = 200-225 cells
%cell 3 = 103ish
clear all
close all
tic

%%% File loading
% Load an Image into a matrix I.
sample = imread('cell2.jpg');
originalSample = rgb2gray(sample);
% Convert the Image to grayscale.
sample = rgb2gray(sample);
h_sample = sample;
l_sample = sample;

%%% Conditioning parameters.
% Pixel Neighborhood Size for median filter.
nhood = [4 4];    % Note: change each iteration?
hhood = [16 2];
lhood = [2 16];
avg = 67;
stddev= 31;
circum = avg - stddev/4;
% No. times we will median and adaptive histogram filter succesively.
filterCycles = 4;
% Binary thresholding of the grayscale image.
gray2bin = 190;


% Perform the double filtration filterCycles times.
for cycle = 1:filterCycles
    disp(cycle)
    % Apply Median Filtration pixel-wise in a n'hood of dim nhood.
    medFiltLast = medfilt2(sample, nhood);
    h_medFiltLast = medfilt2(sample, hhood);
    l_medFiltLast = medfilt2(sample, lhood);
    % Apply Adaptive Histogram Equalization.
    adaptHistEqLast = adapthisteq(medFiltLast);
    h_adaptHistEqLast = adapthisteq(h_medFiltLast);
    l_adaptHistEqLast = adapthisteq(l_medFiltLast);
    % Set the twice filtered image to be equal to the sample.
    sample = adaptHistEqLast;
    h_sample = h_adaptHistEqLast;
    l_sample = l_adaptHistEqLast;
    
end

% Create a black and white image from the grayscale image.
binSample = sample > gray2bin;
h_binSample = h_sample > gray2bin;
l_binSample = l_sample > gray2bin;

% Median Filter the BinSample to remove speckling.
binSampleFiltered = medfilt2(binSample, nhood);
h_binSampleFiltered = medfilt2(h_binSample, hhood);
l_binSampleFiltered = medfilt2(l_binSample, lhood);

% Perform the Cell Counting.
figure(7)
%B = bwboundaries(binSampleFiltered);
B = bwboundaries(binSampleFiltered,'noholes');
H = bwboundaries(h_binSampleFiltered,'noholes');
L = bwboundaries(l_binSampleFiltered,'noholes');
imshow(originalSample)
title('Original Image with "Found Cells" Overlaid');
hold on
toc

histdata=zeros(length(B),1);
twohistdata=zeros(length(B),1);
halfhistdata=zeros(length(B),1);
h_histdata=zeros(length(H),1);
l_histdata=zeros(length(L),1);
shorthistdata=zeros((2*length(B))+1,1);
for k = 1:length(B)
    boundary = B{k}; histdata(k)=length(boundary(:,1));
    plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 0.4)
    if length(boundary(:,2)) > 0.5*circum;
        halfhistdata(k)=length(boundary(:,1));
        plot(boundary(:,2), boundary(:,1), 'm', 'LineWidth', 0.4)
    end
    if length(boundary(:,2)) > circum;
        plot(boundary(:,2), boundary(:,1), 'y', 'LineWidth', 0.4)
        shorthistdata(k) = length(boundary(:,1));
        if length(boundary(:,2)) > 2*avg;
            shorthistdata(k)=length(boundary(:,1))/2;
            shorthistdata(2*k)=length(boundary(:,1))/2;
            plot(boundary(:,2), boundary(:,1), 'y', 'LineWidth', 3)
        end
    end
    if length(boundary(:,2)) > 2*circum;
        twohistdata(k)=length(boundary(:,1));
        plot(boundary(:,2), boundary(:,1), 'c', 'LineWidth', 0.4)
    end

end

for k = 1:length(H)
    boundary = H{k};
    if length(boundary(:,2)) > 1;
        h_histdata(k)=length(boundary(:,1));
        plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 0.4)
    end
end
for k = 1:length(L)
    boundary = L{k};
    if length(boundary(:,2)) > 1;
        l_histdata(k)=length(boundary(:,1));
        plot(boundary(:,2), boundary(:,1), 'b', 'LineWidth', 0.4)
    end
end
halfhistdata=halfhistdata(halfhistdata~=0);
shorthistdata=shorthistdata(shorthistdata~=0);
twohistdata=twohistdata(twohistdata~=0);
h_histdata=h_histdata(h_histdata~=0);
l_histdata=l_histdata(l_histdata~=0);
text(10,10,strcat('\color{green}Initial Cell Count:',num2str(length(histdata))))
text(10,30,strcat('\color{yellow}Filtered Cell Count:',num2str(length(shorthistdata))))
text(10,50,strcat('\color{red}Vertical Cell Count:',num2str(length(h_histdata))))
text(10,70,strcat('\color{blue}Horizontal Cell Count:',num2str(length(l_histdata))))
text(10,90,strcat('\color{cyan}Double cutoff Cell Count:',num2str(length(twohistdata))))
text(10,110,strcat('\color{magenta}Half cutoff Cell Count:',num2str(length(halfhistdata))))
figure(3);hold on;
subplot (6,1,1)
[y x] =hist(histdata,20);

bar(x,y,'g'); axis([0 max(histdata) 0 150]);
text(0.5*max(histdata),25,strcat('mean',num2str(mean(histdata))))
text(0.5*max(histdata),100,strcat('stddev',num2str(std(histdata))))
subplot (6,1,2)
[y x] =hist(halfhistdata,20);
bar(x,y,'m'); axis([0 max(histdata) 0 150]);
subplot (6,1,3)
[y x] =hist(shorthistdata,20);
bar(x,y,'y'); axis([0 max(histdata) 0 150]);
text(0.5*max(histdata),25,strcat('mean',num2str(mean(shorthistdata))))
text(0.5*max(histdata),100,strcat('stddev',num2str(std(shorthistdata))))
subplot (6,1,4)
[y x] =hist(twohistdata,20);
bar(x,y,'c'); axis([0 max(histdata) 0 150]);
subplot (6,1,5)
[y x] =hist(h_histdata,20);
bar(x,y,'r'); axis([0 max(histdata) 0 150]);
[y x] =hist(l_histdata,20);
subplot (6,1,6)
bar(x,y,'b'); axis([0 max(histdata) 0 150]);

clearvars -except B H L histdata twohistdata halfhistdata  shorthistdata l_histdata h_histdata