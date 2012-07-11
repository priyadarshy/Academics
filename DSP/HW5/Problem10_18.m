%%  Problem 10.18
% We will choose a Fs = 1 because the T in the bilinear transform will
% cancel out once we apply it. We've shown on paper why the order is 9 from
% the given design equations! Then we can do the rest in Matlab.

[z, p, k] = CHEBY1(9, 1/2, .24);
[z, p, k] = bilinear(z, p, k, 1);

B = poly(z)*k
A = poly(p)