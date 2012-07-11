%% Hashing Function For Cell Counting
%
% BME 4783 - Medical Imaging Modalities
% 
% Daniel Amante, Robert MacGregor, Ashutosh Priyadarshy, and Christian
% Viehland
%
% University of Virginia - Spring 2011
%

function [hotspots] = hash( image, vertFreq, horizFreq )

    % Set up some variables and constants.
    
    dim = size(image);  % Dimensions of the image.
    
    horPixels = dim(2);  % Store the number of pixels in the 
    vertPixels = dim(1);
    
    horHashes = vertPixels * horizFreq;
    vertHashes = horPixels * vertFreq;
    
    for verticalIndex = 1:vertPixels/vertHashes:vertPixels
        for horizontalIndex = 1:horPixels/horHashes:horPixels
            
            verticalIndex = floor(verticalIndex);
            horizontalIndex = floor(horizontalIndex);
           
%             if( image(horizontalIndex, verticalIndex) == 1 )
%                 hotspots() = [horizontalIndex verticalIndex];
%             end
%             
        end
    end
    
    
    


end
