%% Neighborhood Indexing

A = 1:4096;
A = reshape(A, [64 64]);
N = 3;
shift = 1;

nhood = zeros(N, N);

for i = 4:64-4
    for j = 4:64-4
        
        % Positive, Fractional Slope
        if shift == N
            new_pixel_value = median(A(i, j - floor(N/2) - N: j + floor(N/2) + N));
        else
            for k = 1:N
                row = i + floor(N/2) - (k-1);
                column = j - floor(N/2)*(shift+1) + (k-1)*shift;
                nhood(k,:) = A(row, column: column + N-1);
            end
            new_pixel_value = median(reshape(nhood, [1 N*N]));
        end
        
        % Negative, Fractional Slope
        if shift == N
            new_pixel_value = median(A(i, j - floor(N/2) - N: j + floor(N/2) + N));
        else
            for k = 1:N
                row = i + floor(N/2) - (k-1)
                column = j + floor(N/2)*(shift+1) + (k-1)*shift
                column - N + 1: column
                nhood(k,:) = A(row, column - N + 1: column)
            end
            new_pixel_value = median(reshape(nhood, [1 N*N]));

        end
        
        % Positive, Integer Slope
        if shift == N
            new_pixel_value = median(A(i - floor(N/2) - N: i + floor(N/2) + N, j));
        else
            for k = 1:N
                column = j + floor(N/2) - (k-1);
                row = i - floor(N/2)*(shift+1) + (k-1)*shift;
                nhood(k,:) = A(row: row + N-1, column);
            end
            new_pixel_value = median(reshape(nhood, [1 N*N]));
        end
        
        % Negative, Integer Slope
        if shift == N
            new_pixel_value = median(A(i - floor(N/2) - N: i + floor(N/2) + N, j));
        else
            for k = 1:N
                column = j + floor(N/2) - (k-1);
                row = i + floor(N/2)*(shift+1) - (k-1)*shift;
                nhood(k,:) = A(row - N +1 : row, column);
            end
            new_pixel_value = median(reshape(nhood, [1 N*N]));
        end
        
    end
end
