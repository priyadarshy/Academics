%% Homework 5

close all; clear all;

% Problem 6.1.a
figure;
num = [0.6321];
den = [1 0.2642];
T = tf(num, den);
[y k] = step(T, 0:2:40);
stem(y, 'x');
xlabel('Part (a)');

% Problem 6.1.b
figure;
num = [0.5];
den = [1 1];
T = tf(num,den);
step(T);
xlabel('Part (b)');

% Problem 6.1.a
figure;
num = [0.1813];
den = [1 -0.6374];
T = tf(num, den);
[y k] = step(T, 0:2:40);
stem(y, 'x');
xlabel('Part (c-a)');


