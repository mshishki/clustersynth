function [ theOutputList, theTaskListOut] = executeTaskList( theTaskListIn, theSettingsList, ...
                                                            theFWaitBar, theStartTaskHandle, theOutputListIn, theFDisplayLastTask)
% Falls theOutputListIn==empty, dann wird die Datenstruktur neu aufgebaut,
% ansonsten werden nur die Elemente in theOutputListIn überschrieben
% Es wird nur die Kette ab theStartTaskHandle ausgeführt und auch nur die
% ausgeführten Tasks als theOutputList und theTaskListOut zurückgeliefert
try
	
% 	%Zeitmessung:
% 	tic();
	
    if exist( 'theStartTaskHandle')
        NumStart = theStartTaskHandle;
    else
        NumStart = 1;
    end
    if ~exist( 'theFDisplayLastTask')
        theFDisplayLastTask = 1;	%default: display last task of task list
    end
    if ~exist( 'theOutputListIn')
        theOutputListIn = struct( []);
    end
    
    %Wenn gefordert Waitbar installieren
    if( exist( 'theFWaitBar') && theFWaitBar)
        myWaitBar = waitbar( 0,'');
%        myWaitBar = waitbar( 0,'', 'CreateCancelBtn', 'terminate();');
    else 
        myWaitBar = [];
    end

    NumEnd = size( theTaskListIn, 2);
    NumLoop = NumEnd - NumStart + 1;
	
	if( theFDisplayLastTask)
		%der letzte Task wird angezeigt:
		theTaskListIn( NumEnd).View.FShowFigure = 'on';
	end
    %Schleife über alle Tasks:
	for TaskNr = NumStart:NumEnd
        [ theTaskListIn( TaskNr), Output] = executeTask( theTaskListIn( TaskNr), ...
                                    theOutputListIn, theSettingsList( TaskNr), myWaitBar, theTaskListIn);

        if isempty( theOutputListIn)
            clear( 'theOutputListIn');
        end 
        myOutput.Output = Output;
        theOutputListIn( TaskNr) = myOutput;
%         theOutputListIn( TaskNr) = Output;
%         %theOutputList = append( theOutputList, Output);
        clear( 'myOutput');
        
        %Waitbar updaten:
        if( ~isempty( myWaitBar))
            waitbar( (TaskNr-NumStart+1) / NumLoop, myWaitBar);
        end

    end
    
    if( ~isempty( myWaitBar))
        close( myWaitBar);
    end

    theOutputList = theOutputListIn( NumStart:size( theTaskListIn, 2));
    if nargout > 1
        theTaskListOut = theTaskListIn( NumStart:size( theTaskListIn, 2));
	end

% 	%Zeitmessung:
% 	toc();
	
catch
    %Outputs zurücksetzen:
    theOutputList = [];
    if nargout > 1
        theTaskListOut = [];
    end

    filterErrorLeica();
    
    close( myWaitBar);
end
