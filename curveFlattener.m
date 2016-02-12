function [flattenedTrace , y] = curveFlattener(trace , fitted)
    
    timeStamps = 1:numel(trace);
    %p = polyfit([1,numel(timeStamps)] , [trace(1) , trace(numel(timeStamps))] , 1);
    y = fitted(timeStamps);
    minY = min(y);
    flatY = y-minY;
    flattenedTrace = trace' - flatY;

