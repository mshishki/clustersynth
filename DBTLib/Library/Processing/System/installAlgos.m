function theAlgoList = installAlgos()

theAlgoList = [];

theAlgoList = append( theAlgoList, algoOpenImage_new());
theAlgoList = append( theAlgoList, algoDisplayImage_new());
theAlgoList = append( theAlgoList, algoResize_new());
theAlgoList = append( theAlgoList, algoCMOut_new());

% theAlgoList( 2) = algoAWB_new();
% theAlgoList( 3) = algoCMOut_new();

