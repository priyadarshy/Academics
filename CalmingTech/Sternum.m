%% Looking at Sternum data.

nobreath = csvread('necklace_sternum_holding_breath.csv');
breath1 = csvread('necklace_sternum_breathing.csv');
breath2 = csvread('necklace_sternum_breathing2.csv');

nobreath_x = nobreath(:,2);
nobreath_y = nobreath(:,3);
nobreath_z = nobreath(:,4);

nobreath_X = 20*log10(abs(fft(nobreath_x)));
nobreath_Y = 20*log10(abs(fft(nobreath_y)));
nobreath_Z = 20*log10(abs(fft(nobreath_z)));

breath1_x = breath1(:,2);
breath1_y = breath1(:,3);
breath1_z = breath1(:,4);

breath1_X = 20*log10(abs(fft(breath1_x)));
breath1_Y = 20*log10(abs(fft(breath1_y)));
breath1_Z = 20*log10(abs(fft(breath1_z)));

breath2_x = breath2(:,2);
breath2_y = breath2(:,3);
breath2_z = breath2(:,4);

breath2_X = 20*log10(abs(fft(breath2_x)));
breath2_Y = 20*log10(abs(fft(breath2_y)));
breath2_Z = 20*log10(abs(fft(breath2_z)));