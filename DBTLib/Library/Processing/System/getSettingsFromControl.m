function theSettingsList = getSettingsFromControl( theTaskList, theAlgoControl)

for TaskNr = 1:size( theTaskList, 2)
    theSettingsList( TaskNr) = theTaskList( TaskNr).Algo.FuncPtr.getSettings( theAlgoControl);    
end
