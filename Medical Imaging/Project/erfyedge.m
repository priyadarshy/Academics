%% Generate an image with an edge given by the erf equation.
clear all;
% Specify the right side and left side values. 
Ir = 0; 
Il = 255;

% Set the blur parameter.
sigma = 1; 
% Set the length of the discrete vector of intensity to form the edge. 
x = -512:511;
edge = ((Ir-Il)/2 .* erf(x/(sqrt(2)*sigma))+1) ;

% Stack the edge on itself to form a 2D image. 
image = uint8(repmat(edge, [768, 1]));

% Form a slanted edge.
for i = 1:768
    slant(i, :) = circshift(image(1, :), [0 -i]);
end

% Display the image to confirm.
imshow(image)
% Save the file in .jpg format. 
imwrite(image, 'erfEdge.jpg', 'jpg')
% Save the slanted file in .jpg format.
imwrite(slant, 'slantErfEdge.jpg', 'jpg');

%% Generate a step edge.
% 
% x = -512:511;
% edge = 255*(x < 0);
% image = uint8(repmat(edge, [768, 1]));
% imshow(image)
% imwrite(image, 'stepEdge.jpg', 'jpg');