clear all

I = imread('cell2.jpg');
Ig = rgb2gray(I);
nhood = [32 32];    % change per iteration?!?!1

for j = 1:4
    Igmed = medfilt2(Ig, nhood./2);
    J = adapthisteq(Igmed);
    Ig = J;
end

jbin = J > 190;
imshow(jbin);

figure(1)
imshow(I)
title('original')
figure(2)
imshow(Igmed)
title('last median filtered pic')
figure(3)
imshow(J)
title('last adaptive hist equalized pic')
figure(4)
imshow(jbin);
title('binary threshold applied')

%%
% Speckling
% Tails

[Fxmed Fymed] = gradient(double(I(:, :, 1)));
[Fx Fy] = gradient(double(I(:, :, 1)));