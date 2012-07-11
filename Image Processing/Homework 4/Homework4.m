%% Image deblurring with a Pseudo-Inverse Filter
%
%   Ashutosh Priyadarshy
%
%   Spring 2012
%
%   Digital Image Processing
%
%   Homework 4
%

% Setup
clear all; close all;
load ugly.mat

u = ugly;       % Space-domain image.
U = fft2(u);    % DFT-domain image. 

% Guess and create the original filter.
width = 5;      % This is a guess based on the edge artifacts.
filterkernel = zeros(128, 128);
filterkernel(1:width, 1:width) = 1;
% This is a guess of the DFT of the image that blurred Colby. 
G = fft2(filterkernel); 

% G_zero tells us where the filter is 0.
G_zero = G == 0; 
% Create the inverse filter.
Ginv = 1./G;
% Create the inverse filter by removing frequencies that were 0 in the org.
Gpinv = Ginv .* ~G_zero; 

% Deconvolve the Ugly image.
RES = Gpinv .* U;
% Return to the space domain.
res = ifft2(RES);

% Present the results:
figure; 
imagesc(real(res)); axis square;
title('Result - Deblurred Colby');
colormap gray

figure; 
imagesc(real(u)); axis square;
title('Original - Blurry Colby');
colormap gray
