%% Homework 7

%% 8.3
% Define the Transfer Function of the lead compensator. 
numD = [151 -49];
denD = 51*[1.7339 -0.260]; 

% Define the plant transfer function.
numG = [0.368 0.264];
denG = conv([1 -1], [1 -0.368]);

% Create closed loop TF.
numT = [55.56 21.832 -12.936];
denT = [88.689 -52.4986 36.3299 -8.05632];

% Show the Simulation. 
dlsim(numT, denT, ones(1,100))

%% 8.30

num = 0.368*[1 0.717];
den = conv([1 -1], [1 -0.368]);
T = tf(num, den);
rlocus(T);


%% 9.11
syms z;
A = [1 1; 0 1];
B = [.125; .25];
C = [1 0];

G = [0.6322; 0.1548]; 
Dez = K*(z*eye(2) - A + G*C*A + B*K - G*C*B*K)^-1*G

%% 9.12
A = [1 1; 0 1];
B = [.125; .25];
C = [1 0];

K = [.3893 1.769];
G = [0.6322; 0.1548];
K*(z*eye(2) - A + G*C*A + B*K - G*C*B*K)^(-1)*G

