close all;

% Part 1
num = [1  0];
den = [1 -1 1];
sys = tf(num, den);
figure; nyquist(sys);

% Part 2
num  = [1];
den = conv([1 2], [1 3]);
sys = tf(num, den);
figure; nyquist(sys);

% Part 3
num = [1];
den = [1 1 1];
sys = tf(num, den);
figure; nyquist(sys);


% Part 4
num = [1 0 -1];
den = conv([1 1], [1 0 1]);
sys = tf(num, den);
figure; nyquist(sys);

% Part 5
num = [-1 1];
den = conv([1 1], [1 1]);
sys = tf(num, den);
figure; nyquist(sys);

% Part 6
num = [1 1];
den = conv(conv([1 2], [1 2]), [1 -1]);
sys = tf(num, den);
figure; nyquist(sys);

% Part 7
num = [1];
den = conv(conv(conv([1 1], [1,1]), [1 1]), [1 1]);
sys = tf(num, den);
figure; nyquist(sys);

% Part 8
num = [1];
den = conv([1 2 1], conv([1 2], [1 2])); 
sys = tf(num, den);
figure; nyquist(sys);
