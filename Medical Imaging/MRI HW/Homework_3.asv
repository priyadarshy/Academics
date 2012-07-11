% Define constants. 
B = 1.5;
gamma = 2*pi*42.58e6;
T1 = 750e-3;
T2 = 70e-3;
M0 = 1;

% Define the equations.
M = exp(-t./T2).*exp(1j*gamma*B.*t);

Mx = @(t) exp(-t./T2).*cos(gamma*B.*t);
My = @(t) exp(-t./T2).*sin(gamma*B.*t);
Mz = @(t) (1-exp(-t./T1));

% Get values at specific points:
% Mxvalues = [Mx(150001) Mx(170001) Mx(200001) Mx(3000001)]
% Myvalues = [My(150001) My(170001) My(200001) My(3000001)]
% Mzvalues = [Mz(150001) Mz(170001) Mz(200001) Mz(3000001)]

%% Plotting
% Time span for plotting.
t = 0:0.000001:.200;
% Define the equations.
Mx = exp(-t./T2).*cos(gamma*B.*t);
My = -exp(-t./T2).*sin(gamma*B.*t);
Mz = (1-exp(-t./T1));
% Plot Mx and My
figure(1); hold on;
subplot(2,1,1); plot(t, Mx, 'r')
title('M_x(t)')
xlabel('t')
ylabel('Magnetic Field Magnitude')
subplot(2,1,2); plot(t, My, 'g')
title('M_y(t)')
xlabel('t')
ylabel('Magnetic Field Magnitude')

A = [Mx(150000) My(150000) Mz(150000)];


