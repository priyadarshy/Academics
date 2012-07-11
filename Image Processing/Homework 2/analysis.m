%% Homework 2
close all; clear all;  

% Read in all the images. 
img0 = imread('no+degeneration.jpg');
img1 = imread('very+little+degeneration.jpg');
img2 = imread('medium+degeneration.jpg');
img3 = imread('70-80+percent+degeneration.jpg');

% Choose an image to process. 
img = img3(:,:, 2);      % Green channel only. 

% Attempt the algorithm for various neighborhoods. 
hood_sizes = 5:2:9;
% Create a stacked image that holds the results for each neighborhood. 
res = zeros(size(img,1), size(img,2), length(hood_sizes)); 


% Pad the image for processing. 
for n = 1:length(hood_sizes)
    
    % De-reference the size of the square neighborhood. 
    a = hood_sizes(n); 
    % We still want to consider only a subset of pixels in the analysis. 
    margin = floor(a/2); 
    % Replicate-Pad the image. 
    img = padarray(img, [a-1 a-1], 'replicate');
    
    % To see how far we have progressed.
    n 
    
    % Ignore synthetic boundaries.  
    for i = margin+1:size(img, 1)-margin-1
        for j = margin+1:size(img, 2)-margin-1

            nhood = img(i-margin:i+margin, j-margin:j+margin) - 127;
            nhood = double(nhood);
            
            % Look for similarity of the rotated neighborhood. 
            res(i,j,n) = mean(mean((nhood^2)));

        end
    end

end

disp('Remember to save variable res as a .mat file');




