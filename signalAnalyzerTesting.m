clc, clearvars, close all

x = linspace(0, 100, 10000); 

y1 = sin(x);
y2 = sin(0.5 * x); 

y3 = zeros(1, length(x)); 

for i = 1:1:length(x)
    if x(i) < 50
        y3(i) = sin(x(i));
    else 
        y3(i) = sin(0.5 * x(i)); 
    end
end

figure(2)
plot(x, y3)

disp(size(y3)); 

signalAnalyzer(y2, y3); 

%% FFT
clc, close all

y3_spliced = y3(1:length(y3)/2); 

y_fft = fft(y3);

y_fft_spliced = fft(y3_spliced);

y_fft = y_fft(1:(length(y_fft)/100)); 
  
freq_domain = (0:length(y_fft) - 1) / 100; 

figure(3)
plot(freq_domain, abs(y_fft))

hold on
plot(freq_domain(1:length(y_fft_spliced)-1), abs(y_fft_spliced))
xlabel('freq')

max(abs(y_fft))
max(abs(y_fft_spliced))