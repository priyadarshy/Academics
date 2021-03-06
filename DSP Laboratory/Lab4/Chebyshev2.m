function [B Hd h] = Chebyshev2
%CHEBYSHEV2 Returns a discrete-time filter object.

%
% MATLAB Code
% Generated by MATLAB(R) 7.12 and the Signal Processing Toolbox 6.15.
%
% Generated on: 06-Oct-2011 12:39:10
%

% Chebyshev Type II Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in Hz.
Fs = 48000;  % Sampling Frequency

N     = 4;      % Order
Fstop = 12000;  % Stopband Frequency
Astop = 80;     % Stopband Attenuation (dB)

% Construct an FDESIGN object and call its CHEBY2 method.
h  = fdesign.lowpass('N,Fst,Ast', N, Fstop, Astop, Fs);
Hd = design(h, 'cheby2');

B = dsp.BiquadFilter('SOSMatrix',Hd.sosMatrix,...
'ScaleValues',Hd.ScaleValues);

% [EOF]
