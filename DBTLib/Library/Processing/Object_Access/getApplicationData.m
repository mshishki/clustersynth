function theApplicationData = getApplicationData( theDataName)
% example: getApplicationData( 'Control.Algo') gibt Application.Control.Algo
% zur�ck
global Application

if exist( 'theDataName')% && isfield( Application, theDataName)
    %theApplicationData = getfield( Application, theDataName);
	theApplicationData = eval( [ 'Application.', theDataName]);
else
    theApplicationData = Application;
end
