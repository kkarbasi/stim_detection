%% ndiff.m
% returns difference of every nth element in the trace
function ndiff = ndiff (trace , n)

pad_arr = zeros(1,n);

trace0 = [pad_arr trace];
trace1 = [trace pad_arr];

ndiff = trace1 - trace0;

ndiff = ndiff(n+1:end-n);