function theTask = newTask( theAlgoName, theInputHandleArray)

%Algo:
myAlgoOutStr = ['algo', theAlgoName, '_new();'];
theTask.Algo = eval( myAlgoOutStr);

%Context:
theTask.Context = context_new( theInputHandleArray);

%View:
theTask.View = view_new();


