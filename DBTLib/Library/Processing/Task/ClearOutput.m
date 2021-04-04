function theTaskList = ClearOutput( theTaskListIn)

if ~exist( 'theTaskListIn')
	fUseGlobalTasklist = 1;
	theTaskListIn = getApplicationData( 'TaskList');
else
	fUseGlobalTasklist = 0;
end

myNumTask = size( theTaskListIn, 2);
for i=1:myNumTask
	theTaskListIn( i).Algo.Data.Output.Output = [];
end

if 	fUseGlobalTasklist
	setApplicationData( 'TaskList', theTaskListIn);
end
theTaskList = theTaskListIn;