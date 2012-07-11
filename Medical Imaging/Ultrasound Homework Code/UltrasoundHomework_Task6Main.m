% No steer - full wavelength.
vel=1540;                                  % Speed of sound - all units MKS
num_elems=128;                             % Number of elements
fc=10e6;                                   % Center frequency
pitch= vel/(fc);                         % Array element pitch
z_foc=50e-3;                               % Range direction focal distance
theta_steer=0*pi/180;                      % Steer angle

[z_pts_full0, x_pts_full0, field_db_full0] = UltrasoundHomework_Task6(theta_steer, vel/fc);

figure(1); hold on;
mesh(z_pts*1e3,x_pts*1e3,field_db');
colormap('autumn')

% 45 degree steer - full wavelength.
theta_steer = 45*pi/180;
[z_pts_full_45, x_pts_full_45, field_db_full_45] = UltrasoundHomework_Task6(theta_steer, vel/fc);
mesh(z_pts*1e3,x_pts*1e3,field_db');
colormap('winter')

xlabel('Range (mm)')
ylabel('Elevation (mm)')
title('Full Wavelength Spacing at 45 degrees and 0 degrees');
legend('No Steering','45 Degree Steering');

%%

% No steer - half wavelength.
vel=1540;                                  % Speed of sound - all units MKS
num_elems=128;                             % Number of elements
fc=10e6;                                   % Center frequency
pitch= vel/(2*fc);                         % Array element pitch
z_foc=50e-3;                               % Range direction focal distance
theta_steer=0*pi/180;                      % Steer angle

[z_pts_half0, x_pts_half0, field_db_half0] = UltrasoundHomework_Task6(theta_steer, vel/fc);

figure(2); hold on;
mesh(z_pts*1e3,x_pts*1e3,field_db');
colormap('autumn')

% 45 degree steer - half wavelength.
theta_steer = 45*pi/180;
[z_pts_half_45, x_pts_half_45, field_db_half_45] = UltrasoundHomework_Task6(theta_steer, vel/fc);
mesh(z_pts*1e3,x_pts*1e3,field_db');
colormap('winter')

xlabel('Range (mm)')
ylabel('Elevation (mm)')
title('Half Wavelength Spacing at 45 degrees and 0 degrees');
legend('No Steering','45 Degree Steering');

%% Answers
% When you steer the beam, you have less effective elements due to the
% angle and this in effect reduces the aperture. Reduced aperture leads to
% smaller focal length, this is reflected in the mesh plots. 