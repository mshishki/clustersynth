function theValidTaskList = buildTaskList( theTaskList, theTaskHandle, theOutputList)
%optional: theOutputList; wird bei Übergabe in theValidTaskList als Outputs eingebaut 
    
if exist( 'theOutputList') && isempty( theOutputList)
    %Wenn übergeben, soll auch was drinstehen
    theValidTaskList = [];
    return;
end

%die gültige TaskList für unseren Task kann nur aus vorangegangenen
%Tasks bestehen:
for i=1: theTaskHandle-1
    myTask = theTaskList( i);
    if( exist( 'theOutputList'))
        myTask.Algo.Data.Output = theOutputList( i);
    end
    theValidTaskList( i) = myTask;
end


    
