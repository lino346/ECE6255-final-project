function [x_new, channel_new, permissible_rate_new, original_audio_len] = check_param(x, fs, channel, permissible_rate)

if size(x,2) == 1
    x = transpose(x);
end

exp = log2(channel);
exp_new = int16(exp);
channel_new = single(2^exp_new);

original_audio_len = length(x);

[I,D]=numden(sym(permissible_rate));
I = eval(I);        
D = eval(D);

if length(x)/fs < D
    D = length(x)/fs;
    
else
    audio_dur = length(x)/fs;
   
    pad_num = (ceil(audio_dur/D)*D)*fs - length(x);
    x_new = padarray(x,[0 pad_num],0,'post');

end
permissible_rate_new = I / D;