% Program to create array beam plot

clear all
close all
j=sqrt(-1);

vel=1540;                                   % Speed of sound - all units MKS
num_elems=64;                               % Number of elements
pitch=0.30e-3;                              % Array element pitch
fc=10e6;                                    % Center frequency
z_foc=50e-3;                                % Range direction focal distance
theta_steer=45*pi/180;                      % Steer angle


fs=fc/64;                                   % Define a sampling frequency (not critical)           
f=[fs:fs:8*fc];                             % Define an adequate frequency range
w=2*pi*f;                                   % Angular frequency radians
ns=length(f);                               % Number of samples

tdel=1.0e-6;                                % Use a fixed time offset so that base wavefor is 0 for t<0 (not critical)

bw=30;                                      % Fractional bandwidth as percent
sig=bw*fc/100;                               % Width of Gausian
gauss_pulse=exp(-pi*((f-fc)/sig).^2);       % Generate Gaussian pulse (frequency domain)

k_gauss_pulse_db = 20*log10(abs(gauss_pulse)/max(abs(gauss_pulse)));
k_gauss_pulse_db = (-8.4./(f)).*k_gauss_pulse_db;       

gauss_pulse=gauss_pulse.*exp(-j*w*tdel);    % Apply timed delay so 0 for t<0
k_gauss_pulse_db = k_gauss_pulse_db.*exp(-j*w*tdel);




k_gauss_t=real(ifft(k_gauss_pulse_db));
k_env_gauss_t=abs(hilbert(k_gauss_t)); 

tstep=1./max(f);                            % Time steps after using Inverst FFT
t=[1:ns].*tstep;                            % Define time axis




figure
hold on
plot(f, abs(k_gauss_pulse_db))
title('Gaussian Pulse Spectrum')
xlabel(' \omega radians/sec')
ylabel(' Amplitude ')














