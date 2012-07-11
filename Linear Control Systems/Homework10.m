%% Homework 10
% Jeff Geiger

%% Problem 21
num = [1];
den = [1 4 8];

sys = tf(num, den)
step(sys)

% Verify Rise Time
[Y, T] = step(sys);
[val index] = max(Y);
t_p = T(index);

% Verify the Damping Ratio
damping_ratio = sin(angle(roots(den)))

%% Problem 30

F = [-0.4 0 -0.01; 1 0 0; -1.4 9.8 0.02];
G = [6.3 0 9.8]; G = G';

poles = eig(F)

C = [G F*G F^2*G]
ksols = [63/10 0 49/5 (4-19/50); -28/125 63/10 -4.9 (6+11/500); 0 -28/125 3087/50 (4 - 49/500)];
K = rref(ksols); K = K(:, 4)'

