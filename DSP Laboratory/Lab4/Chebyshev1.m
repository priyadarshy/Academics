function [B Hd h ] = Chebyshev1
%CHEBYSHEV1 Returns a discrete-time filter object.

%
% MATLAB Code
% Generated by MATLAB(R) 7.12 and the Signal Processing Toolbox 6.15.
%
% Generated on: 06-Oct-2011 12:37:28
%

% Chebyshev Type I Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in kHz.
Fs = 8;  % Sampling Frequency

N     = 4;  % Order
Fpass = 1;  % Passband Frequency
Apass = 1;  % Passband Ripple (dB)

% Construct an FDESIGN object and call its CHEBY1 method.
h  = fdesign.lowpass('N,Fp,Ap', N, Fpass, Apass, Fs);
Hd = design(h, 'cheby1');

B = dsp.BiquadFilter('SOSMatrix',Hd.sosMatrix,...
'ScaleValues',Hd.ScaleValues);

% [EOF]