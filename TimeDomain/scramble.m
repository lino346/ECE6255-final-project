%Author: Aoun Hussain

clc; clear all; close all;

%Time Scrambling Method%

[stars, fs] = audioread('threesentences.wav');

[y,fs] = audioread('threesentences.wav');
y = y(:,1);
dt = 1/fs;
t = 0:dt:(length(y)*dt)-dt;
figure
plot(t,y); xlabel('Seconds'); ylabel('Amplitude');
figure
plot(psd(spectrum.periodogram,y,'Fs',fs,'NFFT',length(y)));

Mono = stars(:,1)/2;
frame_duration = 0.1;
frame_len = frame_duration*fs;
N = length(Mono);
num_frames = floor(N/frame_len);
frames = cell(num_frames,1);
for k = 1 : num_frames
      frames{k} = Mono((k-1)*frame_len + 1 : frame_len*k);
end

order = [1];
for k = 2 : num_frames
      order(end+1) = k;
end

o = randperm( num_frames );

fileID = fopen('key.txt','w');
writetable(array2table(o),'key.txt')
fclose(fileID);

scramble = vertcat( frames{o} );

audiowrite('scrambled-threesentences.wav', scramble, fs);

[y,fs] = audioread('scrambled-threesentences.wav');
y = y(:,1);
dt = 1/fs;
t = 0:dt:(length(y)*dt)-dt;
figure
plot(t,y); xlabel('Seconds'); ylabel('Amplitude');
figure
plot(psd(spectrum.periodogram,y,'Fs',fs,'NFFT',length(y)));

