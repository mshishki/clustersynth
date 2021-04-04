function theTaskList = installTasks()

theTaskList = struct( []);

[ theTaskList, myOpenTask] = appendTask( theTaskList, newTask( 'OpenImage', []));

%Demosaicking und Bildgröße:
[ theTaskList, myDemosaicTask] = appendTask( theTaskList, newTask( 'Demosaic', [ myOpenTask]), 'on');

[ theTaskList, myResizeTask] = appendTask( theTaskList, newTask( 'Resize', [ myDemosaicTask]), 'on');

%AWB Logik
[ theTaskList, myAWBAnalysisTask] = appendTask( theTaskList, newTask( 'AWBAnalysis', [ myResizeTask]));
%[ theTaskList, myAWBAnalysisTask] = appendTask( theTaskList, newTask( 'AWBAnalysis', [ myOpenTask]));

% %Streulichtkorrektur
% [ theTaskList, myFlareCorrectionTask] = appendTask( theTaskList, newTask( 'FlareCorrection', []));
% 
%RGBLin nach Lab wandeln und in Luminanz und Chrominanzsignale aufteilen:
[ theTaskList, myRGBLin2LogLabTask] = appendTask( theTaskList, newTask( 'RGBLin2LogLab', [ myResizeTask]));
%[ theTaskList, myRGBLin2LogLabTask] = appendTask( theTaskList, newTask( 'RGBLin2LogLab', [ myOpenTask]));
[ theTaskList, myLCSeparatorTask] = appendTask( theTaskList, newTask( 'ChannelSeparator', [ myRGBLin2LogLabTask]));
%Chrominanzsignale wieder zusammenfassen:
[ theTaskList, myChromMergerTask] = appendTask( theTaskList, newTask( 'ChannelMerger', [ myLCSeparatorTask, 2; myLCSeparatorTask, 3]));

% %Luminanzverarbeitung:
% [ theTaskList, myL_ScalerTask] = appendTask( theTaskList, newTask( 'Scaler', []));   %Logik
% % Input für die Luminanzverarbeitung (inkl. Berücksichtigung Soll-MTF)

[ theTaskList, myL_AutoExpoTask] = appendTask( theTaskList, newTask( 'AutoExposure', [ myLCSeparatorTask, 1]));

% [ theTaskList, myL_MTFManagementTask] = appendTask( theTaskList, newTask( 'MTFManagement', []));
% [ theTaskList, myL_ContrastManagementTask] = appendTask( theTaskList, newTask( 'ContrastManagement', []));
% 

% %Chrominanzverarbeitung:
[ theTaskList, myC_AWBTask] = appendTask( theTaskList, newTask( 'AutoWhiteBalance', [ myChromMergerTask, 1; myAWBAnalysisTask, 1]), 'on');
% [ theTaskList, myC_ChromManagementTask] = appendTask( theTaskList, newTask( 'ChromManagement', []));
% 
%Luminanz- und Chrominanz zu Lab-Bild zusammenfassen und nach RGBLin transformieren:
[ theTaskList, myLCMergerTask] = appendTask( theTaskList, newTask( 'ChannelMerger', [ myL_AutoExpoTask, 1; myC_AWBTask, 1]));
[ theTaskList, myLogLab2RGBLinTask] = appendTask( theTaskList, newTask( 'LogLab2RGBLin', [ myLCMergerTask]));

%Farbkorrektur und Farberscheinung anwenden:
[ theTaskList, myCMOutTask] = appendTask( theTaskList, newTask( 'CMOut', [ myLogLab2RGBLinTask]), 'on');
 
%Bildanzeige
theTaskList = appendTask( theTaskList, newTask( 'DisplayImage', [ myCMOutTask]), 'on');


