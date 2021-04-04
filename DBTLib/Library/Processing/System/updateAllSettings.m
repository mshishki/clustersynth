function updateAllSettings()
global Application

Application.Control = initializeControl( Application.Control.Algo.AlgoList);
Application.Settings = installSettings( Application.TaskList, Application.Control.Algo);
