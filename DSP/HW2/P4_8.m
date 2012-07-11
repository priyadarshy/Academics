ki = 1:6;
n = 0:5;

for k = 1:6
    s = exp(j*(2/6)*pi*k.*n);
    figure
    stem(n, abs(s))
    title(['k = ', num2str(k)])
    ylabel('|s_k(n)|')
    xlabel('n')
    
    disp([' For k = ', num2str(k)])
    disp(s)
    
end

