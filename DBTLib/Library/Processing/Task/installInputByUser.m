function theTaskOut = installInputByUser( theTaskHandle, theOutputList, theTaskList)
%optional: theOutputList, theTaskList

if ~exist( 'theTaskList')
	fUseGlobalTasklist = 1;
	myTask = getTask( theTaskHandle);
else
	fUseGlobalTasklist = 0;
	myTask = theTaskList( theTaskHandle);
end

myTypeList = myTask.Algo.FuncPtr.getInputTypeList();

if ~isempty( myTypeList)
    %Bis hier berechnete Taskliste:
    if exist( 'theOutputList')  %optionale Übergabe = Vorgabe von Output Inhalten
        if( fUseGlobalTasklist)
			myValidTaskList = buildTaskList( getApplicationData( 'TaskList'), theTaskHandle, theOutputList);
		else
			myValidTaskList = buildTaskList( theTaskList, theTaskHandle, theOutputList);
		end
    else
        if( fUseGlobalTasklist)
			myValidTaskList = buildTaskList( getApplicationData( 'TaskList'), theTaskHandle);
		else
			myValidTaskList = buildTaskList( theTaskList, theTaskHandle);
		end
    end
    InputHandleArray = getInputHandleArrayFromTaskList( myTypeList, myValidTaskList, myTask.Context.InputHandleArray);
    if ~isempty( InputHandleArray)
        myTask.Context = context_new( InputHandleArray);

        %Task zurückliefern und global installieren
        theTaskOut = myTask;
        if fUseGlobalTasklist
			setTask( myTask, theTaskHandle);
		end
    else
        theTaskOut = [];
    end
else
    theTaskOut = [];
end
        
