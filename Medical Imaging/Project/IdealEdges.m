% Ideal Edge Blurring
clear all;
signal = imread('edges.jpg'); 
signal = rgb2gray(signal);

noise =  uint8(round(54*rand(size(signal))));
sample = signal - noise;

%%
figure(1)
imshow(sample);
figure(2);
subplot(2,1,1); imshow(medfilt2(sample, [1 35])); 
subplot(2,1,2); imshow(medfilt2(sample, [35,1]));

%%
[Fx Fy] = gradient(double(signal));

nhood_dirn = Fx./Fy;
horiz_mask = uint8(nhood_dirn < 1);
vert_mask = uint8(nhood_dirn > 1);

h_filt = medfilt2(sample, [1 18]);
v_filt = medfilt2(sample, [18 1]);

out = h_filt.*horiz_mask + v_filt.*vert_mask;