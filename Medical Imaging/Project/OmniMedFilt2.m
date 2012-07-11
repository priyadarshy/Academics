%% Multidirectional Median Filter
clear all;
image = imread('edges.jpg');
image = rgb2gray(image);

horiz_flag = 0; 

max_nh_length = 64;
N2 = 32;
K = 2*ones(size(image));

zeropad_temp_img = uint8(zeros(size(image,1)+max_nh_length*2, size(image,2)+max_nh_length*2));

left_x = max_nh_length;
right_x = max_nh_length + size(image,1) - 1;

top_y = max_nh_length;
bottom_y = max_nh_length + size(image,2) - 1;

zeropad_temp_img(left_x:right_x, top_y:bottom_y) = image;

padded_x_index = left_x : right_x;
padded_y_index = top_y : bottom_y;

for i = padded_x_index
    for j = padded_y_index
        
        true_x = find(padded_x_index == i);
        true_y = find(padded_y_index == j);
        
        k = K(true_x, true_y); 
        
        if horiz_flag
            x_hood = i - k/2  : i + k/2 - 1;
            y_hood = j - 0.5*(N2/k)  : j + 0.5*(N2/k) - 1;
        else
            x_hood = j - 0.5*(N2/k)  : j + 0.5*(N2/k) - 1;
            y_hood = i - k/2  : i + k/2 - 1;
        end
        
        nhood = reshape(zeropad_temp_img(x_hood, y_hood), [1 N2]);
        filtered_pixel_value = median(nhood);

        image(true_x, true_y) = filtered_pixel_value; 
       
    end
end

close all;
imshow(image);
% need to compute a true index.