function [flattenedTrace , y] = linearFlattener(trace)
    
    timeStamps = 1:numel(trace);
    %p = polyfit([1,numel(timeStamps)] , [trace(1) , trace(numel(timeStamps))] , 1);
    p = polyfit(timeStamps , trace, 1);
    y = polyval(p, timeStamps);
    minY = min(y);
    flatY = y-minY;
    flattenedTrace = trace - flatY;

