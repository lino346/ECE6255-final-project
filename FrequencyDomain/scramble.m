function [channel_matrix_scrambled, recover_order] = scramble(x, fs, channel, permissible_rate)

[x, channel, permissible_rate, original_audio_len] = check_param(x, fs, channel, permissible_rate);

if permissible_rate == 0
    [channel_matrix_scrambled, recover_order] = freq_separate(x, fs, channel);

else
    [num_changes,changes_seconds]=numden(sym(permissible_rate));
    num_changes = eval(num_changes);        
    changes_seconds = eval(changes_seconds);
    audio_dur = length(x) / fs;
    permissible_times = changes_seconds*num_changes;
    step = audio_dur / (changes_seconds*num_changes);
    recover_order = zeros(permissible_times, channel);
    channel_matrix_scrambled = [];
    

    for i = 1:permissible_times

        [channel_matrix_tmp, recover_order_tmp] = freq_separate(x((i-1)*step*fs+1:i*step*fs), fs, channel);
        channel_matrix_scrambled = [channel_matrix_scrambled, channel_matrix_tmp];
        recover_order(i,:) = recover_order_tmp; 
        
    end
end

channel_matrix_scrambled = channel_matrix_scrambled(1:original_audio_len);