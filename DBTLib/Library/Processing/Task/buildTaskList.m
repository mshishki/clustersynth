function theValidTaskList = buildTaskList( theTaskList, theTaskHandle, theOutputList)
%optional: theOutputList; wird bei �bergabe in theValidTaskList als Outputs eingebaut 
    
if exist( 'theOutputList') && isempty( theOutputList)
    %Wenn �bergeben, soll auch was drinstehen
    theValidTaskList = [];
    return;
end

%die g�ltige TaskList f�r unseren Task kann nur aus vorangegangenen
%Tasks bestehen:
for i=1: theTaskHandle-1
    myTask = theTaskList( i);
    if( exist( 'theOutputList'))
        myTask.Algo.Data.Output = theOutputList( i);
    end
    theValidTaskList( i) = myTask;
end


    
