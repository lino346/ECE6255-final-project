function [channel_matrix_new, recover_order] = permutation(channel_matrix, channel_num)

recover_order = 1:1:channel_num;
channel_matrix_new = [1];
while isequal(recover_order, 1:1:channel_num) 
    permutation_order = randperm(channel_num);
    channel_matrix_new = channel_matrix(permutation_order,:);
    [dummy, recover_order] = sort(permutation_order);
end




