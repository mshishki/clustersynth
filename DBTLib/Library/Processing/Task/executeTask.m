function [ theTaskOut, theOutput] = executeTask( theTask_theTaskHandle, theOutputListIn, theSettings, theWaitBarHandle, theTaskListIn)

if isstruct( theTask_theTaskHandle)
    %Task übergeben
    theTaskOut = theTask_theTaskHandle;
else
    %TaskHandle übergeben
    theTaskOut = getTask( theTask_theTaskHandle);
end

TaskHandleOut = getTaskHandleFromTask( theTaskOut);                                                    

%Input prüfen und ggfs. aufbauen
%----------------------
myInput = theTaskOut.Context.getInput( theTaskOut.Context, theOutputListIn);
if isempty( myInput.Input)
    if exist( 'theTaskListIn')
		myTaskNewInput = installInputByUser( TaskHandleOut, theOutputListIn, theTaskListIn);
	else
		myTaskNewInput = installInputByUser( TaskHandleOut, theOutputListIn);
	end
    if ~isempty( myTaskNewInput)
        %Task lokal übernehmen
        theTaskOut = myTaskNewInput;
		theTaskListIn( TaskHandleOut) = myTaskNewInput;
        %Input holen
        myInput = getInputFromTaskHandle( TaskHandleOut, theOutputListIn, theTaskListIn);
        %Wenn immer noch nicht gültig, dann Abbruch
        if isempty( myInput.Input)
            terminate();
        end
    end
        
end


%Message zum Algo und zu Inputs, waitbar
%----------------------
if ~isempty( myInput.Input)
    myNumInput = size( myInput.Input, 2);
else
    myNumInput = 1;
end
myInputString = [];
for i=1:myNumInput
    if ~isempty( myInput.Input)
        myStrExtension = '';
        % Check if image input
        if strcmp( myInput.Input( i).Input.Name, 'Image')
            myStrExtension = getImSizeInfo( myInput.Input( i).Input);
        end
        myInputString = append( myInputString, [ myInput.Input( i).Input.Type, ':', myInput.Input( i).Input.Name, myStrExtension, ' | ']);
    end
end 
if ~isempty( myInputString)
    myInputString( end-1:end) = [];
end
myMessage = ['Executing ', 'Task[ ', num2str( TaskHandleOut), '] ', theTaskOut.Algo.Name, ' ', myInputString, '...'];
disp( myMessage);
%Waitbar aufrufen mit der Message
if( exist( 'theWaitBarHandle') && ~isempty( theWaitBarHandle))
    waitbarmessage( theWaitBarHandle, ['Executing ', 'Task[ ', num2str( TaskHandleOut), '] ', theTaskOut.Algo.Name, '...']);
end

%Algorithmus Aufruf
%----------------------
theTaskOut.Algo = theTaskOut.Algo.FuncPtr.execute( ...
                            theTaskOut.Algo, ...
                            theSettings, ...
                            myInput);

Output = getOutput( theTaskOut);
if ~isempty( Output)
% Output = theTaskOut.Algo.Data.Output.Output;
% if isfield( theTaskOut.Algo.Data, 'Output')
    

%Outputs als Figure darstellen:
%----------------------
    for i=1:size( Output, 2)
        if( strcmp( theTaskOut.View.FShowFigure, 'on') && ...
                        isfield( Output( i).Output.FuncPtr, 'buildFigure') && ...
                        ~isnumeric( Output( i).Output.FuncPtr.buildFigure) )
%                         isfield( Output( i).FuncPtr, 'buildFigure'))
            if( size( theTaskOut.View.FigureHandle, 2) >= i)
                %existiert evtl. schon
%                 FigureHandle = Output( i).FuncPtr.buildFigure( Output( i), ...
                FigureHandle = Output( i).Output.FuncPtr.buildFigure( Output( i).Output, ...
                                                            getApplicationData( 'Control.Display'), ...
                                                            theTaskOut.View.FigureHandle( i));
            else
                %existiert noch nicht -> neu erzeugen
%                 FigureHandle = Output( i).FuncPtr.buildFigure( Output( i), ...
                FigureHandle = Output( i).Output.FuncPtr.buildFigure( Output( i).Output, ...
                                                            getApplicationData( 'Control.Display'), ...
                                                            0);        
            end
			%Figure installieren und Menü anpassen
			theTaskOut = installFigureWithMenu( FigureHandle, theTaskOut, Output( i).Output.Type, i);
        end
    end
    %wird schon in buildFigure() gemacht:
    %installTask2Figure( theTaskOut.View.Figure, theTaskHandle);

%Output übergeben:
%----------------------
    if nargout > 1
        theOutput = theTaskOut.Algo.Data.Output.Output;
%         theOutput = theTaskOut.Algo.Data.Output;
    end
else
    if nargout > 1
        theOutput = [];
    end
end

%View erzeugen, falls gefordert und noch nicht vorhanden:
if strcmp( theTaskOut.View.FShowFigure, 'on') && ~hasFigure( theTaskOut.View.FigureHandle)
	
	FigureHandle = figure( 'Name', getTaskName( TaskHandleOut), 'NumberTitle', 'off');
			%Figure installieren und Menü anpassen
			theTaskOut = installFigureWithMenu( FigureHandle, theTaskOut, 'none', 1);%'none': kein Output Typ, 1: Index=1 weil einzige Figure
end

