%% FIR 1 filter

filt = fir1(15, 0.125);
%fvtool(filt);

%% Hamming Window
h = hamming(8)/4;
fvtool(h);