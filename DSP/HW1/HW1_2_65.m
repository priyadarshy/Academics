%% Homework 1 - Problem 2.65
function [] = HW1_2_65( sigma_sq, x, fig_init, x_name)

    %% Part B
    n = 0:199;
    %x = [1 1 1 1 1 -1 -1 1 1 -1 1 -1 1];
    % x is passed in.
    seq = x;
    x = repmat(x, 1, 20); % something bigger than 13, less than 26...

    % Define the parameters of Gaussian RV.
    %sigma = sqrt(0.01);
    sigma = sqrt(sigma_sq);
    u = 0;
    v = normrnd(0, sigma, 1, 200);

    % Define the DT signal parameters.
    D = 20;
    a = 0.9;

    % Time shift x to simulate D.
    %x = circshift(x, -D);
    %x = x(1:200);
    x = [zeros(1,D) x];
    x = x(1:200);
    y = a.*x + v;

    figure(fig_init)
    subplot(2,1,1)
    stem(n, x);
    xlabel('n'); title(x_name)

    subplot(2,1,2)
    stem(n, y);
    xlabel('n'); title('Digitized Received Signal: y(n)')


    %% Part C
    x = repmat(seq, 1,20); x = x(1:200);
    Rxy = xcorr(x,y);
    Rxx = xcorr(x,x);
    figure(fig_init+1)
    stem(Rxy);
    hold on;
    stem(Rxx, 'r');
    xlabel('l'); title('R_x_y and R_x_x')
    legend('R_x_y', 'R_x_x');
    axis([1 60 min(Rxy) max(Rxy)])

end