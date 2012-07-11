%[cells, B] = MIMsProjectRevC('cell2.jpg', 1.5, 190);

function [avgArea, avgCirc] = BoundaryExtractionTest(B)
length(B)
area = [];
for k = 1:length(B)
    boundary = B{k};
    area = [area, abs(trapz(boundary(:,1),boundary(:,2)))];
    
    circumference(k) = sum(length(boundary(:,1)));
end

% Return the average values. 
avgArea = mean(area);
avgCirc = mean(circumference);

% Plotting
figure
plot(circumference, area, 'kx');
title('Counted Boundary Area vs Circumference');
xlabel('Circumference')
ylabel('Area')

end
