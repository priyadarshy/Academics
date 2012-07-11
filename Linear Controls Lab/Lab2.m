%% Lab 2 - Data Visualization

load data_parts_1_2.mat

figure(1)
plot(DVM, RPM_Motor, 'x');
title('Part 1 - Steady State Speed vs. Applied Voltage');
xlabel('Voltage');
ylabel('RPM Motor');
grid on;
axis square; 

figure(2)
plot(RPM_Motor, DVM);
title('Part 2 - Voltage vs. Motor Speed');
xlabel('Motor Speed');
ylabel('Output Voltage');
grid on;
axis square; 

clear all;
load data_part_3.mat;

figure(3)
plot(current_armature, RPM_motor);
title('Part 3 - Motor Speed vs. Armature Current');
xlabel('Armature Current (Amps)');
ylabel('Motor Speed (RPM)');
grid on;
axis square; 
