function [channel_matrix_scrambled, recover_order] = freq_separate(x,fs,channel)


freqency_threshold = 2000;
% x = transpose(x);
stages = log2(channel);
order = get_seperate_order(channel);
channel_matrix = repmat(x,channel,1);


for i = 1:stages
    for j = 1:size(channel_matrix,1)
        if order(j,i) == 1
            channel_matrix(j,:) = highpass(channel_matrix(j,:), freqency_threshold/(2^(i-1)), fs/(2^(i-1)));
        else
            channel_matrix(j,:) = lowpass(channel_matrix(j,:), freqency_threshold/(2^(i-1)), fs/(2^(i-1)));
        end
    end

    channel_matrix = downsample(channel_matrix.', 2);
    channel_matrix = channel_matrix.';

end

[channel_matrix_scrambled, recover_order] = permutation(channel_matrix, channel); 




for i = stages:-1:1
    channel_matrix_scrambled = upsample(channel_matrix_scrambled.', 2);
    channel_matrix_scrambled = channel_matrix_scrambled.';

    for j = 1:size(channel_matrix_scrambled,1)
        if order(j,i) == 1
            channel_matrix_scrambled(j,:) = highpass(channel_matrix_scrambled(j,:), freqency_threshold/(2^(i-1)), fs/(2^(i-1)));
        else
            channel_matrix_scrambled(j,:) = lowpass(channel_matrix_scrambled(j,:), freqency_threshold/(2^(i-1)), fs/(2^(i-1)));
        end
    end
    
    num_half_channel = size(channel_matrix_scrambled,1)/2;
    channel_matrix_tmp1 = sum(channel_matrix_scrambled(1:num_half_channel,:), 1);
    channel_matrix_tmp2 = sum(channel_matrix_scrambled(num_half_channel+1:num_half_channel*2,:),1);
    channel_matrix_scrambled = [channel_matrix_tmp1; channel_matrix_tmp2];
    

    if i == 1
        channel_matrix_scrambled = sum(channel_matrix_scrambled, 1);
    else
        order = get_seperate_order(2^(stages-1));
    end
end