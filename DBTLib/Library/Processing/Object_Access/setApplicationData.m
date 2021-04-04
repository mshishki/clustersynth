function setApplicationData( theDataName, theNewValue)
global Application

if exist( 'theDataName')
    % erst löschen, ansonsten keine Änderung der Elementanzahl möglich
	eval( [ 'Application.', theDataName, ' = [];']);	
    % neu schreiben:
	eval( [ 'Application.', theDataName, ' = theNewValue;']);
end
