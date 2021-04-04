function updateSettings( theSettings, theTaskHandle)
global Application

%Settings übernehmen
Application.Settings( theTaskHandle) = theSettings;

