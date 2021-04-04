function [ theTaskListOut, theTaskNumber] = appendTask( theTaskListIn, theTask, theViewOnOff)

%Task anh�ngen
theTaskListOut = append( theTaskListIn, theTask);

NumTasks = size( theTaskListOut, 2);
%TaskHandle eintragen, damit der Algo den Task kennt
theTaskListOut( NumTasks) = setTaskHandle( theTaskListOut( NumTasks), NumTasks);
%setProperty( theTask.Algo, 'TaskHandle', NumTasks);

InputHandleArray = theTask.Context.InputHandleArray;
NumInputs = size( InputHandleArray, 1);

%SuccessorList der Vorg�nger erweitern
for i=1:NumInputs
    theTaskListOut( InputHandleArray( i, 1)).Context.Successors = ...
        append( theTaskListOut( InputHandleArray( i, 1)).Context.Successors, ...
                NumTasks);  %Wir h�ngen am Listenende dran
end

if( exist( 'theViewOnOff') && ~isempty( theViewOnOff))
    theTaskListOut( NumTasks).View.FShowFigure = theViewOnOff;
end
    

if nargout > 1
    theTaskNumber = NumTasks;
end