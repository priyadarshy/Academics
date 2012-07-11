clear all;

cellpic = imread('periodicity.jpg');
imshow(cellpic)

img1=rgb2gray(cellpic);
imshow(cellpic)

img2=im2bw(img1,graythresh(cellpic));
imshow(img2)

img2=~img2;
imshow(img2)

tic

B = bwboundaries(img2);
imshow(img2)
text(10,10,strcat('\color{green}Objects Found:',num2str(length(B))))
hold on

for k = 1:length(B)
boundary = B{k};
plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 0.8)
end

toc