function [ image ] = mdmedfilt2( image, N, M )
%mdmedfilt2 Applys a multi-directional median filter with fixed area N^2.

% Set reference points of where the actual image beings in the zeropadded.
left_x = N^2;
right_x = N^2 + size(image,1) - 1;
top_y = N^2;
bottom_y = N^2 + size(image,2) - 1;

% Declare the index where the image will sit in the zeros.
padded_x_index = left_x : right_x;
padded_y_index = top_y : bottom_y;
% Zero-pad the image by zeros.
zeropadded = uint8(zeros(size(image,1)+N^2*2, size(image,2)+N^2*2));
zeropadded(left_x:right_x, top_y:bottom_y) = image;


% Pre-allocate space for the neighborhoods that will be created.
nhood = zeros(N, N);

% Coordinate systems:
% (i, j) - Zeropadded centric coordinate system.
% (x, y) - Corresponding coordinates in the image only.
for i = padded_x_index
    for j = padded_y_index
        
        % Find the index of the pixel in the original image.
        x = find(padded_x_index == i);
        y = find(padded_y_index == j);
        
        % Find the desired slope/neighborhood type.
        m = M(x, y);
        
        % Positive, Fractional Slope
        if sign(m) == 1 && abs(m) <= 1
            shift = 1/abs(m);
            if shift == N
                new_pixel_value = median(zeropadded(i, j - floor(N/2) - N: j + floor(N/2) + N));
            else
                for k = 1:N
                    row = i + floor(N/2) - (k-1);
                    column = j - floor(N/2)*(shift+1) + (k-1)*shift;
                    nhood(k,:) = zeropadded(row, column: column + N-1);
                end
                new_pixel_value = median(reshape(nhood, [1 N*N]));
            end
        % Negative, Fractional Slope   
        elseif sign(m) == -1 && abs(m) <= 1
            shift = 1/abs(m);
            if shift == N
                new_pixel_value = median(zeropadded(i, j - floor(N/2) - N: j + floor(N/2) + N));
            else
                for k = 1:N
                    row = i + floor(N/2) - (k-1);
                    column = j + floor(N/2)*(shift+1) + (k-1)*shift;
                    column - N + 1: column;
                    nhood(k,:) = zeropadded(row, column - N + 1: column);
                end
                new_pixel_value = median(reshape(nhood, [1 N*N]));
                
            end
        % Positive, Integer Slope            
        elseif sign(m) == 1 && abs(m) >= 1
            shift = abs(m);
            if shift == N
                new_pixel_value = median(zeropadded(i - floor(N/2) - N: i + floor(N/2) + N, j));
            else
                for k = 1:N
                    column = j + floor(N/2) - (k-1);
                    row = i - floor(N/2)*(shift+1) + (k-1)*shift;
                    nhood(k,:) = zeropadded(row: row + N-1, column);
                end
                new_pixel_value = median(reshape(nhood, [1 N*N]));
            end
        % Negative, Integer Slope
        elseif sign(m) == -1 && abs(m) >= 1
            shift = abs(m);
            if shift == N
                new_pixel_value = median(zeropadded(i - floor(N/2) - N: i + floor(N/2) + N, j));
            else
                for k = 1:N
                    column = j + floor(N/2) - (k-1);
                    row = i + floor(N/2)*(shift+1) - (k-1)*shift;
                    nhood(k,:) = zeropadded(row - N +1 : row, column);
                end
                new_pixel_value = median(reshape(nhood, [1 N*N]));
            end
            
        else
            %disp('Not a valid slope');
            %disp(m);
            nhood = zeropadded(i - floor(N/2) : i - floor(N/2) + N - 1, j-floor(N/2): j-floor(N/2) + N - 1);
            new_pixel_value = median(reshape(nhood, [1 N*N]));
        end
        
        image(x,y) = new_pixel_value;
        
    end
end




end

