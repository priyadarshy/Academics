%% Finding Axial Resolution - Task 5

% fc = 5 MHz
% call the function to spit out the axial resolution:
[z_pts, field_db] = UltrasoundHomework_Task5(5e6);
figure(1)
hold on
plot(z_pts,field_db,'k');
xlabel('z');
ylabel('Field Strength dB');
title('Unity-Wavelength Spacing - Field at z = 50 mm');

% fc = 10 MHz
% call the function to spit out the axial resolution:
[z_pts, field_db] = UltrasoundHomework_Task5(10e6);
plot(z_pts,field_db,'b');
legend('f_c = 5 MHz','f_c = 10 MHz')