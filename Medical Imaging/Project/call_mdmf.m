%% Call mdmedfilt2
clear all;


image = imread('edges.jpg');
%image = rgb2gray(image);
image = double(im2bw(image, 0.5));
image = imnoise(image,'salt & pepper', 0.05);

orig = image;
N = 6; 
% Slopes for edges.jpg
[Fx, Fy] = gradient(double(image));
K = (sign(Fy).*sign(Fx).*(2*(abs(Fy) > abs(Fx)))) + sign(Fy).*sign(Fx).*((1/2)*(abs(Fx) > abs(Fy)));

% Slopes for erfyEdge.jpg
%K = 6*ones(size(image)); 
tic
y_correct = mdmedfilt2(orig, N, K);     % Right edge type.
%y_wrong = mdmedfilt2(orig, N, K./36);   % Wrong edge type.
y_standard = medfilt2(orig, [N, N]);    % Standard filter.

% Plotting
figure(1);
subplot(2,2,1); imshow(orig);
title('Original + Noise')
%axis([485 540 500 550])
subplot(2,2,3); imshow(y_correct);
title('Multidirectional Median Filter - Good Slope Choice')
%axis([485 540 500 550])
subplot(2,2,2); imshow(y_standard);
title('Median Filter');
%axis([485 540 500 550])
%subplot(2,2,4); imshow(y_wrong);
%title('Multidirectional Median Filter - Bad Slope Choice')
%axis([485 540 500 550])

% figure(2);
% subplot(2,2,1); stem(orig(385, :)); %hold on; gradient(double(orig(385, :)));
% title('Original Image: Intensity values along a single row');
% axis([500 520 0 255]);
% subplot(2,2,2); stem(y_standard(385, :)); %hold on; stem(gradient(double(y_standard(385, :))), 'r');
% title('Filtered Image w/ Standard Median Filter: Intensity values along a single row');
% axis([500 520 0 255]);
% subplot(2,2,3); stem(y_correct(385, :)); %hold on; stem(gradient(double(y_correct(385, :))), 'r');
% title('Filtered Image w/ Good Choice of Slopes: Intensity values along a single row');
% axis([500 520 0 255]);
% subplot(2,2,4); stem(y_wrong(385, :)); %hold on; stem(gradient(double(y_wrong(385, :))), 'r');
% title('Filtered Image w/ Bad Choice of Slopes: Intensity values along a single row');
% axis([500 520 0 255]);




