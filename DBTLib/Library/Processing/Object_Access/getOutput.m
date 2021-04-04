function theOutput = getOutput( theTask_theTaskHandle)

if isstruct( theTask_theTaskHandle)
    %Task �bergeben:
    myTask = theTask_theTaskHandle;
else
    %TaskHandle �bergeben:
    myTask = getTask( theTask_theTaskHandle);
end

if isfield( myTask.Algo.Data, 'Output')
    theOutput = myTask.Algo.Data.Output.Output;
else
    theOutput = [];
end
