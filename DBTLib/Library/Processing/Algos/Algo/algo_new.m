function theAlgo = algo_new( theAlgoName)

theAlgo = object_new( theAlgoName);

%Link zum Task:
theAlgo.TaskHandle = 0;

theAlgo.FuncPtr.getSettings = 0;
theAlgo.FuncPtr.controldialog = 0;

theAlgo.FuncPtr.getInputTypeList = 0;

theAlgo.FuncPtr.execute = 0;

theAlgo.Data.InputType = 0;
theAlgo.Data.OutputType = 0;


