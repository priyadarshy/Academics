RGB = imread('cell2.jpg');

% Convert to intensity.
I  = rgb2gray(RGB);

% Extract edges.
BW = edge(I,'canny');
[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89.5);
figure(1);imshow(BW);


% Display the original image.
figure(2);
% subplot(2,1,1);
% imshow(RGB);
% title('BEC Image');

% Display the Hough matrix.
% subplot(2,1,2);
imshow(imadjust(mat2gray(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough Transform of Cell Image');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(jet); colorbar;