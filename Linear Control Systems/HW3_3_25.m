a = 67;
K = 113.079;

num = [100*K];
den = [1 25+a 25*a+100*K];

sys = tf(num, den);
step(sys); grid on;
title('Step Response #3.25')