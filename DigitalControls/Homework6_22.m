
% Problem 6.22

num = [-.622 1.037];
den = [0.6 -.288];

sys = tf(num, den);

figure; margin(sys)
figure; nyquist(sys)