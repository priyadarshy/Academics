function [Hd h B] = Butterworth
%BUTTERWORTH Returns a discrete-time filter object.

%
% MATLAB Code
% Generated by MATLAB(R) 7.12 and the Signal Processing Toolbox 6.15.
%
% Generated on: 06-Oct-2011 12:35:45
%

% Butterworth Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in kHz.
Fs = 8;  % Sampling Frequency

N  = 4;  % Order
Fc = 1;  % Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.lowpass('N,F3dB', N, Fc, Fs);
Hd = design(h, 'butter');

B = dsp.BiquadFilter('SOSMatrix',Hd.sosMatrix,...
'ScaleValues',Hd.ScaleValues);

% [EOF]
