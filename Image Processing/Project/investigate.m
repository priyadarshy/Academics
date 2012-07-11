%% Term Project
%
%  Ashutosh Priyadarshy
%
%  Digital Image Processing - Spring 2012
%
%  Cell Counting and Segmentation
%
%  input img = img1

% Clear all variable and close all figures.
close all; clear all;

% Read in all the images.
img1 = imread('cell1.jpg');
img2 = imread('cell2.jpg'); img2(:, :, 3) = 0;
img3 = imread('cell3.jpg');

% Choose an Image to work with in graycale. 
original = img2; 
img = rgb2gray(img2);
img = adapthisteq(img); 
figure; imagesc(img); title('Original Image'); 

% Perform Anisotropic Diffusion @50 iterations and k = 2; 
img = anisotropic_diffusion(img, 50, 2); 
figure; imagesc(img); title('The Image after Anisotropic Diffusion'); 

%perform full-contrast histogram stretch
img = imadjust(img); img = adapthisteq(img); 
% Reshape to a linear array of intensity in order to perform a K-means. 
intns = double(reshape(img, [size(img,1)*size(img,2), 1]));

% Perform K-Means Clustering
[cluster_idx cluster_center] = kmeans(intns,3);
label_mat =  reshape(cluster_idx, [768 1024]);
figure; imagesc(label_mat); title('The Label Matrix following k-means Clustering');
colorbar; 

% Choose the desired label form the label matrix. 
segments = label_mat == 3; 
figure; imagesc(segments); 

% Extract the boundaries of the segments (Moore-Neighbor). 
B = bwboundaries(segments);
figure; imagesc(original); title('Original Image with Overlaid Segmentation'); 

hold on;
cell_count = 0;             % Initialize a count of cells. 
for k = 1:length(B)
    
    % Extract the boundary. 
    boundary = B{k};
    
    % Find the perimeter...threshold based on this.
    perim(k) = length(boundary); 
    
    % Set a perimeter threshold and draw the boundary if it's met. 
    if (perim(k) > 80)
        cell_count = cell_count + 1; 
        % Show the final segmentation on the original image. 
        plot(boundary(:, 2), boundary(:,1), 'w'); 
    end
  
end
title(['Final Segmentation with ' num2str(cell_count) ' cells.']);

    


