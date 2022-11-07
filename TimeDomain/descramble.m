%Author: Aoun Hussain

clc; clear all; close all;

%Time Descrambling Method%


[starss, fss] = audioread('scrambled-threesentences.wav');
mono = starss(:,1)/2;
frame_durationn = 0.1;
frame_lenn = frame_durationn*fss;
NN = length(mono);
num_framess = floor(NN/frame_lenn);
framess = cell(num_framess,1);
for q = 1 : num_framess
      framess{q} = mono((q-1)*frame_lenn + 1 : frame_lenn*q);
end

ll = zeros(1, num_framess);

m = readmatrix('key.txt');

for a = 1 : num_framess
      ll(a) = find(m==a);
end

descramble = vertcat( framess{ll} );

audiowrite('descrambled-threesentences.wav', descramble, fss);

[y,fs] = audioread('descrambled-threesentences.wav');
y = y(:,1);
dt = 1/fs;
t = 0:dt:(length(y)*dt)-dt;
figure
plot(t,y); xlabel('Seconds'); ylabel('Amplitude');
figure
plot(psd(spectrum.periodogram,y,'Fs',fs,'NFFT',length(y)));
