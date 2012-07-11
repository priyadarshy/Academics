clear all; close all; 

% Load the RGB images. 
axons = imread('axons.jpeg');
controlneuron = imread('controlneuron.jpeg');

% Convert the iamges to grayscale intensity images. 
axons = rgb2gray(axons);
neuron = rgb2gray(controlneuron);

axons = adapthisteq(axons);
neuron =  adapthisteq(neuron); 
%%
% Create the intensity histogram. 
[pdf_axons, x_axons] = imhist(axons);
[pdf_neuron, x_neuron] = imhist(neuron);

% Find the cumulative distribution of the above histograms.
for i = 1:length(x_axons)
    cdf_axons(i) = sum(pdf_axons(1:i));
    cdf_neuron(i) = sum(pdf_neuron(1:i));
end

lb = 0.70;
ub = 0.82;
% Find the halfway point or so. 
for i = 1:length(x_axons)
    if (cdf_axons(i) >= lb .* cdf_axons(end) && cdf_axons(i) <= ub .* cdf_axons(end))
        critical_index_axons = i;
    end
    if (cdf_neuron(i) >= lb .* cdf_neuron(end) && cdf_neuron(i) <= ub .* cdf_neuron(end))
        critical_index_neuron = i;
    end
end

% Set the thresholds. 
T_axons = critical_index_axons;
T_neuron = critical_index_neuron;

% Binary Threshold the images.
axons = axons > T_axons;
neuron = neuron > T_neuron; 

% Show the thresholded images. 
subplot(2,1,1); imshow(axons);
subplot(2,1,2); imshow(neuron); 