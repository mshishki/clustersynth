function updateSettings( theSettings, theTaskHandle)
global Application

%Settings �bernehmen
Application.Settings( theTaskHandle) = theSettings;

