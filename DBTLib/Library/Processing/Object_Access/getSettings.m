function theSettings = getSettings( theTaskHandle)
global Application

%theTaskHandle ist unser Index
theSettings = Application.Settings( theTaskHandle);
