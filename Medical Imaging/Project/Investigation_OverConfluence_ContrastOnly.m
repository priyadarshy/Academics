%% BME 4783 - Medical Imaging Modalities
%
%  Investigate Some Properties of Overconfluence.
%
%  Daniel Amante, Jarel Cohen, Robert MacGregor, Ashutosh Priyadarshy
%  University of Virginia
%  Spring 2011

%% Show contrast via histogram.
% The following is a quick analysis of the overly confluent cell culture.
% It looks the contrast of the image is very high (spread out initially) so
% this means we need to change how we binary threshold from grayscale to
% black and white perhaps. 

clear all
clc

%%% File loading
% Load an Image into a matrix I.
sample = imread('overconfluent.tif');
originalSample = sample;

subplot(2,1,1);
imshow(originalSample);
title('Original Image');

subplot(2,1,2);
imhist(originalSample)
title('Intensity Histogram for Overly Confluent Image');
