function theAlgonameCellarray = getAllAlgoNames( theAlgoDirectoryPath)

theAlgonameCellarray( 1) = {'OpenImage'};
theAlgonameCellarray( 2) = {'Demosaic'};
theAlgonameCellarray( 3) = {'Resize'};
theAlgonameCellarray( 4) = {'AWBAnalysis'};
theAlgonameCellarray( 5) = {'RGBLin2LogLab'};
theAlgonameCellarray( 6) = {'ChannelSeparator'};
theAlgonameCellarray( 7) = {'ChannelMerger'};
theAlgonameCellarray( 8) = {'AutoExposure'};
theAlgonameCellarray( 9) = {'AutoWhiteBalance'};
theAlgonameCellarray( 10) = {'LogLab2RGBLin'};
theAlgonameCellarray( 11) = {'CMOut'};
theAlgonameCellarray( 12) = {'DisplayImage'};


% function theOutputListCellString = buildOutputList( theTaskList, theTaskPreString)
% 
% if ~exist( 'theTaskPreString')
%     theTaskPreString = '';
% end
% 
% theOutputListCellString = {};
% 
% NumTasks = size( theTaskList, 2);
% 
% for i=1:NumTasks
%     Algo = theTaskList( i).Algo;
%     if isfield( Algo.Data, 'Output') 
%         NumOutputs = size( Algo.Data.Output.Output, 2);
% 
%         for j=1:NumOutputs
%             Type = Algo.Data.Output.Output( j).Output.Type;
% %             Type = Algo.Data.Output.Output( j).Type;
% 
%             theOutputListCellString = append( theOutputListCellString, { getOutString( theTaskPreString, i, Algo, j, Type)});
%         end
%     end
% end
% 
%     
%     
% function theOutCellString = getOutString( theTaskPreString, theAlgoIndex, theAlgo, theOutIndex, theOutType)    
% Separator = ':';
% 
% theOutCellString = [ theTaskPreString, ...
%                             'T[', num2str( theAlgoIndex), ']', theAlgo.Name, Separator, ...
%                             'O[', num2str( theOutIndex), ']', theOutType];
