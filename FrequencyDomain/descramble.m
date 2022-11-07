function channel_matrix_descrambled = descramble(x, fs, channel, permissible_rate, recover_order)

[x, channel, permissible_rate, original_audio_len] = check_param(x, fs, channel, permissible_rate);

if size(x,2) == 1
    x = transpose(x);
end

if permissible_rate == 0
    channel_matrix_descrambled = freq_reassemble(x, fs, channel, recover_order);

end


if permissible_rate == 0
    channel_matrix_descrambled = freq_reassemble(x, fs, channel, recover_order);

else
    [num_changes,changes_seconds]=numden(sym(permissible_rate));
    num_changes = eval(num_changes);        
    changes_seconds = eval(changes_seconds);

    audio_dur = length(x) / fs;
    permissible_times = changes_seconds*num_changes;
    step = audio_dur / (changes_seconds*num_changes);
    
    channel_matrix_descrambled = [];

    for i = 1:permissible_times
        
        channel_matrix_tmp= freq_reassemble(x((i-1)*step*fs+1:i*step*fs), fs, channel, recover_order(i,:));
        channel_matrix_descrambled = [channel_matrix_descrambled, channel_matrix_tmp];
 
        
    end
end

channel_matrix_descrambled = channel_matrix_descrambled(1:original_audio_len);
    