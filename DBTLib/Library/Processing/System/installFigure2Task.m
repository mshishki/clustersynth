function theTaskOut = installFigure2Task( theFigureHandle, theTask, theOutputIndex)

theTaskOut = theTask;
theTaskOut.View.FigureHandle( theOutputIndex) = theFigureHandle;

set( theFigureHandle, 'CloseRequestFcn', @myControlCloseReqFcn);



% --- Executes during object deletion, before destroying properties.
function myControlCloseReqFcn( hObject, eventdata, handles)
% hObject    handle to Figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Application;

if exist( 'Application') 
    UserData = get( hObject, 'UserData');
    if isfield( UserData, 'TaskHandle')
        %Index des FigureHandle in Task.View
        if( isfield( Application, 'TaskList') && ~isempty( Application.TaskList) && ...
				( size( Application.TaskList, 2) >= UserData.TaskHandle) && ...
                isfield( Application.TaskList( UserData.TaskHandle), 'View') && ...
                isfield( Application.TaskList( UserData.TaskHandle).View, 'FigureHandle') && ...
                    ~isempty( Application.TaskList( UserData.TaskHandle).View.FigureHandle))
            myIndex = find( Application.TaskList( UserData.TaskHandle).View.FigureHandle == hObject);
            %Eintrag löschen
            Application.TaskList( UserData.TaskHandle).View.FigureHandle( myIndex) = 0;
        end
    end
end

%default close function
closereq();




