% Possible files: {data-abdomen, data-sternum, data-taped-lowerright-lung, data-tarzanbelt-lowerlung}
file = 'necklace_sternum_holding_breath.csv';    % Current File to Analyze.
raw = csvread(file);

% Read in the raw data from the CSV File.
data_abdomen = csvread('data-abdomen.csv');
data_sternum = csvread('data-sternum.csv');
data_taped_lowerright_lung = csvread('data-taped-lowerright-lung.csv');
data_tarzanbelt_lowerlung = csvread('data-tarzanbelt-lowerlung.csv');

% Explicitly dereference each accelerometer axis and time.
t_ms = raw(:,1);
y = raw(:,3);
z = raw(:,4);
x = raw(:,2);

% Remove the DC Component.
yac = y - mean(y);
zac = z - mean(z);
xac = x - mean(x);

% Plot the spectrums.
subplot(2,1,1);
stem(20*log10(abs(fftshift(fft([xac yac zac])))));
title('Filtered Signal');
legend('X', 'Y', 'Z');
axis tight;
title(file);
%axis([0 length(x) 0 60])
% Filtered spectrum.
subplot(2,1,2);
plot(20*log10(abs(fftshift(fft([x y z])))));
title('Unfiltered Signal');
legend('X', 'Y', 'Z');
axis tight;

% Decimate the signal -> Increase frequency resolution.
L = 60;
xd = decimate(x, L); yd = decimate(y, L); zd = decimate(z, L);

% Visually Inspect Graphs and Record Bin #s for now.
fs = 30;           % Hz

% data-abdomen.csv
data_abdomen_peaks = [63 70];
data_abdomen_length = length(data_abdomen);
data_abdomen_bpm = data_abdomen_peaks./data_abdomen_length * fs * 60

% data-sternum.csv
data_sternum_peaks = [NaN];
data_sternum_length = length(data_sternum);
data_sternum_bpm = data_sternum_peaks ./ data_abdomen_length * fs * 60

% data-taped-lowerright-lung.csv
data_taped_lowerright_lung_peaks = [26 51];
data_taped_lowerright_lung_length = length(data_taped_lowerright_lung);
data_taped_lowerright_lung_bpm = data_taped_lowerright_lung_peaks./data_abdomen_length * fs *60

% data-tarzanbelt-lowerlung.csv
data_tarzanbelt_lowerlung_peaks = [140 148];
data_tarzanbelt_lowerlung_length = length(data_tarzanbelt_lowerlung);
data_tarzanbelt_lowerlung_bpm = data_tarzanbelt_lowerlung_peaks ./ data_tarzanbelt_lowerlung_length * fs * 60