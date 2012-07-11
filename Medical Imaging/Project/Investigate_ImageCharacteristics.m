%% BME 4783 - Medical Imaging Modalities
%
%  Image Characterization 
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
% Convert the Image to grayscale. COMMENT THIS OUT FOR .tif files
sample = rgb2gray(sample);

% Display Original Image.
figure(1)
H0 = entropy(originalSample);
imshow(originalSample)
title('Original Picture of Cell Culture')
text(10,10,strcat('\color{blue}Entropy:',num2str(H0)))

% Display Grayscale Image.
figure(2)
Hg = entropy(sample);
imshow(sample)
title('Picture of Cell Culture in Grayscale')
text(10,10,strcat('\color{blue}Entropy:',num2str(Hg)))

% Contrast visualization.
figure(3)
imhist(sample)
title('Histogram of Intensity Values in Grayscale Image')

% Frequency Analysis
figure(4)
f = sample;
imshow(f,'InitialMagnification','fit')
F = fft2(f,256,256);
F2 = log(abs(F));
imshow(F2,[-1 5],'InitialMagnification','fit'); colormap(jet); colorbar
title('2 Dimensional Fast Fourier Transform of Grayscale Image');


