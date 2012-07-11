%% Ashutosh Priyadarshy
%  ECE 4850 - Semester Project
%  Linear Control Systems
%  November 2011
%  

%% System Definitions
K = 1;
Ges = tf([K], [1 10]);
Gp = tf([1 3], [1 4 5]);
Gint = tf([1], [1 0]);
Unity = tf([1],[1]);
syms s;

%% Part (b)
num = [1 3];
den = conv([1 4 5 0], [1 10]);
L = tf(num,den);
figure(1)
rlocus(L)

%% Part (d): K = 600
K = 600;
a_s = [1 14 45 50+K 3*K];
roots(a_s)

%% Part (f): K = 600, M_p = 0, K_T connected in negative feedback.
K = 600;
G_tilda = tf([600 1800 0], a_s);
figure(2)
rlocus(G_tilda)

%% Part (i:<1>): K = 600, K_T = 0.334
K_T = 0.334;
den = sym2poly((s*(s+10)*(s^2+4*s+5)) + (K*(s+3)*(1+K_T*s)) );
num = [600 1800];
G_i1 = tf(num,den);
figure(3);
step(G_i1);
grid on;

%% Part (i:<2>): K = 600, K_T = 0.334, M_p = 0.6, theta_r = 0
den = sym2poly( (s*(s^2+4*s+5)*(s+10)) + (K_T*s*K*(s+3)) + (K*(s+3)) );
num = conv([1 3], [1 10]);
G_i2 = tf(num, den);
figure(4);
step(0.6*G_i2);
grid on;

%% Part (i:3:IV): K = 600, K_T = 0.334, M_p = 0.6, theta_r
den = sym2poly( (s*(s^2+4*s+5)*(s+10)*(s+0.01)) + (K_T*s*K*(s+3)*(s+0.05) + (K*(s+3)*(s+0.05))) );
num = conv(conv([1 3], [1 10]), [1 0.01]);
G_i3 = tf(num, den);
figure(5);
step(0.6*G_i3);
grid on;