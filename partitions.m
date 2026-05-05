%% To generate all nonnegative integer vectors of length 'len' and of sum 'total'
function A = partitions(len, total)
if len == 1
    A = total(:)';  
else
    A = [];
    for i = 0:total
        B = partitions(len - 1, total - i);
        A = [A; [i * ones(size(B, 1), 1), B]];
    end
end
end