close all
clear all 
clc

f   = 700;                                                  % Frequency (Hz)
fs  = 44100;                                                % Sampling Frequency (Hz)
t = 0:1/fs:0.5-1/fs;                                        % Time (s)
deltaf = 2;                                                 % Hz

N = fs/deltaf;                                              % Samples

%% all bands across all the freq. 

randNoise = complex(randn(1,N/2),randn(1,N/2));             % Generating random complex numbers

% 5 bands in positive freq:

noise_bands_pos = zeros(1,N/2);                         
center_freq = [460, 580, 700, 820, 940];                    %deriving the center frequencies

for k = 1:length(center_freq)                       
    
    noise_bands_pos(center_freq(k)/2+1-5:center_freq(k)/2+6)...
        = randNoise(center_freq(k)/2+1-5:center_freq(k)/2+6);  % assign the random complex number 10 Hz before and 10 Hz after the center frequency     
end

%% Random noise

SPL = 70;                                                      %deriving sound pressure level
noise_bands_neg = fliplr(conj(noise_bands_pos(1:end-1)));      %symetric negative part of above derived bands

positive_frequency_axis = [deltaf:deltaf:fs/2];
negative_frequency_axis = -fliplr(positive_frequency_axis(1:end-1));
f_axis = [0, positive_frequency_axis, negative_frequency_axis];  %frequency axis
y_axis_bands = [0, noise_bands_pos, noise_bands_neg];            %y axis in 0, positive, negative order

plot(f_axis, abs(y_axis_bands))

noise_t = 10^(SPL/20)*ifft(y_axis_bands, N);                                    %ifft for noise in time domain 

plot(t,noise_t)
sound(noise_t, fs)


