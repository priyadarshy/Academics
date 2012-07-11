% Read in the file.
image = imread('cell2.jpg');
% Convert the Image to grayscale.
sample = rgb2gray(image);

% Compute the gradient of the image. 
[Fx Fy] = gradient(double(sample), 100, 100);

% The problem with presegmenting is that we are wasting information by
% zero-padding. 
% For each pixel we want to compute its optimum median index from the
% gradient. 

orientation_binary = (Fx./Fy) > 1; 
temp = sample;
%  
% for y = 1:768
%     for x = 1:1024
%          d
%          nhood = temp(y - dy : y + dy, x - dx : x + dx) 