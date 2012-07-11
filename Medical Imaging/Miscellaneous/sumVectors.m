function [ finalLength ] = sumVectors( numberOfVectors )
%sumVectors Sums a specified number of random unit vectors that point along
%the arc 0 to pi. 
%   numberOfVectors The number of random, unit vectors desired to be summed.
%
%   finalLength The magnitude of the sum of the all the random, unit vectors. 

% Create an array of random points from 0 to 1.
randomPoints = rand(1, numberOfVectors);

% Transform the random points in the range 0 to 1 to points along the unit
% arc with angle given by the random value. 
randomAngles = (randomPoints*pi/2);

% Break each point down into an x and y component .
xComps = cos(randomAngles);    % r = 1, x = r*cos(angle)
yComps = sin(randomAngles);    % r = 1, y = r*sin(angle)  

% Find the total x and y components. 
xSum = sum(xComps);
ySum = sum(yComps);

% Use the pythagorean theorem. 
finalLength = sqrt(xSum^2 + ySum^2);

end

