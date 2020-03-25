clear
filename = 'corrupted_voice.wav'
[signal, fs] = audioread(filename);
L = size(signal,1);
transformed_signal = fft(signal);
step_size = 1/44100;
[max,I] = max(transformed_signal);
f1= figure(1);
hold on
x = fs*(0:(L/2))/L;
y = abs(transformed_signal)'/L;
y = y(1:L/2+1);
plot(x,y);
hold off

%make bandpass filter 
[b, a] = butter(6,[0.009, 0.08], 'bandpass');
filtered_signal = filter(b,a,signal);
ftsignal = fft(filtered_signal);
f2= figure(2);
hold on
x = fs*(0:(L/2))/L;
y = abs(ftsignal)'/L;
y = y(1:L/2+1);
plot(x,y);
hold off
soundsc(signal, fs);
pause(2.5);
soundsc(filtered_signal, fs);
audiowrite('a5_filtered_sound.wav', filtered_signal, fs);