function seperate_order = get_seperate_order(channel)

stages = log2(channel);
seperate_order = zeros(channel, stages);

for i =1:stages
    step = channel / 2^i;
    for j = 1:channel/(step*2)
        a = 2*(j-1)*(step)+1;
        b = a + step-1;
        seperate_order(a:b, i) = 1;        
    end
    
end

