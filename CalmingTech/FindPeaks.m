signal = [5 10 12 11 10 15 20 17 18 19 20 22 25 23 20 23 24 25  24 23 20 19 20 23 27 24 23 14 16 14 12 14 18 19 20 22];


ddx = diff(signal);     % Compute and Approximate Derivative.

sign(ddx)

% Find zero crossings.
% Use x-val to populate list of y-vals.
% Sort, find top 3, bottom 3. 