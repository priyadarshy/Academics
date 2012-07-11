%% Homework 1
% Ashutosh Priyadarshy
% Digital Image Processing
% Spring 2012
% University of Virginia
%
% Axon Segmentation
%
% Images:
% controlneuron.jpg
% axons.jpg
%
% Outputs:
% 1. Segementation of both images from the same algorithm.
% 2. Percentage of each binary image occupied by axon.
%

%% Setup
clear all;
close all;

% Load the RGB images. 
axons = imread('axons.jpeg');
controlneuron = imread('controlneuron.jpeg');
figure; imshow(axons); title('Full Colour Image');
% Convert the iamges to grayscale intensity images. 
axons = rgb2gray(axons);
controlneuron = rgb2gray(controlneuron);

%%% Axons Image
T_a = 19;                          
se_a_sq = strel('line', 3, 90);
% Threshold the image. 
axons = axons > T_a;
% Show the thresholded image.
figure; imshow(axons); 
title(' Original Thresholded Image ');
% Binary majority and show.
axons = bwmorph(axons, 'majority');
figure; imshow(axons);
title(' Binary Majority Applied ');

% Show the eroded image. 
axons = imerode(axons, se_a_sq);
figure; imshow(axons);
title(' Erosion Applied ');

% Dilate and show the image.
%axons = imdilate(axons, strel('line', 15, 0));
figure; imshow(imclose(axons, strel('line', 15, 0) ));
title(' Dilation Applied ');


