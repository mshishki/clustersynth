function theTaskOut = setTaskHandle( theTask, theTaskHandle)
theTaskOut = theTask;

theTaskOut.Algo = setProperty( theTaskOut.Algo, 'TaskHandle', theTaskHandle);

