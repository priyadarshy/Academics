%% Truncation

n = 0:199;
f0 = 1/50;
x = sin(2*pi*f0*n);
 
L = [64 128 256];
M = log2(L);
 
for i = 1:length(L)
    q = quantizer([M(i) M(i)-1], 'fixed');
    xq = quantize(q, x);
    e = xq - x; 
    
    Pq = (1/200)*sum(e.^2);
    Px = (1/200)*sum(x.^2);
    SQNR = 10*log10(Px./Pq);
    
    figure(i)
    
    subplot(3,1,1);
    stem(n, x);
    xlabel('n');
    title('x(n)');
    
    subplot(3,1,2);
    stem(n, xq);
    xlabel('n');
    title('x_q(n)');
    
    subplot(3,1,3);
    stem(n, e);
    xlabel('n');
    title(['e(n) with SQNR = ',  num2str(SQNR)]);
end

%% Rounding

clear all;

n = 0:199;
f0 = 1/50;
x = sin(2*pi*f0*n);
 
L = [64 128 256];
M = log2(L);
 
for i = 1:length(L)
    q = quantizer([M(i) M(i)-1], 'fixed', 'nearest');
    xq = quantize(q, x);
    e = xq - x; 
    
    Pq = (1/200)*sum(e.^2);
    Px = (1/200)*sum(x.^2);
    SQNR = 10*log10(Px./Pq);
    
    figure(i+3)
    
    subplot(3,1,1);
    stem(n, x);
    xlabel('n');
    title('x(n)');
    
    subplot(3,1,2);
    stem(n, xq);
    xlabel('n');
    title('x_q(n)');
    
    subplot(3,1,3);
    stem(n, e);
    xlabel('n');
    title(['e(n) with SQNR = ',  num2str(SQNR)]);
end