% HW 3.35

num = [1/2 1];
den = conv([1/40 1],[1/16 1/4 1]);

sys = tf(num, den);
step(sys);