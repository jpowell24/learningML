clc, clearvars, close all % used to clear commandline, variables, and close figures

x = linspace(0, 100, 10000); % establishing x variable as 0 to 100 with 10000 data points

y1 = sin(x); % function for y1
y2 = sin(0.5 * x); % function for y2

y3 = zeros(1, length(x)); % establishing length of y3

for i = 1:1:length(x) % writing y3 to be a combination of y1 and y2 
    if x(i) < 50
        y3(i) = sin(x(i));
    else 
        y3(i) = sin(0.5 * x(i)); 
    end
end

figure(1) % space for figure 1
plot(x, y3) % plotting only y3

signalAnalyzer(y2, y3); % opens signalAnalyzer app

%% FFT
clc, close all % clears command line and closes figures

y3_spliced = y3(1:length(y3)/2); % cutting y3 in half

y_fft = fft(y3); % performing fast fourier transform on y3

y_fft_spliced = fft(y3_spliced); % performing fft on half of y3

y_fft = y_fft(1:(length(y_fft)/100)); % scaling output to correct freq (idk y we have to do this)
  
freq_domain = (0:length(y_fft) - 1) / 100; % creating x var

figure(2) % space for fig 2
plot(freq_domain, abs(y_fft)) 

hold on
plot(freq_domain(1:length(y_fft_spliced)-1), abs(y_fft_spliced))
xlabel('freq')

max(abs(y_fft)) % displaying some parameters, like max amplitude on fft plot (idk y i did this)
max(abs(y_fft_spliced))