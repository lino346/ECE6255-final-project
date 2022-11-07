[x, fs] = audioread('threesentences.wav');

channel = 4;

permissible_rate = 1/3;


[x_scrambled, recover_order] =scramble(x, fs, channel, permissible_rate);

audiowrite('scrambled(channel=4, permissible_rate = 0.33).wav', x_scrambled, fs)


x_descrambled = descramble(x_scrambled, fs, channel, permissible_rate, recover_order);

audiowrite('descrambled(channel=4, permissible_rate = 0.33).wav', x_descrambled, fs)



% Visualization

figure;
subplot(3,1,1)

spectrogram(x,0.02*fs,0.015*fs,0.02*fs,fs,'yaxis')
title('Original')
subplot(3,1,2)

spectrogram(x_scrambled,0.02*fs,0.015*fs,0.02*fs,fs,'yaxis')
title('Scrambled')
subplot(3,1,3)

spectrogram(x_descrambled,0.02*fs,0.015*fs,0.02*fs,fs,'yaxis')
title('Descrambled')




