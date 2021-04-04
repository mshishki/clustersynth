function [ theTaskHandle, theTask] = getTaskHandleFromMenu( theMenuHandle)

theTaskHandle = getFieldOfUserData( theMenuHandle, 'TaskHandle');
if nargout > 1
    theTask = getTask( theTaskHandle);
end