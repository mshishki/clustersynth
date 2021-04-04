function theInputHandleArray = getInputHandleArrayFromTaskList( theTypeList, theTaskList, theStartInputHandleArray)

NumInput = size( theTypeList, 1);
theInputHandleArray = [];

for i=1:NumInput
    if NumInput==1
        Title = ['Select Input:'];
    else
        Title = ['Select Input[ ', num2str( i), ']:'];
    end
    InputTypeList = theTypeList{ i, 1};
    
    if exist( 'theStartInputHandleArray') && ~isempty( theStartInputHandleArray)
        InputHandle = selectInputDialog( 'Title', Title, 'InputType', InputTypeList, ...
                                        'TaskList', theTaskList, ...
                                        'InputHandleArray', theStartInputHandleArray( i, :));
    else
        InputHandle = selectInputDialog( 'Title', Title, 'InputType', InputTypeList, ...
                                        'TaskList', theTaskList);
   end
                                    
    %Abbruch:
    if( isempty( InputHandle))
        theInputHandleArray = [];
		return;
%        terminate();
%        break;
    end

    %OK:
    theInputHandleArray( i, :) = InputHandle( 1, :);

end

