%% Homework 1 N = 16    
%   Ashutosh Priyadarshy - ap9ac
%   
%   BME 4783 - Medical Imaging Modalities
%
%   09-Feb-2011

% Define a time-span to simulate the signals.
t = 0:0.001:1;

% Number of times to average the signal.
N = 16; %   Change when needed.

% Define the pure signal with no noise.
signal = sin(2*pi.*t);

% Generate noise signals.
noise = randn(N,length(t));

% Initialize the noisy_signal.
noisy_signal = 0;
% Add 16 noisy signals together. 
for index = 1:N
   noisy_signal = noisy_signal + (signal + noise(index,:)); 
end

% Final averaged signal computed here.
avg_signal = noisy_signal/N;

% Compute the RMS value of the noise.
rms_noise = sqrt(mean(noise(:).^2))
% Compute the RMS value of the unit-amplitude sinusoid.
rms_signal = sqrt(1/2);
% Compute the initial SNR. 
originalSNR = rms_signal./rms_noise

% Find only the noise after averaging the signal.
postAvgNoise = avg_signal - signal;
% Averaged Signal's Signal to Noise Ratio.
avg_signal_SNR = rms_signal./sqrt(mean(postAvgNoise.^2))

% Calculate the total improvement in SNR. 
improvement = avg_signal_SNR./originalSNR

% Plot the result of the averaged Signal. 
plot(t, avg_signal); hold on;
plot(t, signal, 'r');
legend('Averaged Signal', 'Pure Signal');
xlabel('time');
ylabel('Amplitude');
title('Noisy Sinusoid Averaged 16 Times');
