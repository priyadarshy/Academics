% Program to create array beam plot
function [z_pts,field_db] = UltrasoundHomework_Task5(fc)
% fc is the center frequency

j=sqrt(-1);

vel=1540;                                   % Speed of sound - all units MKS
num_elems=128;                               % Number of elements
pitch = vel/(fc);                              % Array element pitch
z_foc = 50e-3;                                % Range direction focal distance
theta_steer = 0*pi/180;                      % Steer angle


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

weight=ones(num_elems,1);                  % Define the weighting function (you can change this)

xres = 0.050;
zres = 0.050;
% Increase resolution for calculation in the x field.
x_pts=[-50:xres:50].*1e-3;                   % Define X-direction field locations
z_pts=[0.01:zres:50.01].*1e-3;               % Define Z-direction field locations

% Dereference the index corresponding to the middle index.
xmid = ceil(length(x_pts)/2);
zmid = ceil(length(z_pts)/2);

% Create focal delays
for i=1:num_elems
    x_elem(i)=((i-1)-(num_elems-1)./2).*pitch;  % Calculate locations of each array element
    
    foc_del(i)=(sqrt(x_elem(i).^2+z_foc^2)-z_foc)./vel; % Calculate focusing delays
    
    steer_del(i) = i*pitch*sin(theta_steer)/vel;
    
    foc_del(i)=foc_del(i)+steer_del(i);     % You can included steering and focusing in one line - in fact it works better that way
                                       
end

for j=1:length(z_pts)                       % Loop over field locations

    for i = xmid:xmid

        sum_pulse=zeros(size(gauss_pulse)); % Initialize sum of waveforms to zero before starting loop
        for k=1:num_elems

            prop_del=(sqrt((x_elem(k)-x_pts(i)).^2+z_pts(j)^2))./vel;   
            % prop_del = ???? for each elem location, calculate actual
            % propagation time out to current field point
            sum_pulse=sum_pulse+weight(k).*gauss_pulse.*exp(-sqrt(-1)*w.*(prop_del-foc_del(k)));
        end

        sum_pulse_t=real(ifft(sum_pulse));  % Convert to time domain

        field_val(j,i)= max(abs(hilbert(sum_pulse_t))); 
 
     end
%     field_val(j,:)=field_val(j,:)./max(field_val(j,:));
%     field_db(j,:)=20*log10(field_val(j,:));
    field_db = 20*log10(field_val(:,1001)/max(field_val(:,1001)))';
end

% Find -6 dB Points
mask = field_db > (-20);
mask = mask*1;
if(fc == 5e6)
    disp('The -20 dB width for f_c = 5 MHz is: ')
end
if(fc == 10e6)
    disp('The -20 dB width for f_c = 10 MHz is: ')
end

twenty_dB_width = zres*(max(find(mask)) - min(find(mask)))*1e-3;
twenty_dB_duration = twenty_dB_width/vel;
axial_res = twenty_dB_duration * vel * 2

end









