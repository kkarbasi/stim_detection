function stim_reduced_trace = stim_reduction(trace , iteration_number)

original_mean_trace = mean_trace;

t = 1:numel(mean_trace);



subplot(7,1,1);
plot(t , mean_trace , 'b' );
%plot(f , t ,mean_trace) 

% subplot(4,1,3)
% plot(t , flat_smooth_trace)


mean_trace_diff = ndiff(mean_trace , 3);
mean_trace_diff = abs(mean_trace_diff);

max_intensity  = max(mean_trace);
diff_thresh = (max_intensity - mean(mean_trace))/3;

subplot(7 , 1 , 2)
plot(t , [mean_trace_diff , 0 ,0 ,0] , 'b' ,  t , diff_thresh , 'r')


mean_trace_diff(mean_trace_diff < diff_thresh) = 0 ;

stim_idx =  find(mean_trace_diff);
diff_si = diff(stim_idx);
idx = diff_si>10;
idx = circshift(idx' ,1)';
idx(1) = 1;

stim_idx = stim_idx(idx);
if mod(numel(stim_idx),2)
    error(['detected stimulation indices are not even. ', str(numel(stim_idx)) , ' indices detected']);
end

for i = 1:2:numel(stim_idx)
 
    median_pre = median( mean_trace( stim_idx(i) - 40 : stim_idx(i) - 10 ) );
    median_invl = median( mean_trace(stim_idx(i) : stim_idx(i+1)));
    reduction_val = median_invl - median_pre;

    mean_trace(stim_idx(i) : stim_idx(i+1)) = mean_trace(stim_idx(i) : stim_idx(i+1)) - reduction_val;
    mean_trace(stim_idx(i)-5 : stim_idx(i)+5) = median_pre;
    mean_trace(stim_idx(i+1)-5 : stim_idx(i+1)+5) = median_pre;
end


f = fit (t' , mean_trace' , 'power2');


subplot(7,1,3)
plot(f , t ,mean_trace) 

flattened = curveFlattener(original_mean_trace , f);

subplot(7,1,4)
plot(t, flattened)
mean_trace = flattened';

%***********************Second Iteration*****************************************

mean_trace_diff = ndiff(mean_trace , 3);
mean_trace_diff = abs(mean_trace_diff);

max_intensity  = max(mean_trace);
diff_thresh = (max_intensity - mean(mean_trace))/3;

subplot(7 , 1 , 5)
plot(t , [mean_trace_diff , 0 ,0 ,0] , 'b' ,  t , diff_thresh , 'r')


mean_trace_diff(mean_trace_diff < diff_thresh) = 0 ;

stim_idx =  find(mean_trace_diff);
diff_si = diff(stim_idx);
idx = diff_si>10;
idx = circshift(idx' ,1)';
idx(1) = 1;

stim_idx = stim_idx(idx);
if mod(numel(stim_idx),2)
    error(['detected stimulation indices are not even. ', str(numel(stim_idx)) , ' indices detected']);
end

for i = 1:2:numel(stim_idx)
 
    median_pre = median( mean_trace( stim_idx(i) - 40 : stim_idx(i) - 10 ) );
    median_invl = median( mean_trace(stim_idx(i) : stim_idx(i+1)));
    reduction_val = median_invl - median_pre;

    mean_trace(stim_idx(i) : stim_idx(i+1)) = mean_trace(stim_idx(i) : stim_idx(i+1)) - reduction_val;
    mean_trace(stim_idx(i)-5 : stim_idx(i)+5) = median_pre;
    mean_trace(stim_idx(i+1)-5 : stim_idx(i+1)+5) = median_pre;
end

subplot(7,1,6)
plot(t,mean_trace)
