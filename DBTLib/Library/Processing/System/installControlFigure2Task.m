function theTaskOut = installControlFigure2Task( theControlFigureHandle, theTask)

theTaskOut = theTask;
theTaskOut.View.ControlFigureHandle = theControlFigureHandle;
installTask2Figure( theControlFigureHandle, getTaskHandleFromTask( theTask));

% closeReqFunc in Userdata installieren:
myCloseFunction = get( theControlFigureHandle, 'CloseRequestFcn');
installCloseFunc2Figure( theControlFigureHandle, myCloseFunction);

set( theControlFigureHandle, 'CloseRequestFcn', @myControlCloseReqFcn);


% --- Executes during object deletion, before destroying properties.
function myControlCloseReqFcn(hObject, eventdata, handles)
% hObject    handle to imResizerFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Application;

%Eintrag löschen
if exist( 'Application') && ~isempty( getTaskHandleFromFigure( hObject))
    Application.TaskList( getTaskHandleFromFigure( hObject)).View.ControlFigureHandle = 0;
end

myCloseFunction = getCloseFuncFromFigure( hObject);
if ~isempty( myCloseFunction)
	if( isa( myCloseFunction, 'function_handle'))
		myCloseFunction( hObject, eventdata);
	else
		eval( myCloseFunction);
	end
else
	%default close function
	closereq();
end
