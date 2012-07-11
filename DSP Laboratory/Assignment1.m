%% Assignment 1

theta0 = (1000/4000)*pi;

sys = conv([1 -exp(j*theta0)], [1 -exp(-j*theta0)]);
h = sys/4

fvtool(h)