t = 0:0.01:10;
u = t;

K = 10;
G = 5;
P1 = 1;
P2 = 1;
tau = 2.5;

num = [-P1 * G * K];
den = [tau (P2*G*K+1) -P1*G*K];

sys = tf(num, den);

lsim(sys,u, t);