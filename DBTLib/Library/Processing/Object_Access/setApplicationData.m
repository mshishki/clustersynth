function setApplicationData( theDataName, theNewValue)
global Application

if exist( 'theDataName')
    % erst l�schen, ansonsten keine �nderung der Elementanzahl m�glich
	eval( [ 'Application.', theDataName, ' = [];']);	
    % neu schreiben:
	eval( [ 'Application.', theDataName, ' = theNewValue;']);
end
