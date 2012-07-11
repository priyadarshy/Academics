%% Homework 7 Matlab Support Code

% Problem 5.25

b = [1];
a = conv([1 3 0], [1 6]);
G = tf(b,a)

db = [1 0.1];
da = [1 0.0153];
D = tf(db, da);

rlocus(G*D);

% Problem 5.26

%G = tf([1], [1 1 0]);

%rlocus(G);

% Problem 5.30
b = [-2 4];
a = [1 1 9];
L = tf(-b,a);
rlocus(L);
K = 1.05;
step(K*L)