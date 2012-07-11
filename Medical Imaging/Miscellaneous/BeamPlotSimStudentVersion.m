% Program to create array beam plot

clear all
close all
j=sqrt(-1);
figure

vel=1540;                                   % Speed of sound - all units MKS
num_elems=64;                               % Number of elements
pitch=0.30e-3;                              % Array element pitch
fc=5e6;                                     % Center frequency
z_foc=50e-3;                                % Range direction focal distance
theta_steer=45*pi/180;                      % Steer angle


fs=fc/64;                                   % Define a sampling frequency (not critical)           
f=[fs:fs:8*fc];                             % Define an adequate frequency range
w=2*pi*f;                                   % Angular frequency radians
ns=length(f);                               % Number of samples

tdel=1.0e-6;                                % Use a fixed time offset so that base wavefor is 0 for t<0 (not critical)

bw=30;                                      % Fractional bandwidth as percent
sig=bw*fc/100;                              % Width of Gausian
gauss_pulse=exp(-pi*((f-fc)/sig).^2);       % Generate Gaussian pulse (frequency domain)

gauss_pulse=gauss_pulse.*exp(-j*w*tdel);    % Apply timed delay so 0 for t<0


gauss_t=real(ifft(gauss_pulse));            % Time domain of base waveform for reference
env_gauss_t=abs(hilbert(gauss_t));          % Envelope calculation
tstep=1./max(f);                            % Time steps after using Inverst FFT
t=[1:ns].*tstep;                            % Define time axis

figure                                      % Plot waveform as a diagnostic
plot(t,gauss_t)
hold on
plot(t,env_gauss_t,'--')
title('Gaussian Pulse')
xlabel('Time (s)')
ylabel('Pressure - Arb Units')

%weight=ones(num_elems,1);                  % Define the weighting function (you can change this)
weight=hann(num_elems);


x_pts=[-50:2.0:50].*1e-3;                   % Define X-direction field locations
z_pts=[0.01:2.0:50.01].*1e-3;               % Define Z-direction field locations

% Create focal delays
for i=1:num_elems
    x_elem(i)=((i-1)-(num_elems-1)./2).*pitch;  % Calculate locations of each array element

    
    %foc_del(i) = ??????

    
    % steer_del(i) = ????
    foc_del(i)=foc_del(i)+steer_del(i);     % You can included steering and focusing in one line - in fact it works better that way
                                            % i.e. dont define range focal
                                            % depth and steer angle
                                            % independently but instead
                                            % define a focal X, Z location
                                         
end

for j=1:length(z_pts)                       % Loop over field locations
    fprintf('%d ',j)
    if (j/20)==round(j/20)
            fprintf('\n')
    end
    

    for i=1:length(x_pts)
        sum_pulse=zeros(size(gauss_pulse)); % Initialize sum of waveforms to zero before starting loop
        for k=1:num_elems

            
            % prop_del = ???? for each elem location, calculate actual
            % propagation time out to current field point
            sum_pulse=sum_pulse+weight(k).*gauss_pulse.*... % Sum pulse taking account of current pulse, propagation delay - focusing delay
                exp(-sqrt(-1)*w.*(prop_del-foc_del(k)));
        end

        sum_pulse_t=real(ifft(sum_pulse));  % Convert to time domain

        field_val(j,i)= max(abs(hilbert(sum_pulse_t))); 
 
    end
    field_val(j,:)=field_val(j,:)./max(field_val(j,:));
    field_db(j,:)=20*log10(field_val(j,:));
end

figure
contour(z_pts*1e3,x_pts*1e3,field_db',[-30 -20 -15 -12 -9 -6 -3])
%mesh(z_pts*1e3,x_pts*1e3,field_db');
colormap('gray')
hold on
xlabel('Range (mm)')
ylabel('Elevaton (mm)')
% 














