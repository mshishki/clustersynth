function theDisplayImage = getDisplayImage( theImageObj, theDisplaySettings)

theDisplayImage = theImageObj.FuncPtr.buildDisplayImage( theImageObj.Data.ImageData, theDisplaySettings);
